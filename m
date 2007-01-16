From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: ahci problems with sata disk.
Date: Tue, 16 Jan 2007 15:20:49 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701161504050.18469@coffee.psychology.mcmaster.ca>
References: <1168785128.7865.13.camel@duo> <45AB45B2.2080602@gmail.com>
 <1168859112.6980.8.camel@duo> <f4527be0701160844r19fe5220i39a5834f1f4df570@mail.gmail.com>
 <45AD1A3A.4000706@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:54085 "EHLO
	coriana6.cis.mcmaster.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbXAPVXW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 16:23:22 -0500
Received: from daltron7.UTS.McMaster.CA (daltron7.UTS.mcmaster.ca [130.113.64.13])
	by coriana6.cis.mcmaster.ca (8.13.7/8.13.7) with ESMTP id l0GKLQpv019343
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 15:21:31 -0500 (EST)
Received: from coffee.psychology.mcmaster.ca (coffee.Psychology.McMaster.CA [130.113.218.59])
	by daltron7.UTS.McMaster.CA (8.13.7/8.13.7) with ESMTP id l0GKKnkf007287
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 15:20:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by coffee.psychology.mcmaster.ca (Postfix) with ESMTP id 7BBFBEE030C
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 15:20:49 -0500 (EST)
In-Reply-To: <45AD1A3A.4000706@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>>> I though that NCQ was intended to increase performance ??

intended to increase _sales_ performance ;)

remember that you've always had command queueing (kernel elevator): 
the main difference with NCQ (or SCSI tagged queueing) is when
the disk can out-schedule the kernel.  afaikt, this means sqeezing
in a rotationally intermediate request along the way.

that intermediate request must be fairly small and should be a read
(for head-settling reasons).

I wonder how often this happens in the real world, given the relatively
small queues the disk has to work with.

> My hdparm test is a sequential read-ahead test, so it will
> naturally perform worse on a Raptor when NCQ is on.

that's a surprisingly naive heuristic, especially since 
NCQ is concerned with just a max of ~4MB of reads, only a smallish
fraction of the available cache.
