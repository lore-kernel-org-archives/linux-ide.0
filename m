From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issues with AHCI and SATAII using JMD360
Date: Sun, 07 May 2006 11:59:36 +0900
Message-ID: <445D6298.7090003@gmail.com>
References: <20060507043702.052e3f56.moritz-heiber@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:12942 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750736AbWEGDAI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 May 2006 23:00:08 -0400
Received: by nz-out-0102.google.com with SMTP id 13so955244nzn
        for <linux-ide@vger.kernel.org>; Sat, 06 May 2006 20:00:07 -0700 (PDT)
In-Reply-To: <20060507043702.052e3f56.moritz-heiber@arcor.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

Moritz Heiber wrote:
> Hello,
> 
> as I skimmed through the mailinglist archives I noticed that support
> for the JMD360 SATA chipset has just been added recently and so I went
> ahead and tried to make use of my motherboard's SATAII capabilities.
> Unfortunately, I did not succeed at it.
> 
> I'm using a ASRock 939Dual-SATA2 mainboard equipped with a JMD360 SATA
> controller chip. A Hitachi Deskstar 7K250 (HDT722516DLA380), which is
> supposed to support SATAII, is attached to the only available SATAII
> compliant socket using the correct cables. The harddrive is recognized
> correctly as SATAII device by the AMI BIOS (latest revision 1.8.0).

What does the BIOS say exactly?  SATA II is a vague term.  It comprises 
several features.  Some call NCQ-capable drives SATA-II while others 
consider 3.0Gbps link SATA-II.

> ata1: SATA link up 1.5 Gbps (SStatus 113)
> ata1: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469 86:3c01 87:4763 88:407f
> ata1: dev 0 ATA-7, max UDMA/133, 321672960 sectors: LBA48
> ata1: dev 0 configured for UDMA/133
> scsi0 : ahci
>   Vendor: ATA       Model: HDT722516DLA380   Rev: V43O
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3 sda4
> sd 0:0:0:0: Attached scsi disk sda
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> 
> ------
> 
> (I see repeated output there ..)

That's a SCSI feature, cough, bug.  It has been like that for as long as 
I can remember and for some reason it stays that way.  My eyes are now 
selectively blind to those duplicate messages.

> I'm running 2.6.16.14 without any apparent patches (obviously
> through Lunar Linux).
> 
> So I'm wondering, is it just me .. or might the driver actually do
> something wrong here? Could it be a mismatching PCI_ID?
> 
> Any hints on how I'd be able to solve this problem would be highly
> appreciated. I can, of course, provide more data or apply some further
> testing incase you want me to.

I've googled and the drive does support 3Gbps.  There are several 
possibilities.

* jumper on the drive which limits it to 1.5Gbps is closed

* both the controller and drive support 3Gbps but somehow they fail to 
negotiate at that speed.

* BIOS limits link spd to 1.5Gbps using SControl in the hope for 
improving compatibility

More info can be obtained by printing SCR_CONTROL, just print the result 
of scr_read(ap, SCR_CONTROL) from libata.c::sata_print_link_status(), 
which prints the SStatus value.

Whatever the reason is, don't torture yourself over it.  It simply isn't 
worth.  1.5Gbps is more than enough for any drive on market today.

> Please CC me as I'm not subscribed to the linux-ide mailinglist.
> Thank you for your time and patience.

You don't need to request this.  It's how any linux mailing list works.

-- 
tejun
