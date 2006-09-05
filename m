From: Ric Wheeler <ric@emc.com>
Subject: Re: faulty disk testing
Date: Tue, 05 Sep 2006 11:48:15 -0400
Message-ID: <44FD9C3F.1030803@emc.com>
References: <44FCD328.3020800@emc.com> <44FD662A.6060404@gmail.com> <44FD803B.3040000@pobox.com> <44FD84E8.8000705@gmail.com> <44FD8781.9040905@emc.com> <44FD9022.5060208@gmail.com>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [168.159.213.200] ([168.159.213.200]:29351 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S965164AbWIEPuS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Sep 2006 11:50:18 -0400
In-Reply-To: <44FD9022.5060208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Neil Brown <neilb@cse.unsw.edu.au>
Cc: Mark Lord <mlord@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo wrote:
> Ric Wheeler wrote:
> 
>>> One of the problems is that currently libata EH can take some minutes 
>>> recovering from an error condition.  With partial request retry from 
>>> sd,  a batch of consecutive bad sectors can make recovery take a 
>>> really long time.  This needs fixing.
>>
>>
>> So far, the new-init build has been running the recovery in the lab 
>> for about 40 minutes ;-)
> 
> 
> Ouch.  that's long.  BTW, from the log you posted.
> 
> sd 1:0:0:0: SCSI error: return code = 0x08000002
> sdb: Current: sense key: Medium Error
>     Additional sense: Unrecovered read error - auto reallocate failed
> end_request: I/O error, dev sdb, sector 272900
> Buffer I/O error on device sdb3, logical block 208640
> Buffer I/O error on device sdb3, logical block 208641
> Buffer I/O error on device sdb3, logical block 208642
> Buffer I/O error on device sdb3, logical block 208643
> Buffer I/O error on device sdb3, logical block 208644
> Buffer I/O error on device sdb3, logical block 208645
> Buffer I/O error on device sdb3, logical block 208646
> Buffer I/O error on device sdb3, logical block 208647
> 
> This is sd failing the request and the error completion propagating 
> through fs/buffer and thus back to its user - probably md.  It's a bit 
> weird that md doesn't drop the device at this point.  I think it could 
> be that special metadata path thing you mentioned.

Neil, any special paths in MD (mainline MD) that would not kick out a 
failing drive (drive superblock probe time)?

Thanks!

ric



