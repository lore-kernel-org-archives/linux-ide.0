From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/12] libata: use IRQ expecting
Date: Thu, 24 Jun 2010 20:22:25 -0400
Message-ID: <4C23F6C1.7070603@garzik.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1276443098-20653-12-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org
List-Id: linux-ide@vger.kernel.org

On 06/13/2010 11:31 AM, Tejun Heo wrote:
> Thanks to its age, ATA is very susceptible to IRQ delivery problems in
> both directions - lost and spurious interrupts.  In traditional PATA,
> the IRQ line is ultimately out of the controller and driver's control.
> Even relatively new SATA isn't free from these issues.  Many
> controllers still emulate the traditional IDE interface which doesn't
> have reliable way to indicate interrupt pending state and there also
> is an issue regarding the interpretation of nIEN on both sides of the
> cable.
>
> Most of these problems can be worked around by using the new IRQ
> expecting mechanism without adding noticeable overhead.  In ATA,
> almost all operations are initiated by the host and the controller
> signals progress or completion using IRQ.  IRQ expecting can easily be
> added in libata core and applied to all libata drivers.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-core.c |   15 +++++++++++++--
>   drivers/ata/libata-eh.c   |    4 +++-
>   drivers/ata/libata-sff.c  |   37 +++++++++++++++++++------------------
>   include/linux/libata.h    |    2 ++
>   4 files changed, 37 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index ddf8e48..9a0aaa0 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4972,6 +4972,8 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>   {
>   	struct ata_port *ap = qc->ap;
>
> +	unexpect_irq(ap->irq_expect, false);
> +
>   	/* XXX: New EH and old EH use different mechanisms to
>   	 * synchronize EH with regular execution path.
>   	 *

Unconditional use of unexpect_irq() here seems incorrect for some cases, 
such as sata_mv's use, where ata_qc_complete() is called multiple times 
rather than a singleton ata_qc_complete_multiple() call.

	Jeff
