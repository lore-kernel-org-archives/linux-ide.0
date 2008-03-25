From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.25-rc6] sata_promise: fix hardreset hotplug events,
 take 2
Date: Mon, 24 Mar 2008 22:31:55 -0400
Message-ID: <47E8641B.3030309@garzik.org>
References: <200803221421.m2MEL1oY021558@harpo.it.uu.se> <18406.38445.717175.664615@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56431 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757216AbYCYCb7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Mar 2008 22:31:59 -0400
In-Reply-To: <18406.38445.717175.664615@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: htejun@gmail.com, kurt@roeckx.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

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
> ---
> Changes since previous version:
> - rephrase the problem description to avoid calling it a HW quirk,
>   the behaviour is apparently standard
> - fix double locking bug found by Tejun, now tested with SMP kernel
> - document locking rules for the global hotplug register
> - inline the hotplug enable/disable code in freeze/thaw
> 
>  drivers/ata/sata_promise.c |  109 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 88 insertions(+), 21 deletions(-)

applied


