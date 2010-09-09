From: gianluca <gianluca@sottospazio.it>
Subject: Re: sata_sil boot problems with kernel 2.6.35 and current git
Date: Thu, 9 Sep 2010 19:09:28 +0200
Message-ID: <20100909170928.GA20288@seek.priv>
References: <20100908182651.GA32114@seek.priv>
 <4C88F69E.6070000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:60832 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab0IIRKH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Sep 2010 13:10:07 -0400
Content-Disposition: inline
In-Reply-To: <4C88F69E.6070000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, dieter@plaetinck.be, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Thu, Sep 09, 2010 at 05:00:46PM +0200, Tejun Heo wrote:
> (cc's added)
> Hello,
> 
> On 09/08/2010 08:26 PM, gianluca wrote:
> > Today I tried  the kernel 2.6.35 in one of my boxes but I realized that the
> > box doesn't detect my SATA HD anymore. The logs show that the driver sata_sil
> > is correctly loaded. With 2.6.34 it worked fine.
> > 
> > So I tried to test the latest git to see if the issue was fixed, but that
> > kernel exhibits the same behaviour. Then I looked at the linux-ide mailing list
> > archives at http://marc.info/?t=128232284600001&r=1&w=2 and I found out that 
> > the issue is known but not solved and since I could reliably reproduce the
> > problen I started to bisect.
> > 
> > The logs of the bisection are attached. It pointed to the commit
> > 978c066691a49a205673672a55685305663a2554 (  libata: Remove excess delay in the
> > tf_load path ).
> > 
> > So I reverted that commit and got a bootable kernel again. I think this commit
> > exposed a timing bug in the sata_sil driver.
> 
> I love you.  Thank you so much for bisecting it.  :-)
> 
> Can you please test whether the patch at the end of this message is
> enough to fix the problem?

I just tested the patch you attached on a vanilla 2.6.35.4 kernel and it works
for me: the disk is there again.

Thank you!

gianluca


> 
> Alan, the above commit seems a bit dangerous as writes can be merged.
> Also, ISTR delay requirements for PATA while loading registers.  Mark,
> Sergei, what do you guys think?
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 030b1c4..6a43129 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -418,6 +418,7 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>  		if (ioaddr->ctl_addr)
>  			iowrite8(tf->ctl, ioaddr->ctl_addr);
>  		ap->last_ctl = tf->ctl;
> +		ap->ops->sff_check_status(ap);
>  	}
> 
>  	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> @@ -453,6 +454,7 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>  		iowrite8(tf->device, ioaddr->device_addr);
>  		VPRINTK("device 0x%X\n", tf->device);
>  	}
> +	ap->ops->sff_check_status(ap);
>  }
>  EXPORT_SYMBOL_GPL(ata_sff_tf_load);
