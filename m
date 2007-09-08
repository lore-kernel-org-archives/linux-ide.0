From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Asynchronous scan support for libata
Date: Sat, 08 Sep 2007 17:10:27 +0900
Message-ID: <46E258F3.20805@gmail.com>
References: <20070906210505.GF27404@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:40891 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbXIHRIK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:08:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so940147wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:08:10 -0700 (PDT)
In-Reply-To: <20070906210505.GF27404@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> Last December, I posted this: http://lwn.net/Articles/213635/
> 
> Here's an updated version.  It shaves 5 seconds off boot time on my
> configuration (qla2xxx, emulex, two ata_piix, dual fusion), but could
> save more or less on other setups.
> 
> I think I can remove the 'sync' argument and code from
> ata_scsi_scan_host() now, but wanted to send out this update today.
> 
> ---
> 
> Some of the drivers (AHCI was mentioned to me as a culprit) take a long
> time to discover all the devices attached to them.  Even for ones which
> are relatively quick, if you put a lot of them in a machine, it will
> take a long time in aggregate.  This can be fixed by adding support for
> asynchronous scsi scans, which causes the time-consuming portions of
> initialisation to take place in threads.
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

I think it's generally okay although it would need to spend quite some
time in -mm and we'll need to exclude several drivers which require
host-wide silence for mode programming (the current code is buggy but
sequential probing hides it pretty well) till host-wide exclusion is
implemented.

Thanks.

-- 
tejun

