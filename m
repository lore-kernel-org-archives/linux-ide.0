From: "Art Haas" <ahaas@airmail.net>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't apply)
Date: Sat, 3 Feb 2007 08:35:07 -0600
Message-ID: <20070203143507.GE2933@artsapartment.org>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:46750 "EHLO
	ms-smtp-01.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946463AbXBCOf0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 09:35:26 -0500
Received: from pcdebian (cpe-68-201-223-150.houston.res.rr.com [68.201.223.150])
	by ms-smtp-01.texas.rr.com (8.13.6/8.13.6) with ESMTP id l13EZGlG003476
	for <linux-ide@vger.kernel.org>; Sat, 3 Feb 2007 08:35:25 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <45C3EECF.2080100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Sat, Feb 03, 2007 at 11:09:19AM +0900, Tejun Heo wrote:
> (cc'ing Albert, Mark and Sergei.  Hi!)
> 
> Art Haas wrote:
> > Hi. Sorry to say the CD-ROM is still not found. Full 'dmesg' output
> > listed below in hopes it provides clues.
> 
> Erggghh.. I'm sorry too.  I thought I found it this time.
> 
> > ata_piix 0000:00:07.1: version 2.00ac7
> > ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> 
> You have UDMA/33 PATA port.
> 
> > ata2.00: ATAPI, max MWDMA1
> 
> The initial reset and PACKET_IDENTIFY went well.
> 
> > ata2.00: revalidation failed (errno=-2)
> 
> Then, PACKET_IDENTIFY after configuring transfer mode fails with
> -ENOENT.  Meaning it saw (status & (ATA_BUSY|ATA_DRQ|ATA_ERR|ATA_DF)) ==
> 0 in HSM_ST.
> 
> libata resets silently and tries to revalidate the device.
> 
> > ata2.00: limiting speed to PIO4
> > ata2: failed to recover some devices, retrying in 5 secs
> > ata2.00: revalidation failed (errno=-2)
> > ata2.00: limiting speed to PIO0
> > ata2: failed to recover some devices, retrying in 5 secs
> > ata2.00: revalidation failed (errno=-2)
> > ata2.00: disabled
> 
> All of those tries fail and libata gives up the device.
> 
> * Something went wrong with mode programming.  It seems pretty old
> (reporting max UDMA/33).  Art, can you post the result of 'lspci -nn'?

Here you are ...

# lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge [8086:7190] (rev 02)
00:01.0 PCI bridge [0604]: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge [8086:7191] (rev 02)
00:07.0 ISA bridge [0601]: Intel Corporation 82371AB/EB/MB PIIX4 ISA [8086:7110] (rev 02)
00:07.1 IDE interface [0101]: Intel Corporation 82371AB/EB/MB PIIX4 IDE [8086:7111] (rev 01)
00:07.2 USB Controller [0c03]: Intel Corporation 82371AB/EB/MB PIIX4 USB [8086:7112] (rev 01)
00:07.3 Bridge [0680]: Intel Corporation 82371AB/EB/MB PIIX4 ACPI [8086:7113] (rev 02)
00:08.0 VGA compatible controller [0300]: S3 Inc. ViRGE/DX or /GX [5333:8a01] (rev 01)
00:0a.0 Ethernet controller [0200]: D-Link System Inc RTL8139 Ethernet [1186:1300] (rev 10)
#

Please let me know of anything thing else I can send that may help.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
