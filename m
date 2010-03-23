From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [libata-dev#upstream-fixes RESEND] libata-sff: fix spurious IRQ
 handling
Date: Tue, 23 Mar 2010 09:43:25 -0400
Message-ID: <4BA8C57D.7030502@garzik.org>
References: <4BA7253F.8070500@kernel.org> <4BA82BDF.2070308@garzik.org> <4BA83458.6010003@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54364 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab0CWNnc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Mar 2010 09:43:32 -0400
Received: by vws6 with SMTP id 6so865842vws.19
        for <linux-ide@vger.kernel.org>; Tue, 23 Mar 2010 06:43:31 -0700 (PDT)
In-Reply-To: <4BA83458.6010003@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, b3nton@gmail.com, petr.uzel@centrum.cz, "Rafael J. Wysocki" <rjw@sisk.pl>

On 03/22/2010 11:24 PM, Tejun Heo wrote:
> Commit 27943620cbd960f710a385ff4a538e14ed3f1922 introduced spurious
> IRQ handling but it has a race condition where valid completion can be
> lost while trying to clear spurious IRQ leading to occassional command
> timeouts.
>
> This patch improves SFF interrupt handler such that
>
> 1. Once BMDMA HSM is stopped, the condition is never considered
> spurious. As there's no way to resume stopped BMDMA HSM, if device
> status doesn't agree with BMDMA status, the only way out is
> aborting the command (otherwise, it will just end up timing out).
>
> 2. ap->ops->sff_check_status() can be safely called to clear spurious
> device IRQ as it atomically returns completion status but BMDMA IRQ
> status can't be cleared in safe way if command is in flight. After
> a spurious IRQ, call ap->ops->sff_irq_clear() only if the
> respective device is idle and retry completion if
> sff_check_status() indicates command completion.
>
> Please note that ata_piix uses bmdma_status for sff_irq_check() and #2
> won't weaken spurious IRQ handling even with in-flight command because
> if bmdma_status indicates IRQ pending but device status is not on
> spurious check, the next IRQ handler invocation will abort the command
> due to #1.
>
> This fixes bko#15537.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=15537
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Andrew Benton <b3nton@gmail.com>
> Cc: Petr Uzel <petr.uzel@centrum.cz>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>> hmmmm, could you resend this patch?
>> Neither git am nor patch(1) seem to like it...
>
> Here it is. Puzzled, the original posting was whitespace corrupt (all
> tabs were replaced with spaces) although I sent it exactly the same
> way as other patches.

Still corrupted and not working...  Because it is an important fix, I 
manually applied it by recreating the patch, chunk by chunk.

	Jeff



