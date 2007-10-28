From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH-RFC] Promise TX4 implement hw-bug workaround
Date: Sun, 28 Oct 2007 17:32:57 +0100 (MET)
Message-ID: <200710281632.l9SGWvDJ028817@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:37036 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbXJ1Qda (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Oct 2007 12:33:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mikpe@it.uu.se, screwdriver@lxnt.info
Cc: MisterE2002@zonnet.nl, benh@kernel.crashing.org, htejun@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, 28 Oct 2007 12:03:16 +0100 (MET), Mikael Pettersson wrote:
> On Sun, 28 Oct 2007 06:29:32 -0400, Jeff Garzik wrote:
> > BTW, looking at the Promise code I see
> > 
> > > cam_con.h:
> > > /* for ASIC bug, limit the last element of SG byteCount must < 32 Dword */
> > > #define SG_COUNT_ASIC_BUG       32
> > > //#define SG_COUNT_ASIC_BUG     128
> > 
> > 	and in the code itself
> > 
> > > /* check PRD table, last element <= (32 Dword), fix ASIC bug */
> > 
> > (though the code obviously uses SG_COUNT_ASIC_BUG==32, as the first 
> > paste indicates)
> > 
> > so it seems like Promise first used 128 (32 dwords), but then backed 
> > down to 32 (8 dwords).
> > 
> > Either way, we definitely have an ASIC bug to work around, it seems...
> 
> You're looking at the old pdc-ultra2 driver. The newer unified
> sataii150-300 driver (v1.01.0.23) upped the value to 41*4.
> 
> I've reviewed Alexander's patch, and I'm currently testing it
> with the add-on patch below (fix sg_tablesize, code formatting
> stuff, fix uninitialised 'addr' in a VPRINTK).

FYI:

Several hours of testing on a SATA300 TX4 with two 3Gbps disks went well,
as did a quick test on a SATA300 TX2plus with one SATA and one PATA disk.

I'll test further on a 1st generation controller tomorrow.

> 
> /Mikael
> 
> --- linux-2.6.24-rc1/drivers/ata/sata_promise.c.~1~	2007-10-28 11:58:01.000000000 +0100
> +++ linux-2.6.24-rc1/drivers/ata/sata_promise.c	2007-10-28 12:20:53.000000000 +0100
> @@ -155,7 +155,7 @@ static struct scsi_host_template pdc_ata
>  	.queuecommand		= ata_scsi_queuecmd,
>  	.can_queue		= ATA_DEF_QUEUE,
>  	.this_id		= ATA_SHT_THIS_ID,
> -	.sg_tablesize		= LIBATA_MAX_PRD,
> +	.sg_tablesize		= LIBATA_MAX_PRD-1,
>  	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
>  	.emulated		= ATA_SHT_EMULATED,
>  	.use_clustering		= ATA_SHT_USE_CLUSTERING,
> @@ -542,7 +542,7 @@ static void pdc_fill_sg(struct ata_queue
>  
>  	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
>  		return;
> -	
> +
>  	WARN_ON(qc->__sg == NULL);
>  	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
>  
> @@ -579,18 +579,15 @@ static void pdc_fill_sg(struct ata_queue
>  
>  		if (len > SG_COUNT_ASIC_BUG) {
>  			u32 addr;
> -			/* if len < 2*SG_COUNT_ASIC_BUG then last
> -			   segment will be larger than next-to-last.
> -			   Somewhat ugly :(
> -			*/
>  
>  			VPRINTK("Splitting last PRD.\n");
>  
> +			addr = le32_to_cpu(ap->prd[idx - 1].addr);
>  			ap->prd[idx - 1].flags_len -= cpu_to_le32(SG_COUNT_ASIC_BUG);
>  			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);
> -			
> -			addr = le32_to_cpu(ap->prd[idx - 1].addr) + len - SG_COUNT_ASIC_BUG;
> -			len  = SG_COUNT_ASIC_BUG;
> +
> +			addr = addr + len - SG_COUNT_ASIC_BUG;
> +			len = SG_COUNT_ASIC_BUG;
>  			ap->prd[idx].addr = cpu_to_le32(addr);
>  			ap->prd[idx].flags_len = cpu_to_le32(len);
>  			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
