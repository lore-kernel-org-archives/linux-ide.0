From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v0 2/2] ata: Fix the dma state machine lockup for the PIO
 mode commands.
Date: Fri, 6 Jun 2014 18:30:57 -0400
Message-ID: <20140606223057.GB1055@mtj.dyndns.org>
References: <1402090134-23164-1-git-send-email-stripathi@apm.com>
 <1402090134-23164-3-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402090134-23164-3-git-send-email-stripathi@apm.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: olof@lixom.net, arnd@arndb.de, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>
List-Id: linux-ide@vger.kernel.org

On Sat, Jun 07, 2014 at 02:58:54AM +0530, Suman Tripathi wrote:
> @@ -5072,6 +5072,16 @@ int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active)
>  		if (qc) {
>  			ata_qc_complete(qc);
>  			nr_done++;
> +			/*
> +			 * Some controller unable to clear the BSY bit after
> +			 * receiving the PIO Setup FIS from device resulting
> +			 * the DMA state to go into CMFatalErrorUpdate state.
> +			 * So need to restart the dma engine to get the
> +			 * controller out of this state.
> +			 */
> +			if ((ap->flags & ATA_HORKAGE_BROKEN_PIO_CMD) &&
> +			    (qc->tf.protocol == ATA_PROT_PIO))
> +				ap->ops->restart_engine(ap);

Why aren't you doing this by wrapping irq handler?

Thanks.

-- 
tejun
