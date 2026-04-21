# Zephyr Sky 개발 및 배포 가이드라인 (DEVELOPMENT_GUIDE.md)

이 문서는 Zephyr Sky 프로젝트의 일관된 개발 흐름과 안정적인 배포를 위해 반드시 준수해야 할 지침을 담고 있습니다.

## 1. 프로젝트 철학 및 아키텍처
- **디자인 철학**: "Sophisticated Minimalist" - 불필요한 정보를 배제하고 유려한 그라데이션 UI를 지향합니다.
- **아키텍처**: Clean Architecture 구조를 따릅니다.
    - `core/`: 공통 유틸리티, 테마, 서비스 초기화
    - `data/`: 데이터 소스(API), 리포지토리 구현체, 모델
    - `domain/`: 엔티티, 리포지토리 인터페이스, 유스케이스
    - `presentation/`: UI(Screens, Widgets), 상태 관리(Providers)

## 2. 개발 표준 및 코딩 규칙
- **언어 및 프레임워크**: Flutter (Dart)를 사용하며, 최신 안정화 버전(Stable channel)을 유지합니다.
- **상태 관리**: `Provider`를 기본으로 사용하며, 비즈니스 로직과 UI를 엄격히 분리합니다.
- **지역화(Localization)**: `intl` 패키지를 사용하여 `ko_KR` 로케일을 지원하며, 날씨 데이터 초기화 시 반드시 포맷팅 설정을 확인합니다.
- **커밋 메시지 규칙**: 
    - `feat:` 새로운 기능 추가
    - `fix:` 버그 수정
    - `docs:` 문서 수정 (HISTORY.md, DEPLOYMENT.md 등)
    - `refactor:` 코드 리팩토링
    - **언어**: 모든 커밋 메시지는 **한글**로 작성하여 직관적인 이력 관리를 도모합니다.

## 3. 안드로이드 빌드 최적화
- **Target SDK**: 최신 규격(SDK 36 이상)을 준수합니다.
- **R8 (난독화/최적화)**:
    - 릴리즈 빌드 시 클래스 누락 방지를 위해 `android/app/proguard-rules.pro` 규칙을 유지합니다.
    - 특히 `com.google.android.play.core` 관련 경고 무시 규칙이 포함되어야 합니다.
- **패키지명**: `com.jeiel.zephyr_sky`를 일관되게 사용하며, `build.gradle.kts`와 `MainActivity.kt`의 경로가 일치해야 합니다.

## 4. CI/CD 프로세스 (GitHub Actions)

### 4.1 앱 릴리즈 (`release.yml`)
- **트리거**: `v*` 형태의 태그 푸시 (예: `v1.0.5`)
- **수행 작업**:
    1. Flutter 환경 구축 및 의존성 설치
    2. 테스트 실행
    3. APK 및 AAB 빌드 (빌드 번호는 실행 번호와 연동)
    4. GitHub Release 생성 및 결과물 자동 업로드

### 4.2 브랜드 페이지 배포 (`pages.yml`)
- **트리거**: `main` 브랜치 푸시 (특히 `website/` 폴더 변경 시) 또는 수동 실행(`workflow_dispatch`)
- **중요 설정**: GitHub 저장소의 **Settings > Pages > Source**가 반드시 **"GitHub Actions"**로 설정되어 있어야 합니다.
- **배포 대상**: `website/` 폴더 내의 정적 파일 (`index.html`, `favicon.png` 등)

## 5. 이력 및 문서 관리
- **HISTORY.md**: 세션 종료 전 또는 주요 기능 완료 시 반드시 작업 내용을 갱신합니다.
- **DEPLOYMENT.md**: 배포 상태와 스토어 등록 정보를 최신화합니다.
- **작업 완료 후**: 모든 로컬 변경 사항은 즉시 원격 저장소(`main` 브랜치)로 푸시하여 동기화합니다.

## 6. 주요 문제 해결 사례 (Troubleshooting)
- **LocaleDataException**: `main.dart`에서 `initializeDateFormatting` 호출 여부를 확인하세요.
- **Android 크래시**: 패키지명 불일치 또는 `AndroidManifest.xml` 내 필수 권한(`POST_NOTIFICATIONS` 등) 누락을 확인하세요.
- **Pages 빌드 실패**: 워크플로우 내 `permissions` 설정과 GitHub 저장소의 Pages 배포 방식(Source) 설정을 대조하세요.
