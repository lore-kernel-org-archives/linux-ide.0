From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: problems with libata and ICH5 chipset.
Date: Sat, 19 Jun 2004 13:50:37 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40D47CED.3040601@pobox.com>
References: <40D4792C.5030702@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30168 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264348AbUFSRvS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Jun 2004 13:51:18 -0400
In-Reply-To: <40D4792C.5030702@superbug.demon.co.uk>
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-ide@vger.kernel.org

James Courtier-Dutton wrote:
> I am using kernel 2.6.7.
> I enclose an extract from dmesg below.
> I have 2 PATA devices, one DVD-ROM, one DVD-writer on ata1. (or hda and 
> hdb)
> I also have 2 SATA devices, both Hard Discs.
> When I boot without libata enabled, and just use:-
> ATA/ATAPI/MFM/RLL support ->  Intel PIIXn chipsets support
> I get access to: -
> hda - PATA DVD-Writer
> hdb - PATA DVD-ROM
> hdc - SATA HD
> hdd - SATA HD.
> 
> If I then enable:
> SCSI device support -> SCSI low-level drivers -> Serial ATA (SATA) 
> support ->  Intel PIIX/ICH SATA support
> 
> No PATA devices are accessible. I get:
> sda - SATA HD
> sdb - SATA HD
> 
> Is there any way that I can fix this using kernel options.
> It seems that below, the PATA devices are being recognised, but then are 
> unable to be accessed.

Yeah, you need to disable combined mode and use the IDE driver for PATA.

	Jeff



