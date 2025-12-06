# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**NewsLingo** is a HarmonyOS application built with ArkTS demonstrating modern layout techniques and UI patterns for news applications. The project showcases responsive and adaptive design patterns using HarmonyOS 6.0.1 SDK.

## Build Commands

### Development Build
```bash
hvigorw assembleApp --mode debug
```

### Production Build
```bash
hvigorw assembleApp --mode release
```

### Clean Build
```bash
hvigorw clean
```

### Install Dependencies
```bash
ohpm install
```

## Testing Commands

### Run Unit Tests
```bash
hvigorw test
```

### Run Specific Module Tests
```bash
# Test common module
hvigorw :common:test

# Test responsive layout module
hvigorw :responsiveLayout:test

# Test adaptive layout module
hvigorw :adaptiveLayout:test
```

### Run Integration Tests (ohosTest)
```bash
hvigorw :default:ohosTest
```

## Architecture Overview

### Module Structure
The project uses a feature-based modular architecture with four main modules:

1. **`products/default`** - Main application entry point and navigation
2. **`common`** - Shared utilities, constants, and breakpoint system
3. **`features/responsiveLayout`** - Responsive layout demo with tabs and grid components
4. **`features/adaptiveLayout`** - Adaptive layout demo with interactive components

### Key Architectural Patterns

#### Component Architecture
- **@Entry** decorators for page entry points
- **@Component** decorators for reusable UI components
- **StorageLink** for state management across components
- **ForEach** for efficient list rendering with lazy loading

#### Responsive Design System
- **BreakpointSystem** from common module provides breakpoint management (xs, sm, md, lg)
- **GridRow/GridCol** components for responsive grid layouts
- Dynamic component properties based on device characteristics
- Tab positioning and orientation adaptation

#### Navigation Pattern
- Router-based navigation using `router.pushUrl()`
- Centralized routes in `constants/RouteConstants.ets`
- Parameter passing between pages via navigation options

#### State Management
- **ViewModel** pattern with separate view model classes
- **@Observed** and **@Track** decorators for reactive state
- Centralized data management in view model classes

## Key Files and Components

### Main Application (`products/default/src/main/ets/`)
- **`pages/Index.ets`** - Application entry point with navigation list
- **`view/CatalogueListComponent.ets`** - Navigation component using GridRow layout
- **`viewmodel/CatalogueViewModel.ets`** - Navigation data management
- **`constants/CommonConstants.ets`** - Grid layout constants and styling
- **`constants/RouteConstants.ets`** - Navigation route definitions

### Feature Modules
- **`features/responsiveLayout/pages/ResponsiveLayout.ets`** - Main responsive demo
- **`features/responsiveLayout/viewmodel/TabsViewModel.ets`** - Tab management
- **`features/adaptiveLayout/pages/AdaptiveLayout.ets`** - Adaptive demo with sliders
- **`features/adaptiveLayout/view/SliderComponent.ets`** - Interactive layout controls

### Common Utilities (`common/src/main/ets/`)
- **`utils/BreakpointSystem.ets`** - Responsive breakpoint management
- **`utils/Logger.ets`** - Centralized logging utility

## Development Guidelines

### Component Development
- Use ArkTS decorators (@Entry, @Component, @Observed, @Track)
- Follow the MVVM pattern with separate view models
- Implement responsive design using the BreakpointSystem
- Use GridRow/GridCol for layout structure

### State Management
- Use StorageLink for persistent state across components
- Implement view models for complex state logic
- Use @Observed/@Track for reactive updates

### Styling
- Use HarmonyOS system resources (`$r('sys.color.*')`, `$r('sys.font.*')`)
- Follow accessible color schemes and typography
- Implement responsive spacing and sizing

### Testing
- Write unit tests in `src/test` directories
- Write integration tests in `src/ohosTest` directories
- Use @ohos/hypium framework with describe/it/expect pattern
- Use @ohos/hamock for mocking in tests

## Module Dependencies

- **default** module depends on: @ohos/common, @ohos/adaptivelayout, @ohos/responsivelayout
- **responsiveLayout** module depends on: @ohos/common
- **adaptiveLayout** module has no external dependencies
- **common** module has no external dependencies

## Build Configuration

- **Target SDK**: HarmonyOS 6.0.1(21)
- **Build System**: Hvigor (TypeScript-based)
- **Package Name**: tech.aowu.newslingo
- **Testing Framework**: @ohos/hypium with @ohos/hamock for mocks