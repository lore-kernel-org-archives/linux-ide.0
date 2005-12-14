From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Problems in the SiS IDE driver
Date: Wed, 14 Dec 2005 22:12:16 +0100
Message-ID: <20051214211216.GA6045@corona.suse.de>
References: <1134587705.25663.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932344AbVLPQCs@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1134587705.25663.67.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Dec 14, 2005 at 07:15:05PM +0000, Alan Cox wrote:
> I've been writing/porting over SIS support to the libata code and in
> doing so I've hit a couple of corner cases that appear broken in the SiS
> code in ide/pci. 
> 
> If you have a prehistoric device that only does PIO0 and you plug it
> into the SiS IDE ports then the earlier SiS (pre ATA133) drivers don't
> have cases for PIO0. Fortunately PIO0 only devices are kind of rare
> nowdays.
> 
> The early SiS loads 0 into both timing registers. I'm not sure if that
> is a bug or correct behaviour that isn't commented.

This is correct. 0's on SiS mean PIO0 timing.

> The ATA100
> generation however stuff an unset 16bit variable into the timing
> registers which seems to be very wrong indeed.
> 
> viz:
> 
> test1 is unset on entry
> 
>             switch(timing) { /*             active  recovery
>                                                   v     v */
>                         case 4:         test1 = 0x30|0x01; break;
>                         case 3:         test1 = 0x30|0x03; break;
>                         case 2:         test1 = 0x40|0x04; break;
>                         case 1:         test1 = 0x60|0x07; break;
>                         default:        break;
>                 }
>                 pci_write_config_byte(dev, drive_pci, test1);
> 
> 
> And timing can be zero....
> 
> Would be useful to know if this is a bug, and also what the correct
> behaviour is at this point as I don't have all the SiS data sheets.

This is a bug - test1 should be initialized to 0.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
