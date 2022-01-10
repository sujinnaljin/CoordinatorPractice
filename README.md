# CoordinatorPractice
- 발표 자료는 레포지토리 내의 `Coordinator.key` 에서 확인할 수 있습니다.

## Coordinator

- 기존 VC 역할 너무 많음

  - User interface design
  - Updating views with model data
  - Responding to user input
  - Saving and restoring state
  - Data sources and delegates
  - Animation
  - Networking
  - **Navigation** ---------> Coordinators

- **VC 의 화면 이동을 다른 애 맡기자!** 해서 등장한게 **코디네이터** 패턴

  ![image](https://user-images.githubusercontent.com/20410193/148721700-c032ac51-6c2a-48f4-908a-440756df52fd.png)

  ![image](https://user-images.githubusercontent.com/20410193/148721707-3f76fcce-a84f-42be-aba5-682cc4b576e8.png)

- 코디네이터는 아래의 기능을 수행

  - ViewController, ViewModel, Reactor 등의 화면 단위에 사용하는 **클래스를 인스턴스화**
  - ViewController, ViewModel, Reactor 등의 인스턴스에 **종속성** 삽입
  - ViewController 를 **화면에 표시**하거나 **push**

- 화면 이동 담당해야하니까 코디네이터가 UINavigationController 소유

  ![image](https://user-images.githubusercontent.com/20410193/148721811-fa2fc6c0-5f81-4b0c-bdcc-4bcd3c7422e5.png)

- 예시

  ```swift
  class Coordinator {
      let navigationController: UINavigationController?
      
      init(navigationController: UINavigationController?) {
          self.navigationController = navigationController
      }
      
      func goSingIn() {
          let signIn = SignInViewController.instantiate() //인스턴스화
          //필요하다면 여기서 종속성 주입
          navigationController?.pushViewController(signIn, animated: true) //이동
      }
      
      func goSetting() {
          let setting = SettingViewController.instantiate()
          navigationController?.pushViewController(setting, animated: true)
      }
  }
  ```

- 코디네이터의 속성은 아래와 같음

  - coordinator 별로 하나 또는 그 이상의 View Controller를 보유
  - 각 coordinator는 일반적으로 “**start**”라고 불리는 메서드를 사용하여 View Controller를 표시
  - 각 View Controller에는 coordinator에 대한 **delegate** reference가 있음
  - 각 coordinator는 **child** coordinators 배열을 가지고 있음
  - 각 child coordinator는 **parent** coordinator에 대한 delegate reference가 있음

  ```swift
  protocol Coordinator: AnyObject {
      var navigationController: UINavigationController { get set }
      var parentCoordinator: Coordinator? { get set }
      
      func start()
      func start(coordinator: Coordinator)
      func didFinish(coordinator: Coordinator)
      func removeChildCoordinators()
  }
  
  class BaseCoordinator: Coordinator {
      var childCoordinators: [Coordinator] = []
      var parentCoordinator: Coordinator?
      var navigationController: UINavigationController
      
      init(navigationController: UINavigationController) {
          self.navigationController = navigationController
      }
      
      func start() {
          fatalError("Start method must be implemented")
      }
      
      func start(coordinator: Coordinator) {
          childCoordinators.append(coordinator) //addDependency
          coordinator.parentCoordinator = self
          coordinator.start()
      }
      
      //자기 자신 pop 됐을때 parentCoordinator?.didFinish(coordinator: self) 이런식으로
      func didFinish(coordinator: Coordinator) {
          if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
              childCoordinators.remove(at: index)
          }
      }
      
      //다른걸로 넘어갈때 다른 vc 지우는 용도
      func removeChildCoordinators() {
          childCoordinators.forEach { $0.removeChildCoordinators() }
          childCoordinators.removeAll()
      }
  }
  
  enum Transition {
      case signIn
      case setting
  }
  
  class MainCoordinator: BaseCoordinator {
  
      override func start() {
          let main = ViewController.instantiate()
          main.coordinator = self
          navigationController.pushViewController(main, animated: true)
      }
      
      func performTransition(to transition: Transition) {
          switch transition {
          case .signIn:
              removeChildCoordinators()
              let coordinator = SignInCoordinator(navigationController: navigationController)
              start(coordinator: coordinator)
          case .setting:
              removeChildCoordinators()
              let coordinator = SettingCoordinator(navigationController: navigationController)
              start(coordinator: coordinator)
          }
      }
  }
  ```

- 많은 레퍼런스를 찾아볼 때 다들 코디네이터 패턴이 중구난방이긴 한디,, 일단 나는 앱이 커지면 **하나의** **VC** **가** **하나의** **Coordinator** 를 갖고 있는걸로 이해했을때, 각 코디네이터의 역할은

  1. **자신을** **시작**하는 걸 담당 (start). **자신으로** **들어오는** **통로**.. 포털의 역할

  2. 자신이 **어딜로** **갈** **수** **있느냐**를 담당. 

  예를 들어 A_ViewController의 A_Coordinator는

  1. A_ViewController를 **생성해서** **이곳으로** **이동**할 수 있게 하고,
  2. A_ViewController에서 B_ViewController로 갈 수 있다면 **B_Coordinator**를 통해 그곳으로 이동

- 코디네이터 패턴의 장점
  - 화면간 연결을 더 쉽게 관리 가능
  - VC 더 쉽게 재사용 가능
  - 계층 관리 용이
  - VC가 만들어질 때 의존성 주입(DI)를 통해서 사용할 수 있음

# 출처
- [간단한 예제로 살펴보는 iOS Design/Architecture Pattern: Coordinator - Basic](https://lena-chamna.netlify.app/post/ios_design_pattern_coordinator_basic/)
- [[Swift] Coordinator Pattern (1/2) - 기본원리](https://nsios.tistory.com/48)
- [[디자인 패턴][swift] Coordinator pattern](https://medium.com/@jang.wangsu/%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4-swift-coordinator-pattern-426a7628e2f4)
- [Coordinator Pattern](https://velog.io/@ellyheetov/Coordinator-Pattern)
- [Deeplink with coordinators](https://www.iamin.dev/Deeplink-with-coordinators/)
- [How to use the coordinator pattern in iOS apps](https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps)
