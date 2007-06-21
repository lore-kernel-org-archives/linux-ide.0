From: Mark <mark@runuo.com>
Subject: Re: Possible BUG in Linux's Promise TX4 drivers
Date: Thu, 21 Jun 2007 03:04:10 +0000 (UTC)
Message-ID: <loom.20070621T045941-674@post.gmane.org>
References: <4679E489.2020205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43828 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbXFUDEh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Jun 2007 23:04:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I1CyB-00075n-G5
	for linux-ide@vger.kernel.org; Thu, 21 Jun 2007 05:04:27 +0200
Received: from ip68-108-205-250.ph.ph.cox.net ([68.108.205.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 21 Jun 2007 05:04:27 +0200
Received: from mark by ip68-108-205-250.ph.ph.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 21 Jun 2007 05:04:27 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Gabriele Tozzi <gabriele.tozzi <at> gmail.com> writes:

> 
> Hello,
> 
> I got a Promise TX4 SATA 300 Controller with 3 SAMSUNG HD400LJ SATA 300 
> disks (sdc, sdd, sde), the disks runs under a software raid5 with Luks 
> (Cryptography layer) and Lvm2.
> 
> The disks works well and there is no data loss, but i'm continuously and 
> always getting worrisome error messages and poor performance (with brief 
> system jams) when i perform writing operations to disks. Reading data 
> works well and seems to give no error messages.
> 
> I've checked cables and power supply and i've tryied swapping 
> controller's pci slot and playing with bios irq setting. None of them 
> changed the results, so i'm assuming the presence of a kernel bug. I'm 
> sorry if i'm getting wrong and then wasting your time.
> 
> My kernel version:
> Linux version 2.6.21.5 (root <at> transylvania) (gcc version 4.1.3 20070601 
> (prerelease) (Debian 4.1.2-12)) #1 SMP Fri Jun 15 20:25:41 CEST 2007
> 
> This presumed bug was present on linux 2.60.20.7 too.
> 
> On kernel 2.6.18.1 the bug was present, but with different error 
> messages, the messages were identical to those reported by another user 
> on this mail: http://lkml.org/lkml/2006/10/25/198
> 
> I got an Asus CUV4X-D motherboard with two PIII 800Mhz CPUS, this is my 
> home server :)
> 

Everyone seems to be having problems with the Promise SATA300 TX4. I have an 
almost identical setup: SATA300 TX4 with 3 Samsung 400GB drives, and I get very 
similar errors.

In 2.6.20 my card would soft restart all the way down to PIO mode and kill my 
performance. In 2.6.22-rc5 it will hard reset from 3.0 Gb/s to 1.5 Gb/s and 
operate relatively stable until heavy I/O. 

If anyone reading these threads (there have been quite a few in various places, 
see 'sata_promise error handling just a few hours ago) needs any additional 
information to help solve this problem, please let me know.


