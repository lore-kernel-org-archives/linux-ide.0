From: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH, review] IDE driver for MIPS Toshiba RBTX4939
Date: Mon, 3 Oct 2005 11:43:29 -0700
Message-ID: <20051003184328.GC6735@smtp.west.cox.net>
References: <20050929162228.GS18074@smtp.west.cox.net> <58cb370e0510030917q2bcb1790g6b9cd0456525bfae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30893 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932559AbVJCSna (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Oct 2005 14:43:30 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e0510030917q2bcb1790g6b9cd0456525bfae@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Hiroshi DOYU <hdoyu@mvista.com>

On Mon, Oct 03, 2005 at 06:17:49PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On 9/29/05, Tom Rini <trini@kernel.crashing.org> wrote:
[snip]
> > +       /* save ata controller valiable */
> > +       lo_bcnt = reg_rd16(&tx4939_ataptr(ch)->lo_bcnt);
> > +       hi_bcnt = reg_rd16(&tx4939_ataptr(ch)->hi_bcnt);
> 
> Could I see tx4939_ataptr() (I guess it is in <asm/tx4939/tx4939.h>)?

Indeed, sorry (lots of other stuff snipped out):

Index: linux-2.6.10/include/asm-mips/tx4939/tx4939.h
===================================================================
--- /dev/null
+++ linux-2.6.10/include/asm-mips/tx4939/tx4939.h
@@ -0,0 +1,1670 @@
[snip]
+/* TX4939 REGISTER ADDRESS MAP */
+
+#define TX4939_REG_BASE          0xff1f0000
+#define TX4939_REG_SIZE          0x00010000
+
+#define TX4939_ATA_REG(ch)       (TX4939_REG_BASE + 0x3000 + (ch) * 0x1000)
[snip]
+#ifdef __BIG_ENDIAN
+#define endian_def_s4(e1,e2,e3,e4)      \
+        u16 e1,e2,e3,e4
+#else
+#define endian_def_s4(e1,e2,e3,e4)      \
+        u16 e4,e3,e2,e1
+#endif				/* __ASSEMBLY__ */
+
+/* TX4939 REGISTER STRUCTURE */
+
+#ifndef __ASSEMBLY__
+
+struct tx4939_ata_reg {
+	u64 ata_shadow;
+	u64 unused0[127];
+	endian_def_b8(unused10, unused11, unused12, unused13, unused14,
+		      alt_devctl, unused16, unused17);
+	u64 unused1[127];
+	endian_def_b8(unused20, unused21, unused22, prd_tbl, unused24,
+		      dma_stat, unused26, dma_cmd);
+	u64 unused2[127];
+	endian_def_s4(unused30, unused31, sysctl2, sysctl1);	/* +0xc00 */
+	endian_def_s4(unused32, unused33, xfer_cnt2, xfer_cnt1);
+	endian_def_s4(unused34, unused35, unused36, sec_cnt);
+	endian_def_s4(unused37, unused38, unused39, strt_addl);
+	endian_def_s4(unused40, unused41, unused42, strt_addu);
+	endian_def_s4(unused43, unused44, unused45, add_ctrl);
+	endian_def_s4(unused46, unused47, unused48, lo_bcnt);
+        endian_def_s4(unused49, unused50, unused51, hi_bcnt);
+	volatile u64 unused52[9];
+        endian_def_s4(unused53, unused54, unused55, pio_acc);
+        endian_def_s4(unused56, unused57, unused58, h_rst_tim);
+        endian_def_s4(unused59, unused60, unused61, int_ctl);
+	volatile u64 unused62[3];
+        endian_def_s4(unused63, unused64, unused65, pkt_cmd);
+        endian_def_s4(unused66, unused67, unused68, bxfer_cnth);
+        endian_def_s4(unused69, unused70, unused71, bxfer_cntl);
+        endian_def_s4(unused72, unused73, unused74, dev_terr);
+        endian_def_s4(unused75, unused76, unused77, pkt_xfer_ct);
+        endian_def_s4(unused78, unused79, unused80, strt_addr);
+};
[snip]
+#define tx4939_ataptr(ch)       \
+        ((struct tx4939_ata_reg *)TX4939_ATA_REG(ch))

-- 
Tom Rini
http://gate.crashing.org/~trini/
