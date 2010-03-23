From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [libata-dev#upstream-fixes] libata-sff: fix spurious IRQ handling
Date: Mon, 22 Mar 2010 22:47:59 -0400
Message-ID: <4BA82BDF.2070308@garzik.org>
References: <4BA7253F.8070500@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:37579 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab0CWCsE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Mar 2010 22:48:04 -0400
Received: by yxe12 with SMTP id 12so2111780yxe.33
        for <linux-ide@vger.kernel.org>; Mon, 22 Mar 2010 19:48:02 -0700 (PDT)
In-Reply-To: <4BA7253F.8070500@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, b3nton@gmail.com, petr.uzel@centrum.cz, "Rafael J. Wysocki" <rjw@sisk.pl>

On 03/22/2010 04:07 AM, Tejun Heo wrote:
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
> drivers/ata/libata-sff.c | 43 +++++++++++++++++++++++++++++++++++--------
> 1 file changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 561dec2..66f6bd1 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1667,6 +1667,7 @@ unsigned int ata_sff_host_intr(struct ata_port *ap,
> {
> struct ata_eh_info *ehi = &ap->link.eh_info;
> u8 status, host_stat = 0;
> + bool bmdma_stopped = false;
>
> VPRINTK("ata%u: protocol %d task_state %d\n",
> ap->print_id, qc->tf.protocol, ap->hsm_task_state);
> @@ -1699,6 +1700,7 @@ unsigned int ata_sff_host_intr(struct ata_port *ap,
>
> /* before we do anything else, clear DMA-Start bit */
> ap->ops->bmdma_stop(qc);
> + bmdma_stopped = true;
>
> if (unlikely(host_stat & ATA_DMA_ERR)) {
> /* error when transfering data to/from memory */
> @@ -1716,8 +1718,14 @@ unsigned int ata_sff_host_intr(struct ata_port *ap,

hmmmm, could you resend this patch?

Neither git am nor patch(1) seem to like it...

	Jeff




