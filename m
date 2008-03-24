From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.25-rc6] sata_promise: fix hardreset hotplug events,
 take 2
Date: Mon, 24 Mar 2008 11:19:32 +0900
Message-ID: <47E70FB4.4010802@gmail.com>
References: <200803221421.m2MEL1oY021558@harpo.it.uu.se> <18406.38445.717175.664615@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:49831 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844AbYCXCTj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 22:19:39 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3163114wah.23
        for <linux-ide@vger.kernel.org>; Sun, 23 Mar 2008 19:19:39 -0700 (PDT)
In-Reply-To: <18406.38445.717175.664615@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, kurt@roeckx.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> A Promise SATA controller will signal hotplug events when a hard
> reset (COMRESET) is done on a port. These events aren't masked by
> the driver, and the unexpected interrupts will cause a sequence
> of failed reset attempts util libata's EH finally gives up.
> 
> This has not been a common problem so far, but the pending libata
> hardreset-by-default changes makes it a critical issue.
> 
> The solution is to disable hotplug events before a reset, and to
> reenable them afterwards. (Promise's driver does this too.)
> 
> This patch adds SATA-specific versions of ->freeze() and ->thaw()
> that also disable and enable hotplug events. PATA ports continue
> to use the old versions of ->freeze() and ->thaw().
> 
> Accesses to the hotplug register must be serialised via host->lock.
> We rely on ap->lock == &ap->host->lock and that libata takes this
> lock before ->freeze() and ->thaw(). Document this requirement.
> The interrupt handler is adjusted so its hotplug register accesses
> are inside the region protected by host->lock.
> 
> Tested on various chips (SATA300TX4, SATA300TX2plus, SATAII150TX4,
> FastTrack TX4000) with various combinations of SATA and PATA disks,
> with and without the pending hardreset-by-default changes.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Acked-by: Tejun Heo <htejun@gmail.com>

Jeff, do you want to merge this first?  If so, I'll update the
prefer-hardreset and cleanup-sht-ops patchsets; otherwise, I'll massage
this patch a bit so that it fits on top of those two patchsets.

-- 
tejun
