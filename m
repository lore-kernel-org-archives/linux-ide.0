From: David Greaves <david@dgreaves.com>
Subject: How to recover from a drive failure.
Date: Fri, 12 Nov 2004 14:05:58 +0000
Message-ID: <4194C346.9000503@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:31630 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262531AbUKLOGA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Nov 2004 09:06:00 -0500
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP id 1A3A8E6D56
	for <linux-ide@vger.kernel.org>; Fri, 12 Nov 2004 14:04:29 +0000 (GMT)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01825-15 for <linux-ide@vger.kernel.org>;
 Fri, 12 Nov 2004 14:04:29 +0000 (GMT)
Received: from oak.dgreaves.com (modem-3248.putangitangi.dialup.pol.co.uk [81.78.204.176])
	by mail.ukfsn.org (Postfix) with ESMTP id 72465E6A89
	for <linux-ide@vger.kernel.org>; Fri, 12 Nov 2004 14:04:28 +0000 (GMT)
Received: from ash.dgreaves.com ([10.0.0.106])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1CSc7x-0005z3-Ld
	for linux-ide@vger.kernel.org; Fri, 12 Nov 2004 14:10:13 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE Linux <linux-ide@vger.kernel.org>

Hi

I have raid5 setup and a disk died a couple of weeks back.
The RMA return arrived this morning and, as luck would(n't) have it, 
another raid disk died too.

The disks are Maxtor 250Gb SATA running through a Promise TX4.
It's a shame SMART doesn't work yet - but they are running cool (12cm 
fan pointed at them) and well powered.

Anyways, now I have a dead raid device :(

Since I have a good disk I was going to:
* insert new drive as /dev/sdd1
* dd if=/dev/sda1 of=/dev/sdd1
* mdadm /dev/md0 --remove /dev/sda1
* physically swap /dev/sda and /dev/sdd so /dev/sdd
* mdadm /dev/md0 --add /dev/sda1

Is this the best approach?
Especially the dd?
I think I saw a 'better way' but can't find it despite some concerted 
googling.

Any suggestions gratefully recv'd.

David
PS yes I'm buying a hot spare.
Yes I wish I'd done that before but you have to balance risk and I 
didn't expect 2 new Maxtor drives to die within a few months of 
purchase. 1million hours MTBF - yeah, right.
Equally why should a two sets of bad blocks screw up my raid array. <sigh>
No, I don't have a backup of 1Tb of data - I'm a home user.
