From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -mm] ide_end_drive_cmd(): avoid instruction pipeline
	stall
Date: Fri, 30 Jun 2006 19:21:39 +0100
Message-ID: <1151691699.31392.72.camel@localhost.localdomain>
References: <20060630161351.GA17434@rhlx01.fht-esslingen.de>
	 <1151688416.31392.66.camel@localhost.localdomain>
	 <20060630110018.f45b40e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:197 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932626AbWF3SFI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 14:05:08 -0400
In-Reply-To: <20060630110018.f45b40e2.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: andi@rhlx01.fht-esslingen.de, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 11:00 -0700, ysgrifennodd Andrew Morton:
> I guess because he was profiling for IFU_MEM_STALL, not for wall-time.
> 
> > NAK because
> > 1. This is a gcc problem
> > 2. Not everyone is using an intel x86-32 box which has such problems
> > 3. IDE is in life-support mode and the relatives are already planning
> > the flowers.
> 
> Well.  If the patch breaks anything we can dine on hats for a month.  Seems
> pretty inoffensive to me.

Yeah its a do nothing change that has no value. We can equally not apply
it and see no difference. Its make-work that might slow down some
systems.

Send it to the gcc people see if its a case they could/should optimise

Alan

