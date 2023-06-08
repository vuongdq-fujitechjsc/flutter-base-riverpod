# flutter_base_riverpod

A Flutter base source about Riverpod

## Getting Started
Using Libaries
1. State-management: riverpod
2. Route: go-router
3. Json & Mapper: freezed, json
4. Networking: dio
5. Localization: intl
6. Storage local: shared_preferences
7. Database: sqflite

### Architecture Diagram
![Clean-architecture](./Clean-Architecture.png)

### Folder Structure
```
libs/
    - data/                                         <--- data layer
        - database/                                 <--- handle database
        - entity/
        - mapper/
        - repositories/                             <--- repository implement
    - domain/                                       <--- domain layer
        - models/                                   
        - repositories/                             <--- repository interface
        - usecases/
    - presentation/                                 <--- presentation layer
        - features/                                 <--- contains all feature of application
        - state/                                    <--- define state class
    - shared/                                       <--- folder contains code shared across features
        - configs/                                  <--- config environment
        - extensions/
        - networking/                               <--- handle networking
        - routes/                                   <--- config all router of application
        - storage/                                  <--- storage local - shared_preferences
        - themes/
        - widgets/
    - main.dart                                     <--- entry point
```



