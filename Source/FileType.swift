//
//  FileType.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 7/22/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

public enum FileType {
    
    case Regular
    case Directory
    case BlockSpecial
    case CharacterSpecial
    case Fifo
    case Socket
    case SymbolicLink
    
    public init() { self = .Regular }
}