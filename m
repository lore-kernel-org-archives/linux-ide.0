From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [Bug #11343] SATA Cold Boot Problems with 2.6.27-rc[23] on nVidia
 680i
Date: Sat, 23 Aug 2008 18:34:47 -0400
Message-ID: <48B09087.3090202@garzik.org>
References: <mzBsPw3QUOF.A.87F.wZGsIB@albercik> <VSpL6AnBTS.A.m3H.3aGsIB@albercik>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55160 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562AbYHWWev (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Aug 2008 18:34:51 -0400
In-Reply-To: <VSpL6AnBTS.A.m3H.3aGsIB@albercik>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manny Maxwell <mannymax@mannymax.net>, Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>

Rafael J. Wysocki wrote:
> This message has been generated automatically as a part of a report
> of recent regressions.
> 
> The following bug entry is on the current list of known regressions
> from 2.6.26.  Please verify if it still should be listed and let me know
> (either way).
> 
> 
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=11343
> Subject		: SATA Cold Boot Problems with 2.6.27-rc[23] on nVidia 680i
> Submitter	: Manny Maxwell <mannymax@mannymax.net>
> Date		: 2008-08-14 4:16 (10 days old)
> References	: http://marc.info/?l=linux-kernel&m=121868782917600&w=4


hmmmm.  Looking at changes between the two csets listed in the email 
(623fa57..8f616cd), all of them are driver-specific and unrelated to 
Manny's hardware except for

	commit 2486fa561a3192bbbec39c7feef87a1e07bd6342
	Author: Tejun Heo <tj@kernel.org>
	Date:   Thu Jul 31 07:52:40 2008 +0900

	    libata: update atapi disable handling

So you could try to revert that and see what happens.  But given that 
small range of changes, it really seems like something else, maybe in 
the PCI subsystem (random guess).

Looking at the entire kernel, nothing jumps out, either.  Its mostly fs 
updates (ext4, xfs), a networking update, an ARM update, and a libata 
update.

Also, some reset-related fixes just went in, so re-testing the latest 
-git would be helpful as well.

	Jeff



