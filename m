From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Sun, 06 May 2007 11:33:03 +0200
Message-ID: <463DA0CF.8080508@gmail.com>
References: <754241.548.qm@web52606.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:9529 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbXEFJdR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 May 2007 05:33:17 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1269512nzf
        for <linux-ide@vger.kernel.org>; Sun, 06 May 2007 02:33:17 -0700 (PDT)
In-Reply-To: <754241.548.qm@web52606.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

Srihari Vijayaraghavan wrote:
> I had a significant breakthrough: when I removed two out of four 1 GB modules
> (just a stab in the dark to see if the system stability problem I reported to
> LKML ( http://marc.info/?l=linux-kernel&m=117813911431765&w=2 ; a few sample
> oops messages attached for reference) goes away, I stuck a gold mine: now the
> SATA controller detects both the drives :-)).
> 
> So, it'd seem the SATA controller wouldn't work fine when one has a lot of RAM
> on this board. The manual/manufacture's website claim it supports 8 GB of DDR2
> 800, while I only have 4, yet there are a few severe problems already: like
> this SATA drive detection problem & the system instability.
> 
> I now got things working very reliably (even without pci=nomsi) with 2 GB of
> RAM (3 times longer kernel compile torture time with 2 GB, without kernel
> issues, with both pairs of RAM individually, compared with all of 4 GB where
> the system is plagued with instability). I intent to check how far below 4095M
> I could use mem= parameter with, without destablising the system, assuming if
> at all mem= parameters going to help.
> 
> For the record, here's the complete dmesg of the current working system as an
> attachment (dmesg-2.6.21.1-2gigs):
> 
> Thank you for your insight into the problem. If there are any tricks involved
> in making use of all 4 GB of RAM with SATA drives & with system stability,
> I'll be very happy to learn them :-)).

It might be that you just have a bad ram module.  Does the machine work
properly if you exchange the installed two modules with the other two?
memtet86 time, I guess.

-- 
tejun
