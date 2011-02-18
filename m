From: Vasiliy Kulikov <segooon@gmail.com>
Subject: Re: [PATCH] ata: sata_dwc_460ex: fix error path
Date: Fri, 18 Feb 2011 20:27:42 +0300
Message-ID: <20110218172742.GA5238@albatros>
References: <1284317830-5022-1-git-send-email-segooon@gmail.com>
 <4D5C1326.2010101@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58896 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab1BRR1t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 12:27:49 -0500
Content-Disposition: inline
In-Reply-To: <4D5C1326.2010101@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, kernel-janitors@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Rupjyoti Sarmah <rsarmah@appliedmicro.com>, Prodyut Hazarika <phazarika@appliedmicro.com>, Grant Likely <grant.likely@secretlab.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Sergei,

On Wed, Feb 16, 2011 at 21:10 +0300, Sergei Shtylyov wrote:
> >@@ -727,11 +727,15 @@ static int dma_dwc_xfer_setup(struct scatterlist *sg, int num_elems,
> > static void dma_dwc_exit(struct sata_dwc_device *hsdev)
> > {
> > 	dev_dbg(host_pvt.dwc_dev, "%s:\n", __func__);
> >-	if (host_pvt.sata_dma_regs)
> >+	if (host_pvt.sata_dma_regs) {
> > 		iounmap(host_pvt.sata_dma_regs);
> >+		host_pvt.sata_dma_regs = NULL;
> >+	}
> >-	if (hsdev->irq_dma)
> >+	if (hsdev->irq_dma) {
> > 		free_irq(hsdev->irq_dma, hsdev);
> >+		hsdev->irq_dma = 0;
> >+	}
> > }
> 
>    Are those changes really necessary, i.e. is dma_dwc_exit() called
> more than once?

Because this function may be called once again before
host_pvt.sata_dma_regs gains new value in sata_dwc_probe().  This would
lead to double iounmap() and double free_irq().

> >@@ -1606,7 +1610,7 @@ static int sata_dwc_probe(struct platform_device *ofdev,
> > 	if (hsdev == NULL) {
> > 		dev_err(&ofdev->dev, "kmalloc failed for hsdev\n");
> > 		err = -ENOMEM;
> >-		goto error_out;
> >+		goto error;
> 
>    Why not just:
> 
> 		return err;

If some resource allocation is added before this line in future then
"return err" should be changed.  With goto the single cleanup is just
added to the end of the function.


Thanks,

-- 
Vasiliy
