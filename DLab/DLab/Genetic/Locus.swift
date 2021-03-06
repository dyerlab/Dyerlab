//
//  File.swift
//  Genetics
//
//  Created by Rodney Dyer on 2/3/18.
//  Copyright © 2018 Rodney Dyer. All rights reserved.
//


import Foundation
import Accelerate

	

/**
 The base class for a genotype
 
 This is the base class for a genotype.  Alleles are represented as `String` objects
 allowing numeric or alphabetical (or emoji if you need it) represnttion.
 
 - Author: Rodney J. Dyer
*/
public class Locus {
    public var alleles: [String]
    public var ploidy: Int {
        get {
            return alleles.count
        }
    }
    
    
    /**
     Default init() routine
     
     This method instantiates a <i>Locus</i> object.
     
     - Parameters:
        - vals: Either an array of string values OR if it is only one
     entry long, it tries to split vals on ":"
     
     - Returns: Locus A fully constructed Locus object.
     */
    public init(_ vals: [String]){
        let alleles = vals.filter {$0 != "" }
        if alleles.count == 1 && alleles[0].contains(":") {
            self.alleles = vals[0].components(separatedBy: ":")
        }
        else {
            self.alleles = alleles.sorted()
        }
    }
    
    /**
     Heterozygosity flag
     
     Defined as true only if there are more than one allele at the locus (e.g.,
     haploids will never return true.
     
     - Returns: Bool Indicating more than one allele.
     */
    public func isHeterozygote() -> Bool {
        return NSSet(array: self.alleles).allObjects.count > 1
    }
    
    /// Returns Empty Locus object flag
    public func isEmpty() -> Bool {
        return self.alleles.count == 0
    }
    
}


// MARK: Conversions

extension Locus {
    
    /**
     Converts locus into a Vector object.
     */
    public func asVector( alleles: [String], standardized: Bool = false ) -> Vector {
        var ret = Vector(repeating:0.0, count: alleles.count )

        for allele in self.alleles {
            if let idx = alleles.index(of: allele) {
                ret[idx] += 1.0
            }
        }
        if standardized {
            let tot = ret.reduce(0, +)
            return ret.map { $0 / tot }
        }
        else {
            return ret
        }
    }
    
}


// MARK: CustomStringConvertible

extension Locus: CustomStringConvertible {

    /// Overload on description for printing
    public var description : String {
        get {
            return( self.alleles.joined(separator: ":"))
        }
    }
}


// MARK: Equatable

extension Locus: Equatable {
    
    /// Overload equality operator
    public static func == ( left: Locus, right: Locus ) -> Bool {
        return left.alleles == right.alleles
    }
    
    /// Overloaded inequality operator
    public static func != ( left: Locus, right: Locus ) -> Bool {
        return !(left == right)
    }
}


