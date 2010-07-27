From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/12] libata: use IRQ expecting
Date: Tue, 27 Jul 2010 13:37:45 -0400
Message-ID: <4C4F1969.5020305@garzik.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org> <4C23F6C1.7070603@garzik.org> <4C245E50.7090701@kernel.org> <4C2577F2.4030005@garzik.org> <4C25BAD2.4070705@kernel.org> <4C25C551.8000404@garzik.org> <4C25CC18.2070507@kernel.org> <4C2DFAB0.3020703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62276 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0G0Rh4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jul 2010 13:37:56 -0400
In-Reply-To: <4C2DFAB0.3020703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

On 07/02/2010 10:41 AM, Tejun Heo wrote:
> Hello, Jeff.
>
> So, something like the following.  This should be applied on top of
> the two previous libata patches.  The amount of code in the hot path
> is very small.  Compared to the cpu actually taking an interrupt and
> accessing hardware, it should be negligible, and this will give us
> working and acceptably performing systems in the presence of most
> types of IRQ problems.
>
> Thanks.
>
> Subject: [PATCH] libata: use IRQ expecting
>
> Legacy ATA is very susceptible to IRQ delivery problems in both
> directions - lost and spurious interrupts.  In traditional PATA, the
> IRQ line is ultimately out of the controller and driver's control.
>
> Even relatively new SATA controllers share this problem as many still
> emulate the traditional IDE interface which doesn't have reliable way
> to indicate interrupt pending state and there also is an issue
> regarding the interpretation of nIEN on both sides of the cable.
>
> Controllers with native interface have fewer problems compared to the
> ones which use SFF but they still are affected by IRQ misrouting or
> broken MSI implementations.
>
> IRQ delivery problems on ATA are particularly nasty because it
> commonly hosts installation and/or booting.
>
> Most of these problems can be worked around by using the new IRQ
> expecting mechanism without adding any noticeable overhead.  In ATA,
> almost all operations are initiated by the host and the controller
> signals progress or completion using IRQ.  IRQ expecting can easily be
> added in libata core and applied to all libata drivers.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-core.c |   55 ++++++++++++++++++++++++++++++----------------
>   drivers/ata/libata-eh.c   |    4 ++-
>   drivers/ata/libata-sff.c  |   37 +++++++++++++++---------------
>   include/linux/libata.h    |    2 +
>   4 files changed, 60 insertions(+), 38 deletions(-)

I suppose the few cycles it costs are worth it...

Assuming this new version (from July 2) is tested,

Acked-by: Jeff Garzik <jgarzik@redhat.com>


