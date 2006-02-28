From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 28 Feb 2006 09:38:44 -0500
Message-ID: <44046074.4070201@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:63178 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750935AbWB1Oit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 09:38:49 -0500
In-Reply-To: <44042863.2050703@dgreaves.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>

David Greaves wrote:
..
> sd 0:0:0:0: SCSI error: return code = 0x8000002
> sda: Current: sense key: Medium Error
>     Additional sense: Unrecovered read error - auto reallocate failed
> end_request: I/O error, dev sda, sector 390716735
> raid5: Disk failure on sda1, disabling device. Operation continuing on 2
> devices
> ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
> ata2: status=0x51 { DriveReady SeekComplete Error }
> sd 1:0:0:0: SCSI error: return code = 0x8000002
> sdb: Current: sense key: Medium Error
>     Additional sense: Unrecovered read error - auto reallocate failed
> end_request: I/O error, dev sdb, sector 390716735
> raid5: Disk failure on sdb1, disabling device. Operation continuing on 1
> devices
..

The error handling still sucks, regardless of FUA.
All of this nonsense about "Medium Error" is pure bogosity here.

Cheers
