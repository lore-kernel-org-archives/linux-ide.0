From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Problem with disk
Date: Wed, 03 May 2006 16:01:35 -0400
Message-ID: <1146686495.6540.35.camel@montroll.chem.mcgill.ca>
Reply-To: David.Ronis@McGill.CA
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from torrent.CC.McGill.CA ([132.206.27.49]:58542 "EHLO
	torrent.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S1750777AbWECUBs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 May 2006 16:01:48 -0400
Received: from mailscan2.cc.mcgill.ca (mailscan2.CC.McGill.CA [132.216.77.249])
	by torrent.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k43K1kEJ022149
	for <linux-ide@vger.kernel.org>; Wed, 3 May 2006 16:01:47 -0400
Received: from montroll.chem.mcgill.ca (montroll.Chem.McGill.CA [132.206.205.86])
	by mailscan2.cc.mcgill.ca (8.13.6/8.13.0) with ESMTP id k43K1cUW009286
	for <linux-ide@vger.kernel.org>; Wed, 3 May 2006 16:01:38 -0400 (EDT)
Received: from montroll.chem.mcgill.ca (IDENT:11@localhost [127.0.0.1])
	by montroll.chem.mcgill.ca (8.13.6/8.13.6) with ESMTP id k43K1aWF011537
	for <linux-ide@vger.kernel.org>; Wed, 3 May 2006 16:01:36 -0400
Received: (from ronis@localhost)
	by montroll.chem.mcgill.ca (8.13.6/8.13.6/Submit) id k43K1ZFQ011536
	for linux-ide@vger.kernel.org; Wed, 3 May 2006 16:01:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have an Toshiba Satellite M40 laptop that has a Fujitsu MHU2100AT ATA
Disk drive.  I've had two instances of major disk corruption and have
brought the laptop back to Toshiba twice.  The first time they found a
problem in the power supply, but the second they said it was fine.  

I have windows installed on another partition and have had no corruption
problems there since the first repair.  I've also run spinwrite-6.0 on
the disk and again it reports no problems.

Here are some symptoms of the problems under Linux:

I restore from dump backups after running mkfs on the Linux partition.
During the restore I get some complaints of read/write errors
(fortunately all in nonessential files).  After the restore is
completed, the system seems to be fine, however, after powering down an
rebooting, major disk problems are found, and after running fsck, I end
up with significant data loss.

I've run with and without journaling turned on, but this doesn't seem to
make a difference.

I notice from hdparm that disk write caching is turned on.  Any chance
that there is a problem with the cache not being flushed before powering
down?

I'm running Linux-2.6.15.5 on what is otherwise a slackware-10.2
install.

David



