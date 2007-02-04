From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: add 150ms between completion of hardreset and
 status checking
Date: Sun, 04 Feb 2007 11:36:02 +0900
Message-ID: <45C54692.3070809@gmail.com>
References: <653885.83039.qm@web807.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:60220 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbXBDCgI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 21:36:08 -0500
Received: by py-out-1112.google.com with SMTP id a29so619036pyi
        for <linux-ide@vger.kernel.org>; Sat, 03 Feb 2007 18:36:08 -0800 (PST)
In-Reply-To: <653885.83039.qm@web807.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: linux-ide@vger.kernel.org

[this thread is regarding sata_inic162x, misplaced reply]

Bob Stewart wrote:
> There is still something else bad going on in your driver.  I've tried
> everything I can think of (timing changes, flushes, and whatnot)
> but I still get random timeouts and random results from md5sum
> on large files.  Even in the case where I don't get a timeout on a large
> iso file, the md5sum is still random.  Strangely enough, though, 
> the files may be good on-disk, since totem seems to play the DVD.iso
> that I'm testing with without a problem.  I'm using debian with a 2.6.19.2
> kernel.

Yeap, I'm aware of the problem.  That's why the driver is marked HIGHLY
EXPERIMENTAL.  Maybe I should change it to broken.  :-(  Anyways, one of
the known problems is mishandling of LBA48 commands which is cause of
timeouts and wrong md5sums on large disks.  I just couldn't find any
time to work on it in recent weeks.  Please be patient a bit.  I'll get
back to sata_ini162x in a few days.

-- 
tejun
