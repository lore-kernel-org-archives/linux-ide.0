From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SMART on SATA reporting errors? (was Re: regarding bug #5914
 - fs corruption on SATA)
Date: Tue, 07 Feb 2006 14:30:32 -0500
Message-ID: <43E8F558.4040002@pobox.com>
References: <20060126055050.GA4737@htj.dyndns.org> <43D8FBBD.6070205@dgreaves.com> <43D8FF9A.4020805@pobox.com> <43D903AC.5000309@dgreaves.com> <43E8E85F.5000905@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:14728 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965169AbWBGTaj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Feb 2006 14:30:39 -0500
In-Reply-To: <43E8E85F.5000905@dgreaves.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: Linux-ide <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Nicolas.Mailhot@LaPoste.net, Jens Axboe <axboe@suse.de>, Christopher Smith <csmith@nighthawkrad.net>, Erik Slagter <erik@slagter.name>, hahn@physics.mcmaster.ca, mlaks@verizon.net, Soeren Sonnenburg <kernel@nn7.de>, mlaks@verizononline.net, smartmontools-support@lists.sourceforge.net

David Greaves wrote:
> This is a followon to the email below.
> 
> Basically, it seems some SMART commands produce unexpected errrors.
> 
> My Debian smartd config has "-o on" and "-S on" for every drive so it
> puts out lots of errors every time I boot.
> 
> I did a little investigation and I see that when I do:
> # smartctl -o on -data /dev/sdb
> smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> === START OF ENABLE/DISABLE COMMANDS SECTION ===
> Error SMART Disable Automatic Offline failed: Input/output error
> Smartctl: SMART Disable Automatic Offline Failed.
> 
> (Which is fine if the drive doesn't support it.)
> 
> I unexpectedly get this in dmesg:
> 
> ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: status=0x51 { DriveReady SeekComplete Error }
> ata2: error=0x04 { DriveStatusError }
> ata2: no sense translation for status: 0x51
> ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata2: status=0x51 { DriveReady SeekComplete Error }
> ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: status=0x51 { DriveReady SeekComplete Error }
> ata2: error=0x04 { DriveStatusError }
> ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: status=0x51 { DriveReady SeekComplete Error }
> ata2: error=0x04 { DriveStatusError }
> ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: status=0x51 { DriveReady SeekComplete Error }
> ata2: error=0x04 { DriveStatusError }


All of your commands are missing "-d ata"

	Jeff


