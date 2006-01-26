From: David Greaves <david@dgreaves.com>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 17:15:24 +0000
Message-ID: <43D903AC.5000309@dgreaves.com>
References: <20060126055050.GA4737@htj.dyndns.org> <43D8FBBD.6070205@dgreaves.com> <43D8FF9A.4020805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:3764 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932342AbWAZRPZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 12:15:25 -0500
In-Reply-To: <43D8FF9A.4020805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Nicolas.Mailhot@LaPoste.net, Jens Axboe <axboe@suse.de>, Linux-ide <linux-ide@vger.kernel.org>, Christopher Smith <csmith@nighthawkrad.net>, Erik Slagter <erik@slagter.name>, hahn@physics.mcmaster.ca, mlaks@verizon.net, Soeren Sonnenburg <kernel@nn7.de>, mlaks@verizononline.net

Jeff Garzik wrote:

> David Greaves wrote:
>
>>   Possible libata/sata/Asus problem (was Re: Need to upgrade to latest
>> stable mdadm version?)
>
> Highly likely to be a motherboard/BIOS issue related to properly
> tuning and timing the hardware.
>
> HOWEVER, libata can help (via Tejun's recent patches) by properly
> handling the error when throw to us by hardware.

OK - I thought my messages:

Jan 20 06:25:04 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jan 20 06:25:04 haze kernel: ata2: error=0x04 { DriveStatusError }
Jan 20 06:25:10 haze kernel: ata2: no sense translation for status: 0x51
Jan 20 06:25:10 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jan 20 06:25:18 haze kernel: ata2: no sense translation for status: 0x51
Jan 20 06:25:18 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jan 20 06:25:18 haze kernel: ata2: no sense translation for status: 0x51
Jan 20 06:25:18 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jan 20 06:25:20 haze kernel: ata2: no sense translation for status: 0x51
Jan 20 06:25:20 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jan 20 06:25:22 haze kernel: ata2: no sense translation for status: 0x51
Jan 20 06:25:22 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jan 20 06:25:52 haze kernel: ata2: no sense translation for status: 0x51
Jan 20 06:25:52 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jan 20 06:25:52 haze kernel: sd 1:0:0:0: SCSI error: return code = 0x8000002
Jan 20 06:25:52 haze kernel: sdb: Current: sense key: Medium Error
Jan 20 06:25:52 haze kernel:     Additional sense: Unrecovered read
error - auto reallocate failed
Jan 20 06:25:52 haze kernel: end_request: I/O error, dev sdb, sector
390787713

bore a certain similarity to those in Tejun/Nicolas' mail:

Different problem? as irq might ask: "does anybody care?" :)

(and yes badblocks and SMART reports all is well)

David

-- 

