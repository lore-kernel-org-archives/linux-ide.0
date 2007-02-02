From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: reimplement reset sequencing
Date: Fri, 2 Feb 2007 16:50:51 +0900
Message-ID: <11704026511717-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:64800 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423207AbXBBHvH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:51:07 -0500
Received: by wx-out-0506.google.com with SMTP id h31so819854wxd
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:51:06 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

Currently reset is driven by ata_eh_reset().  Reset can be tried upto
ATA_EH_RESET_TRIES times and each reset try can take a very long time
- several minutes under certain circumstances.

For boot and loading detections, the initial reset succeeds most of
the time.  However, after errors and hotplugging events, controllers
and devices show widely different behaviors.  For hotplugs, we rely
heavily on the wait performed in ->prereset().  For other error
conditions, we just take long time if things don't succeed at the
first try.

This patchset reimplements reset sequencing such that resets are
retried with more reasonable timing while not upsetting devices too
much with frequent resets.  e.g. spinup wait is completely replaced by
carefully spaced reset tries.

ATA controllers and devices vary greatly in how they behave when
things are not normal.  It's just not scaleable to try to fine-tune
each LLD's reset methods such that the initial try succeeds most of
the time (because failure takes too long).  This patchset allows LLDs
with good enough reset methods which may fail occasionally to work
well enough.

I've tested the change on about a dozen controllers with more than a
dozen ATA/ATAPI devices.  The result was very positive.  It was not
optimal on all of the cases but all were definitely acceptable (maybe
5s to 15s longer than optimal).

Combined with posted timeout adjustment and speed down improvement,
this should make libata EH behave much better.

This patchset is against

upstream (eb0e63cca36a3389f0ccab4584f6d479b983fad5)
+ [1] pata_platform-fix-devres-conversion
+ [2] libata-convert-to-iomap
+ [3] put-some-intelligence-into-speeddown patchset
+ [4] add-150ms-between-completion-of-hardreset-and-status-checking
+ [5] sata_inic162x-fix-a-few-glitches-in-hardreset

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.kernel/488509
[2] sorry, no archive, message was too large
[3] http://thread.gmane.org/gmane.linux.ide/15596
[4] http://article.gmane.org/gmane.linux.ide/15582
[5] http://article.gmane.org/gmane.linux.ide/15583


