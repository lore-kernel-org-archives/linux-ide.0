From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Libata PATA status
Date: Tue, 3 Jul 2007 23:04:26 -0400
Message-ID: <1D2B5126-1238-48F8-B841-E8F77C9A0F1B@mac.com>
References: <20070703185116.59c8f5f5@the-village.bc.nu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758117AbXGDDEt@vger.kernel.org>
In-Reply-To: <20070703185116.59c8f5f5@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org
List-Id: linux-ide@vger.kernel.org

On Jul 03, 2007, at 13:51:16, Alan Cox wrote:
> Libata General with respect to PATA
> ====================================
>
> [...snip...]
>
> Chipsets
> ========
>
> [...snip...]

I'd love to try to poke holes in the libata PATA support, but sadly  
it doesn't look like any of my systems built-in ATA chipsets are  
supported yet.  Has anyone started a rewrite of the PPC/PowerMac IDE  
driver?  The current one is in "drivers/ide/ppc/pmac.c", and supports  
these chipsets:
   OHare ATA
   Heathrow ATA
   KeyLargo ATA-3
   KeyLargo ATA-4
   UniNorth ATA-6 (IE: Kauai)
   K2 ATA-6
   Shasta ATA-6

I'd be willing to test drivers for the UniNorth ATA-6 and K2 ATA-6,  
as well as possibly the KeyLargo ATA-3/4, depending on what the old  
MDD G4 in my closet has.  Sadly my libata-foo is insufficient for me  
to do anything useful (other than thoroughly testing my backup- 
restoration procedure, maybe :-D).

Cheers,
