From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: sata_sil boot problems with kernel 2.6.35 and current git
Date: Fri, 10 Sep 2010 11:14:04 +0100
Message-ID: <4C8A210C0200007800015648@vpn.id2.novell.com>
References: <20100908182651.GA32114@seek.priv>
 <4C88F69E.6070000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <4C88F69E.6070000@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, dieter@plaetinck.be, Sergei Shtylyov <sshtylyov@ru.mvista.com>, gianluca <gianluca@sottospazio.it>, Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org

>>> On 09.09.10 at 17:00, Tejun Heo <tj@kernel.org> wrote:
> Can you please test whether the patch at the end of this message is
> enough to fix the problem?

Both the revert of the original change and the patch here solved the
problem also for me (on .36-rc3).

Thanks, Jan

> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 030b1c4..6a43129 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -418,6 +418,7 @@ void ata_sff_tf_load(struct ata_port *ap, const struct 
> ata_taskfile *tf)
>  		if (ioaddr->ctl_addr)
>  			iowrite8(tf->ctl, ioaddr->ctl_addr);
>  		ap->last_ctl = tf->ctl;
> +		ap->ops->sff_check_status(ap);
>  	}
> 
>  	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> @@ -453,6 +454,7 @@ void ata_sff_tf_load(struct ata_port *ap, const struct 
> ata_taskfile *tf)
>  		iowrite8(tf->device, ioaddr->device_addr);
>  		VPRINTK("device 0x%X\n", tf->device);
>  	}
> +	ap->ops->sff_check_status(ap);
>  }
>  EXPORT_SYMBOL_GPL(ata_sff_tf_load);



