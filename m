From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil boot failure with 2.6.35
Date: Tue, 24 Aug 2010 15:52:10 +0200
Message-ID: <4C73CE8A.406@kernel.org>
References: <4C6EC878020000780001146D@vpn.id2.novell.com> <4C6ED603.9020602@garzik.org> <4C724D3E.50404@kernel.org> <4C728C5E0200007800011887@vpn.id2.novell.com> <4C727E80.3060402@kernel.org> <4C72B4250200007800011998@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35090 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755324Ab0HXN5i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Aug 2010 09:57:38 -0400
In-Reply-To: <4C72B4250200007800011998@vpn.id2.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Jeff Garzik <jeff@garzik.org>, jgarzik@redhat.com, linux-ide@vger.kernel.org

Hello,

On 08/23/2010 05:47 PM, Jan Beulich wrote:
>>>> On 23.08.10 at 15:58, Tejun Heo <tj@kernel.org> wrote:
>>   ata1: ST-ATA: DRQ=0 without device error, dev_stat 0x50
>>
>> which is _really_ weird.  Hmmm... can you please apply the following
>> patch and see whether anything changes?
> 
> No difference, but log attached again just in case.

I can't reproduce the problem w/ my 3114 and unfortunately I don't
have a 3112 or 3512 around.  :-(

The only thing I can think of is the following.  Can you please try
this one?  If this one fails, we might have to resort to bisecting.
It's very weird.  The sff common code is used by other controllers but
until now the problem is only being reported on sata_sil.

Thanks.

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 3cb69d5..35bd5cc 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -565,19 +565,6 @@ static void sil_freeze(struct ata_port *ap)
 	tmp |= SIL_MASK_IDE0_INT << ap->port_no;
 	writel(tmp, mmio_base + SIL_SYSCFG);
 	readl(mmio_base + SIL_SYSCFG);	/* flush */
-
-	/* Ensure DMA_ENABLE is off.
-	 *
-	 * This is because the controller will not give us access to the
-	 * taskfile registers while a DMA is in progress
-	 */
-	iowrite8(ioread8(ap->ioaddr.bmdma_addr) & ~SIL_DMA_ENABLE,
-		 ap->ioaddr.bmdma_addr);
-
-	/* According to ata_bmdma_stop, an HDMA transition requires
-	 * on PIO cycle. But we can't read a taskfile register.
-	 */
-	ioread8(ap->ioaddr.bmdma_addr);
 }

 static void sil_thaw(struct ata_port *ap)


-- 
tejun
