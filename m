From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: PATA drivers queued for 2.6.19
Date: Mon, 4 Sep 2006 14:10:13 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0609041408230.21005@yvahk01.tjqt.qr>
References: <44FC0779.9030405@garzik.org> <1157371363.30801.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailer.gwdg.de ([134.76.10.24]:25020 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751337AbWIDMOD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Sep 2006 08:14:03 -0400
In-Reply-To: <1157371363.30801.31.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>


>> * /dev/sdX does not support all the HDIO_xxx ioctls that /dev/hdX does. 
>>   In practice, the ioctls we ignored are ones that very few people care 
>> about.
>
>Add "/dev/sr*" does not support partitions. (That needs fixing anyway)

scd*/sr* is usually CDROM, which in the rarest case have a partition table, 
don't they? (sd* stands for Scsi Disk, but what's the r in sr standing 
for?)

>> As an aside, I would love to see paride updated to use libata, but we 
>> can probably count the number of paride users on one hand these days...
>
>and thats without using fingers or thumbs.

0? Could it be removed then? [I'm waiting for loud objection screams from 
paride users...]



Jan Engelhardt
-- 

-- 
VGER BF report: H 4.996e-16
