From: Tejun Heo <htejun@gmail.com>
Subject: Summary of libata-dev backlog
Date: Tue, 31 Oct 2006 19:54:45 +0900
Message-ID: <45472B75.6060909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:42617 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423105AbWJaKyz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 05:54:55 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1405834ugm
        for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 02:54:53 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Jeff.

Here is the list of patches pending for #upstream-fixes, #upstream and 
waiting your review.

Some of the patches collide and some might not apply to the current 
#upstream[-fixes].  If you want me to regenerate them or stack them in 
any particular order in a git tree, just let me know.

Thanks.

***
*** pending patches for #upstream-fixes
***

[PATCH] sata_sis: fix flags handling for the secondary port
http://article.gmane.org/gmane.linux.ide/13639

	This bug breaks the secondary port and is a regression.  The
	fix has been verified by Uwe Koziolek <uwe.koziolek@gmx.net>
	and Patrick McHardy <kaber@trash.net>.

***
*** pending patches which might be appropriate for #upstream-fixes
***

From: Uwe Koziolek <uwe.koziolek@gmx.net>
Re: sata_sis only recognizing primary drive in 2.6.18
http://article.gmane.org/gmane.linux.ide/13641

	This is straight forward SLAVE_POSS flag addition for
	controllers which can do slave ports.  I think it's safe to
	push this to #upstream-fixes too.

[PATCH] ata_piix: allow 01b MAP for both ICH6M and ICH7M
http://article.gmane.org/gmane.linux.ide/13398

	Verified by Tom Deblauwe <tom.deblauwe@telenet.be> via private
	mail.

***
*** pending patches for #upstream
***

[PATCH] sata_nv: SRST sometimes fails after hotplug, use HRST_TO_RESUME
http://article.gmane.org/gmane.linux.ide/13241

	verified by Jim Paris <jim@jtan.com> && harmless

[RFT PATCH] libata: implement ATA_FLAG_SETXFER_POLLING and use it in 
pata_via
http://article.gmane.org/gmane.linux.ide/13248

	Matthieu Castet <castet.matthieu@free.fr> tested with both
	SETXFER_POLLING and DETECT_POLLING turned on.  I asked for
	re-test but no response yet.  SETXFER_POLLING and
	DETECT_POLLING affect different stages of detection and his
	setup working okay means SETXFER_POLLING is doing its job.  I
	think we can put this into upstream and -mm for more testing.

[PATCHSET] libata: implement presence detection using polling IDENTIFY 
for ata_piix
http://thread.gmane.org/gmane.linux.ide/13284/focus=13284

	Has been in -mm for some time now.  This doesn't solve all
	piix detection problems but it solves problems caused by PCS
	not reporting device presence when device is actually there.
	This basically reverts detection behavior to pre-IRQ-pio when
	we seemed to have much fewer problems.  There hasn't been any
	report of this patch causing negative effect.

	With this patch applied, I think one left PCS problem is PCS
	update failing to enable ports.

	http://bugzilla.kernel.org/show_bug.cgi?id=7170

***
*** patchsets pending review
***

[PATCH] libata: handle 0xff status properly
http://article.gmane.org/gmane.linux.ide/13408

	Acked by Alan Cox and I have at least one positive report of
	killing unnecessary wait and those annonying 0xff messages
	during boot.  As this patch mimics the behavior of the IDE
	driver, the approach should be safe.

[PATCHSET] hotplug polling, take 5
http://thread.gmane.org/gmane.linux.ide/13467/focus=13467

[PATCHSET] implement ata_link, take 3
http://thread.gmane.org/gmane.linux.ide/13478/focus=13494

[PATCHSET] prep for PMP suport, take 3
http://thread.gmane.org/gmane.linux.ide/13500/focus=13500

[PATCHSET] implement PMP support, take 3
http://thread.gmane.org/gmane.linux.ide/13503/focus=13503
(the patchset title is wrong, sorry)

[PATCHSET] sata_sil: implement Mod15Write workaround by split request 
processing
http://thread.gmane.org/gmane.linux.ide/13570/focus=13570

-- 
tejun
