From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Sun, 20 Dec 2015 17:11:51 +0000
Message-ID: <yw1xy4cp6o4o.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1x37uzc45t.fsf@unicorn.mansr.com> <5674271B.9090308@candw.ms>
	<yw1xtwnfad4y.fsf@unicorn.mansr.com> <56745BA4.1090607@candw.ms>
	<yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
	<yw1xlh8r9wkm.fsf@unicorn.mansr.com>
	<CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	<567541EE.9010308@candw.ms> <yw1x60zua1ld.fsf@unicorn.mansr.com>
	<CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
	<yw1xwpsa8j2x.fsf@unicorn.mansr.com> <56758F33.20804@candw.ms>
	<yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
	<yw1xio3u8dgc.fsf@unicorn.mansr.com> <5675BB2F.6060107@candw.ms>
	<CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	<yw1xegei893o.fsf@unicorn.mansr.com> <5675C452.2080206@candw.ms>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:52177 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332AbbLTRMA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Dec 2015 12:12:00 -0500
In-Reply-To: <5675C452.2080206@candw.ms> (Julian Margetson's message of "Sat,
	19 Dec 2015 16:55:46 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Julian Margetson <runaway@candw.ms> writes:

> On 12/19/2015 4:41 PM, M=E5ns Rullg=E5rd wrote:
>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>
>>> On Sat, Dec 19, 2015 at 10:16 PM, Julian Margetson <runaway@candw.ms> w=
rote:
>>>> On 12/19/2015 3:07 PM, M=E5ns Rullg=E5rd wrote:
>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>> Total pages: 522752
>>>>>> [    0.000000] Kernel command line: root=3D/dev/sda8 console=3DttyS0=
,115200
>>>>>> console=3Dtty1 dw_dmac_core.dyndbg dw_dmac.dyndbg
>>>>> Please add ignore_log_level.
>>>>>
>>>> Had to truncate the kernel command line to add it.
>>> I guess M=E5ns meant 'ignore_loglevel'
>> Obviously.  I can never remember where the underscores go.
>
> [   18.362244] sd 3:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 =
GB/465 GiB)
> [   18.372454] sd 3:0:0:0: Attached scsi generic sg3 type 0
> [   18.405433] sd 3:0:0:0: [sdc] Write Protect is off
> [   18.420654] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [   18.461731] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
> [   18.502918] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: port=3D0=
 dma dir=3Dfrom device n_elem=3D1
> [   18.511807] dma dma0chan0: dwc_prep_slave_sg
> [   18.516083] dma dma0chan0: scanned 1 descriptors on freelist
> [   18.521753] sata-dwc 4bffd1000.sata: dma_dwc_xfer_setup sg: 0xedeaa800=
, count: 1 addr: 0xfffffffff6a14400
> [   18.531327] sata-dwc 4bffd1000.sata: sata_dwc_qc_issue: tag=3D0 ap->li=
nk.sactive =3D 0x00000001 sactive=3D0x00000001
> [   18.541359] sata-dwc 4bffd1000.sata: sata_dwc_exec_command_by_tag cmd(=
0x60): READ FPDMA QUEUED tag=3D0
> [   18.553703] sata-dwc 4bffd1000.sata: sata_dwc_isr intpr=3D0x00000082 a=
ctive_tag=3D-84148995
> [   18.561717] sata-dwc 4bffd1000.sata: sata_dwc_isr: NEWFP tag=3D0
> [   18.567561] sata-dwc 4bffd1000.sata: sata_dwc_bmdma_start_by_tag qc=3D=
ed2340b8 tag: 0 cmd: 0x60 dma_dir: from device start_dma? 1
> [   18.579043] sata-dwc 4bffd1000.sata: taskfile cmd: 0x60 protocol: ATA =
NCQ flags: 0x17 device: 40
> [   18.587836] sata-dwc 4bffd1000.sata: feature: 0x08 nsect: 0x0 lbal: 0x=
0 lbam: 0x0 lbah: 0x0
> [   18.596196] sata-dwc 4bffd1000.sata: hob_feature: 0x00 hob_nsect: 0x0 =
hob_lbal: 0x0 hob_lbam: 0x0 hob_lbah: 0x0
> [   18.606292] dma dma0chan0: dwc_tx_submit: queued 2
> [   18.611091] dma dma0chan0: dwc_dostart_first_queued: started 2
> [   48.748614] ata3: lost interrupt (Status 0x40)

Now we're getting somewhere.  The dma transfer is set up and initiated,
but then nothing happens.  Comparing the old sata_dwc driver, from
before the switch to dmaengine, with the dw_dma driver, I noticed an
obvious problem: the descriptors are filled in using the wrong byte
order.  This patch might fix that.

--=20
M=E5ns Rullg=E5rd

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-dmaengine-dw-fix-byte-order-of-hw-descriptor-fields.patch

>From 04b444b301c8b2db732dbf259dddb3dc87d622c8 Mon Sep 17 00:00:00 2001
From: Mans Rullgard <mans@mansr.com>
Date: Sun, 20 Dec 2015 16:54:21 +0000
Subject: [PATCH] dmaengine: dw: fix byte order of hw descriptor fields

If the DMA controller uses a different byte order than the host CPU,
the hardware linked list descriptor fields need to be byte-swapped.

This patch makes the driver write these fields using the same byte
order it uses for mmio accesses to the DMA engine.  I do not know
if this is guaranteed to always be correct.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/dma/dw/core.c | 84 +++++++++++++++++++++++++++------------------------
 drivers/dma/dw/regs.h | 26 +++++++++++-----
 2 files changed, 63 insertions(+), 47 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 7067b6d..b954904 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -209,12 +209,12 @@ static inline void dwc_do_single_block(struct dw_dma_chan *dwc,
 	 * Software emulation of LLP mode relies on interrupts to continue
 	 * multi block transfer.
 	 */
-	ctllo = desc->lli.ctllo | DWC_CTLL_INT_EN;
+	ctllo = dw_lli_read(desc->lli.ctllo) | DWC_CTLL_INT_EN;
 
-	channel_writel(dwc, SAR, desc->lli.sar);
-	channel_writel(dwc, DAR, desc->lli.dar);
+	channel_writel(dwc, SAR, dw_lli_read(desc->lli.sar));
+	channel_writel(dwc, DAR, dw_lli_read(desc->lli.dar));
 	channel_writel(dwc, CTL_LO, ctllo);
-	channel_writel(dwc, CTL_HI, desc->lli.ctlhi);
+	channel_writel(dwc, CTL_HI, dw_lli_read(desc->lli.ctlhi));
 	channel_set_bit(dw, CH_EN, dwc->mask);
 
 	/* Move pointer to next descriptor */
@@ -432,7 +432,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		}
 
 		/* Check first descriptors llp */
-		if (desc->lli.llp == llp) {
+		if (dw_lli_read(desc->lli.llp) == llp) {
 			/* This one is currently in progress */
 			dwc->residue -= dwc_get_sent(dwc);
 			spin_unlock_irqrestore(&dwc->lock, flags);
@@ -441,7 +441,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 		dwc->residue -= desc->len;
 		list_for_each_entry(child, &desc->tx_list, desc_node) {
-			if (child->lli.llp == llp) {
+			if (dw_lli_read(child->lli.llp) == llp) {
 				/* Currently in progress */
 				dwc->residue -= dwc_get_sent(dwc);
 				spin_unlock_irqrestore(&dwc->lock, flags);
@@ -730,16 +730,16 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		if (!desc)
 			goto err_desc_get;
 
-		desc->lli.sar = src + offset;
-		desc->lli.dar = dest + offset;
-		desc->lli.ctllo = ctllo;
-		desc->lli.ctlhi = xfer_count;
+		dw_lli_write(desc->lli.sar, src + offset);
+		dw_lli_write(desc->lli.dar, dest + offset);
+		dw_lli_write(desc->lli.ctllo, ctllo);
+		dw_lli_write(desc->lli.ctlhi, xfer_count);
 		desc->len = xfer_count << src_width;
 
 		if (!first) {
 			first = desc;
 		} else {
-			prev->lli.llp = desc->txd.phys;
+			dw_lli_write(prev->lli.llp, desc->txd.phys);
 			list_add_tail(&desc->desc_node,
 					&first->tx_list);
 		}
@@ -748,7 +748,7 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 
 	if (flags & DMA_PREP_INTERRUPT)
 		/* Trigger interrupt after last block */
-		prev->lli.ctllo |= DWC_CTLL_INT_EN;
+		dw_lli_or(prev->lli.ctllo, DWC_CTLL_INT_EN);
 
 	prev->lli.llp = 0;
 	first->txd.flags = flags;
@@ -818,9 +818,10 @@ slave_sg_todev_fill_desc:
 			if (!desc)
 				goto err_desc_get;
 
-			desc->lli.sar = mem;
-			desc->lli.dar = reg;
-			desc->lli.ctllo = ctllo | DWC_CTLL_SRC_WIDTH(mem_width);
+			dw_lli_write(desc->lli.sar, mem);
+			dw_lli_write(desc->lli.dar, reg);
+			dw_lli_write(desc->lli.ctllo,
+					ctllo | DWC_CTLL_SRC_WIDTH(mem_width));
 			if ((len >> mem_width) > dwc->block_size) {
 				dlen = dwc->block_size << mem_width;
 				mem += dlen;
@@ -830,13 +831,13 @@ slave_sg_todev_fill_desc:
 				len = 0;
 			}
 
-			desc->lli.ctlhi = dlen >> mem_width;
+			dw_lli_write(desc->lli.ctlhi, dlen >> mem_width);
 			desc->len = dlen;
 
 			if (!first) {
 				first = desc;
 			} else {
-				prev->lli.llp = desc->txd.phys;
+				dw_lli_write(prev->lli.llp, desc->txd.phys);
 				list_add_tail(&desc->desc_node,
 						&first->tx_list);
 			}
@@ -875,9 +876,10 @@ slave_sg_fromdev_fill_desc:
 			if (!desc)
 				goto err_desc_get;
 
-			desc->lli.sar = reg;
-			desc->lli.dar = mem;
-			desc->lli.ctllo = ctllo | DWC_CTLL_DST_WIDTH(mem_width);
+			dw_lli_write(desc->lli.sar, reg);
+			dw_lli_write(desc->lli.dar, mem);
+			dw_lli_write(desc->lli.ctllo,
+				     ctllo | DWC_CTLL_DST_WIDTH(mem_width));
 			if ((len >> reg_width) > dwc->block_size) {
 				dlen = dwc->block_size << reg_width;
 				mem += dlen;
@@ -886,13 +888,13 @@ slave_sg_fromdev_fill_desc:
 				dlen = len;
 				len = 0;
 			}
-			desc->lli.ctlhi = dlen >> reg_width;
+			dw_lli_write(desc->lli.ctlhi, dlen >> reg_width);
 			desc->len = dlen;
 
 			if (!first) {
 				first = desc;
 			} else {
-				prev->lli.llp = desc->txd.phys;
+				dw_lli_write(prev->lli.llp, desc->txd.phys);
 				list_add_tail(&desc->desc_node,
 						&first->tx_list);
 			}
@@ -909,7 +911,7 @@ slave_sg_fromdev_fill_desc:
 
 	if (flags & DMA_PREP_INTERRUPT)
 		/* Trigger interrupt after last block */
-		prev->lli.ctllo |= DWC_CTLL_INT_EN;
+		dw_lli_or(prev->lli.ctllo, DWC_CTLL_INT_EN);
 
 	prev->lli.llp = 0;
 	first->total_len = total_len;
@@ -1393,50 +1395,52 @@ struct dw_cyclic_desc *dw_dma_cyclic_prep(struct dma_chan *chan,
 
 		switch (direction) {
 		case DMA_MEM_TO_DEV:
-			desc->lli.dar = sconfig->dst_addr;
-			desc->lli.sar = buf_addr + (period_len * i);
-			desc->lli.ctllo = (DWC_DEFAULT_CTLLO(chan)
+			dw_lli_write(desc->lli.dar, sconfig->dst_addr);
+			dw_lli_write(desc->lli.sar,
+				     buf_addr + (period_len * i));
+			dw_lli_write(desc->lli.ctllo, (DWC_DEFAULT_CTLLO(chan)
 					| DWC_CTLL_DST_WIDTH(reg_width)
 					| DWC_CTLL_SRC_WIDTH(reg_width)
 					| DWC_CTLL_DST_FIX
 					| DWC_CTLL_SRC_INC
-					| DWC_CTLL_INT_EN);
+					| DWC_CTLL_INT_EN));
 
-			desc->lli.ctllo |= sconfig->device_fc ?
-				DWC_CTLL_FC(DW_DMA_FC_P_M2P) :
-				DWC_CTLL_FC(DW_DMA_FC_D_M2P);
+			dw_lli_or(desc->lli.ctllo, sconfig->device_fc ?
+					DWC_CTLL_FC(DW_DMA_FC_P_M2P) :
+					DWC_CTLL_FC(DW_DMA_FC_D_M2P));
 
 			break;
 		case DMA_DEV_TO_MEM:
-			desc->lli.dar = buf_addr + (period_len * i);
-			desc->lli.sar = sconfig->src_addr;
-			desc->lli.ctllo = (DWC_DEFAULT_CTLLO(chan)
+			dw_lli_write(desc->lli.dar,
+					buf_addr + (period_len * i));
+			dw_lli_write(desc->lli.sar, sconfig->src_addr);
+			dw_lli_write(desc->lli.ctllo, (DWC_DEFAULT_CTLLO(chan)
 					| DWC_CTLL_SRC_WIDTH(reg_width)
 					| DWC_CTLL_DST_WIDTH(reg_width)
 					| DWC_CTLL_DST_INC
 					| DWC_CTLL_SRC_FIX
-					| DWC_CTLL_INT_EN);
+					| DWC_CTLL_INT_EN));
 
-			desc->lli.ctllo |= sconfig->device_fc ?
-				DWC_CTLL_FC(DW_DMA_FC_P_P2M) :
-				DWC_CTLL_FC(DW_DMA_FC_D_P2M);
+			dw_lli_or(desc->lli.ctllo, sconfig->device_fc ?
+					DWC_CTLL_FC(DW_DMA_FC_P_P2M) :
+					DWC_CTLL_FC(DW_DMA_FC_D_P2M));
 
 			break;
 		default:
 			break;
 		}
 
-		desc->lli.ctlhi = (period_len >> reg_width);
+		dw_lli_write(desc->lli.ctlhi, (period_len >> reg_width));
 		cdesc->desc[i] = desc;
 
 		if (last)
-			last->lli.llp = desc->txd.phys;
+			dw_lli_write(last->lli.llp, desc->txd.phys);
 
 		last = desc;
 	}
 
 	/* Let's make a cyclic list */
-	last->lli.llp = cdesc->desc[0]->txd.phys;
+	dw_lli_write(last->lli.llp, cdesc->desc[0]->txd.phys);
 
 	dev_dbg(chan2dev(&dwc->chan),
 			"cyclic prepared buf %pad len %zu period %zu periods %d\n",
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index 241ff2b..84f05de 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -308,20 +308,32 @@ static inline struct dw_dma *to_dw_dma(struct dma_device *ddev)
 	return container_of(ddev, struct dw_dma, dma);
 }
 
+#ifdef CONFIG_DW_DMAC_BIG_ENDIAN_IO
+typedef __be32 dw_u32;
+#define dw_lli_read(s)		be32_to_cpu(s)
+#define dw_lli_write(d, v)	((d) = cpu_to_be32(v))
+#else
+typedef __le32 dw_u32;
+#define dw_lli_read(s)		le32_to_cpu(s)
+#define dw_lli_write(d, v)	((d) = cpu_to_le32(v))
+#endif
+
+#define dw_lli_or(d, v)		dw_lli_write(d, dw_lli_read(d) | (v))
+
 /* LLI == Linked List Item; a.k.a. DMA block descriptor */
 struct dw_lli {
 	/* values that are not changed by hardware */
-	u32		sar;
-	u32		dar;
-	u32		llp;		/* chain to next lli */
-	u32		ctllo;
+	dw_u32		sar;
+	dw_u32		dar;
+	dw_u32		llp;		/* chain to next lli */
+	dw_u32		ctllo;
 	/* values that may get written back: */
-	u32		ctlhi;
+	dw_u32		ctlhi;
 	/* sstat and dstat can snapshot peripheral register state.
 	 * silicon config may discard either or both...
 	 */
-	u32		sstat;
-	u32		dstat;
+	dw_u32		sstat;
+	dw_u32		dstat;
 };
 
 struct dw_desc {
-- 
2.6.3


--=-=-=--
