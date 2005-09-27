From: admin <jkrzyz@wprost.pl>
Subject: Re: Promise SATA150 SX4 strange Port1 Issue
Date: Tue, 27 Sep 2005 17:49:37 +0200
Message-ID: <43396A11.3060003@wprost.pl>
References: <089001c5c372$de586430$1e0a1eac@mmoretti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.wprost.pl ([62.233.203.3]:9221 "EHLO hera.wprost.pl")
	by vger.kernel.org with ESMTP id S964984AbVI0Ptr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Sep 2005 11:49:47 -0400
In-Reply-To: <089001c5c372$de586430$1e0a1eac@mmoretti>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ruben Moretti <moretti@labor-enders.de>
Cc: linux-ide@vger.kernel.org


Hi.

I have same errors running 2.6.13 kernel (without any patches except pci 
id fix) on server with two Fasttrack 4300tx and 8 disks.

Sep 20 20:53:11 espresso kernel: ata4: status=0x51 { DriveReady 
SeekComplete Error }
Sep 20 20:53:11 espresso kernel: ata4: called with no error (51)!
Sep 20 21:32:47 espresso kernel: ata7: status=0x51 { DriveReady 
SeekComplete Error }
Sep 20 21:32:47 espresso kernel: ata7: called with no error (51)!

Fortunatelly without following scsi errors.

Before  I patched libata with 2.6.13-rc7-libata1.patch and got this:

Sep 21 22:39:01 espresso kernel: ata1: translated ATA stat/err 0x25/00 
to SCSI SK/ASC/ASCQ 0x4/00/00
Sep 21 22:39:01 espresso kernel: ata1: status=0x25 { DeviceFault 
CorrectedError Error }
Sep 21 22:39:01 espresso kernel: SCSI error : <0 0 0 0> return code = 
0x8000002


> ata4: status=0x51 { DriveReady SeekComplete Error }
> ata4: called with no error (51)!


