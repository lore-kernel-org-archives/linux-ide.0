From: Pavel Machek <pavel@suse.cz>
Subject: Re: sata_svw data corruption, strange problems
Date: Mon, 23 Jun 2008 10:53:38 +0200
Message-ID: <20080623085338.GE1850@elf.ucw.cz>
References: <20080617093602.GA28140@elf.ucw.cz> <485EF061.3010601@kernel.org> <20080623082055.GB1850@elf.ucw.cz> <je63s0sfxv.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42604 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbYFWIwo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2008 04:52:44 -0400
Content-Disposition: inline
In-Reply-To: <je63s0sfxv.fsf@sykes.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Tejun Heo <tj@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org, jgarzik@pobox.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Trivial patch monkey <trivial@kernel.org>

On Mon 2008-06-23 10:39:40, Andreas Schwab wrote:
> Pavel Machek <pavel@suse.cz> writes:
> 
> > +	   controller, the controller could hang. In other cases it
> > +	   could return partial data returning in data
> > +	   corruption. This problem has been seen in PPC systems and
> 
> s/returning/resulting/ ?

Fix thinko in sata_svw comment.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index fb13b82..d6313f1 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -269,7 +269,7 @@ static void k2_bmdma_start_mmio(struct a
 	   would become confused as to what to do with the data.  In
 	   the worst case when all the data is returned back to the
 	   controller, the controller could hang. In other cases it
-	   could return partial data returning in data
+	   could return partial data resulting in data
 	   corruption. This problem has been seen in PPC systems and
 	   can also appear on an system with very fast disks, where
 	   the SATA controller is sitting behind a number of bridges,


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
