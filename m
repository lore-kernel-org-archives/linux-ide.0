From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: sata_inic162x driver for 2.6.19
Date: Wed, 10 Jan 2007 23:34:32 +0000
Message-ID: <1168472072.14261.5.camel@localhost.localdomain>
References: <20061221041618.12158.qmail@web813.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:41731 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965249AbXAJXtO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jan 2007 18:49:14 -0500
In-Reply-To: <20061221041618.12158.qmail@web813.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Wed, 2006-12-20 at 20:16 -0800, Bob Stewart wrote:
> Sorry, that should have been "logblocks".  As shown below, it works unless the
> partition is such that logblocks will be larger than 16383.  In fdisk, that
> number of cylinders anything greater than 16709.  "Works" is relative, though. 
> When doing a copy of several gigabytes, the syslog shows periodic device
> errors, which I have posted previously.  Each time, it lowers the access rate
> until it eventually reaches PI04.
[...]
> Here is the fdisk screen for the above disk.  If I use a figure larger than
> 16709 cylinders mkfs.xfs will not be successful.
> 
> Disk /dev/sda: 200.0 GB, 200049647616 bytes
> 255 heads, 63 sectors/track, 24321 cylinders
> Units = cylinders of 16065 * 512 = 8225280 bytes
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sda1               1       16709   134215011   83  Linux

Its probably significant that the problem appears at >137GB. I've got a
similar issue with a 320GB drive I've just tried to use. I've not pinned
down the limit but I partitioned the drive in two and the first half
works, the second half gives corrupt superblock errors when trying to
mount it (ext3).

I tried both the 2.6.19 version and one based on 2.6.20-rc4, same
problem. Is there anything specific the driver needs to do work with
disks > 137GB?

I've just tried to grab the datasheet but the Initio webserver has
chosen this moment to act up...

Richard

