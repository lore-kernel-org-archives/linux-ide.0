From: Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 20:50:58 -0600
Message-ID: <45BEB292.7060008@cs.wisc.edu>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>  <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net> <1170051963.6454.7.camel@Homer.simpson.net> <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org> <45BE5AF0.3030005@cs.wisc.edu> <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org> <Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org> <Pine.LNX.4.64.0701291453230.3611@woody.linux-foundation.org> <Pine.LNX.4.64.0701291532050.3611@woody.linux-foundation.org> <45BE864A.2050907@cs.wisc.edu> <Pine.LNX.4.64.0701291614020.3611@woody.linux-foundation.org> <45BE9774.20105@cs.wisc.edu> <45BE99A4.9080503@cs.wisc.edu> <Pine.LNX.4.64.0701291736550.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070805080208090605070804"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sabe.cs.wisc.edu ([128.105.6.20]:45236 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533AbXA3DBt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 22:01:49 -0500
In-Reply-To: <Pine.LNX.4.64.0701291736550.3611@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>

This is a multi-part message in MIME format.
--------------070805080208090605070804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Mon, 29 Jan 2007, Mike Christie wrote:
>> Actually, I do not think we did this in 2.6.19. Tomo added a bug when he
>> ported a patch and mixed up some things so we did something weird for
>> 2.6.20-rc1.
> 
> Ah, ok. Warring bugs.  Have you pinpointed the original one? Is it your 
> original "block: support larger block pc requests" after all? It looks 
> like yours is the one that did the big changes, with Tomo then fixing some 
> of the fallout?

I am not completely convinced this bug is the "block: support larger
block pc requests" patches fault. If I revert the jiffies_to_msecs usage
then it works for me. On my system I have
CONFIG_HZ_250=y
CONFIG_HZ=250

With the attached patch, nero finds the cd drives and I can burn disks.
There is no errors from the ide layer like before.

--------------070805080208090605070804
Content-Type: text/x-patch;
 name="use-old-timeout-calc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="use-old-timeout-calc.patch"

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 2528a0c..aded9a0 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -271,7 +271,7 @@ static int sg_io(struct file *file, requ
 
 	rq->cmd_type = REQ_TYPE_BLOCK_PC;
 
-	rq->timeout = jiffies_to_msecs(hdr->timeout);
+	rq->timeout = (hdr->timeout * HZ) / 1000;
 	if (!rq->timeout)
 		rq->timeout = q->sg_timeout;
 	if (!rq->timeout)

--------------070805080208090605070804--
