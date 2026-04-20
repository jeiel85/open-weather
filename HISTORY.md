# 프로젝트 이력 관리 (HISTORY.md)

## [2026-04-20] 프로젝트 시작 및 초기 설정

### 작업 내용
- Flutter (Dart)를 프레임워크로 선정하고 프로젝트 `open_weather` 초기화.
- Open-Meteo API를 날씨 데이터 소스로 결정.
- 미니멀리즘 디자인 철학 및 상태바 알림 기능 명세 수립.
- Git 저장소 설정 및 초기 파일 구조 생성 완료.
- `HISTORY.md`를 통한 이력 관리 체계 구축.

### 현재 상태
- Flutter 프로젝트 초기화 및 Clean Architecture 구조 수립 완료.
- `shared_preferences`를 이용한 안정적인 로컬 저장소 체계 구축.
- 안드로이드 빌드 환경 최적화 (SDK 36 강제 적용 및 Desugaring 활성화).
- 실기기(SM-S921N) 설치 및 GitHub 저장소 동기화 완료.
- 앱 실행 시 `LocaleDataException` 발생 확인 (다음 세션 수정 예정).

## [2026-04-20] 빌드 안정화 및 실기기 배포

### 작업 내용
- 빌드 충돌을 일으키는 `Isar`를 `shared_preferences`로 대체하여 빌드 안정성 확보.
- Android 14+ 및 최신 플러그인 호환을 위한 `compileSdk 36` 설정 적용.
- GitHub 원격 저장소(`jeiel85/open-weather`) 연동 및 코드 푸시.
- 릴리스 모드 APK 빌드 및 실제 안드로이드 기기 설치 완료.
- 런타임 오류(로케일 데이터 미초기화) 진단 및 다음 작업 계획 수립.
