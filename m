Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F22C10F29
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EA4206EC
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NzEDp3MA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCQOnt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:43:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40359 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgCQOns (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:48 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144346euoutp028af50f7a621cac61028d1567c1934a1a~9HosIK6-a1642416424euoutp02j
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144346euoutp028af50f7a621cac61028d1567c1934a1a~9HosIK6-a1642416424euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456226;
        bh=yVmOuC/IbwkA4RPeLq2XP7tx5I5mIoEKby9cc/KKYpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzEDp3MA+HBRDqzcPwj4jTRYLpvX0e/ZJ9QEbBbNaxMUgLbz7p44K7f2pkPZAs7Wi
         QS6MoR9/5+4ZP+6Z8KRae4vaDvMVwFeneBG2R8TR4n/RJFY5Uqr55YcCJtIyDflVVl
         CYebi48e5HCl5mjtzoawv+O+yQ0npkmgPGX8OUzU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144346eucas1p1b2ddbbe70efe544d92dadfd56572c08a~9HoryMIqy1086210862eucas1p1T;
        Tue, 17 Mar 2020 14:43:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DE.E1.60679.122E07E5; Tue, 17
        Mar 2020 14:43:45 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144345eucas1p209f6a96605af02cc451786051ebab395~9HorbnKZx3190931909eucas1p2V;
        Tue, 17 Mar 2020 14:43:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144345eusmtrp25baf4a9f4f0623cdefbe6a0c3215f832~9HorayGkq0147801478eusmtrp25;
        Tue, 17 Mar 2020 14:43:45 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-3d-5e70e221d687
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.D4.08375.122E07E5; Tue, 17
        Mar 2020 14:43:45 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144345eusmtip1a7697c2bf1d000a933e9e9254b6e79bd~9Hoq7w0vD1029210292eusmtip1C;
        Tue, 17 Mar 2020 14:43:45 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 09/27] ata: move EXPORT_SYMBOL_GPL()s close to exported
 code
Date:   Tue, 17 Mar 2020 15:43:15 +0100
Message-Id: <20200317144333.2904-10-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7qKjwriDFpWWFisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErowPc5pYCjZ+YqyYv6SLqYFxwmnGLkZO
        DgkBE4ndZ7exdTFycQgJrGCUOLr/HBOE84VR4t/a/8wQzmdGia3nTzLDtNw4uwSqajmjxP8L
        M9jhWj6vmcgGUsUmYCUxsX0V2BIRAQWJnt8rwZYwC7xnlFgxaS9LFyMHh7BAoMTEvSUgNSwC
        qhKfFk4Bq+cVsJVo/H8H6kB5ia3fPrGC2JxA8WuH/7FB1AhKnJz5hAXEZgaqad46G+xUCYFV
        7BKrP61nh2h2kfh25xeULSzx6vgWKFtG4v/O+UwQDesYJf52vIDq3s4osXwyxAoJAWuJO+d+
        sYFcyiygKbF+lz5E2FFi4e4PzCBhCQE+iRtvBSGO4JOYtG06VJhXoqNNCKJaTWLDsg1sMGu7
        dq6EhqKHxOP9uxgnMCrOQvLOLCTvzELYu4CReRWjeGppcW56arFRXmq5XnFibnFpXrpecn7u
        JkZgOjr97/iXHYy7/iQdYhTgYFTi4eXYUBAnxJpYVlyZe4hRgoNZSYR3cWF+nBBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2M0rKpy0WaD3n83yeqmmb7
        Ojb6dMKL2yZ2P4zDnNPNP6/6YXn62UHOcGfutCfzn09t6Mm9ucLZZJ3H1Rt7msVLlnldO8si
        z834QvVxfjFDnPRr8Qu7eBQFGyL59/49tS4ponH7f/OuMLcrR7iyJycYVN3dI7HSuHLujcQt
        FZXffy88+qZCTrJZiaU4I9FQi7moOBEAQhSrKUMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7qKjwriDJa/V7ZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkf5jSxFGz8xFgxf0kXUwPjhNOMXYycHBICJhI3zi5h6mLk4hASWMoo
        cWfLD7YuRg6ghIzE8fVlEDXCEn+udbFB1HxilJjwu4EZJMEmYCUxsX0V2CARAQWJnt8rwYqY
        Bb4ySiyd1A1WJCzgL7F45g8WEJtFQFXi08IpYA28ArYSjf/vQF0hL7H12ydWEJsTKH7t8D82
        EFtIwEbixZv/TBD1ghInZz4Bm8MMVN+8dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbUK07M
        LS7NS9dLzs/dxAiMmm3Hfm7ewXhpY/AhRgEORiUeXo4NBXFCrIllxZW5hxglOJiVRHgXF+bH
        CfGmJFZWpRblxxeV5qQWH2I0BXpiIrOUaHI+MKLzSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJ
        pCeWpGanphakFsH0MXFwSjUwtm0QKnduijx9eI7si6bJV72Pmdppl06zXPPSY0lqdYS98dMb
        Ry47TVL0s+abo36JSbn3ylotscuyETcU5jWyq7+2recRrPifNvVIv7bDX5GFKR/zNs8TNLpT
        b/o+8cnyO7c+WP05+ePYxFDWR81xj/6dOVZXv96i52JIkrqY2/alHod/bjnYr8RSnJFoqMVc
        VJwIAMDJ1FuwAgAA
X-CMS-MailID: 20200317144345eucas1p209f6a96605af02cc451786051ebab395
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144345eucas1p209f6a96605af02cc451786051ebab395
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144345eucas1p209f6a96605af02cc451786051ebab395
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144345eucas1p209f6a96605af02cc451786051ebab395@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Move EXPORT_SYMBOL_GPL()s close to exported code like it is
done in other kernel subsystems. As a nice side effect this
results in the removal of few ifdefs.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 210 +++++++++++++++-----------------------
 drivers/ata/libata-eh.c   |  20 +++-
 drivers/ata/libata-scsi.c |   8 ++
 3 files changed, 110 insertions(+), 128 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9660c1af5156..dae625fc5e8a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -18,6 +18,11 @@
  *	http://www.compactflash.org (CF)
  *	http://www.qic.org (QIC157 - Tape and DSC)
  *	http://www.ce-ata.org (CE-ATA: not supported)
+ *
+ * libata is essentially a library of internal helper functions for
+ * low-level ATA host controller drivers.  As such, the API/ABI is
+ * likely to change as new drivers are added and updated.
+ * Do not depend on ABI/API stability.
  */
 
 #include <linux/kernel.h>
@@ -62,8 +67,11 @@
 
 /* debounce timing parameters in msecs { interval, duration, timeout } */
 const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
 const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
 const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_long);
 
 const struct ata_port_operations ata_base_port_ops = {
 	.prereset		= ata_std_prereset,
@@ -72,6 +80,7 @@ const struct ata_port_operations ata_base_port_ops = {
 	.sched_eh		= ata_std_sched_eh,
 	.end_eh			= ata_std_end_eh,
 };
+EXPORT_SYMBOL_GPL(ata_base_port_ops);
 
 const struct ata_port_operations sata_port_ops = {
 	.inherits		= &ata_base_port_ops,
@@ -79,6 +88,7 @@ const struct ata_port_operations sata_port_ops = {
 	.qc_defer		= ata_std_qc_defer,
 	.hardreset		= sata_std_hardreset,
 };
+EXPORT_SYMBOL_GPL(sata_port_ops);
 
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
@@ -221,6 +231,7 @@ struct ata_link *ata_link_next(struct ata_link *link, struct ata_port *ap,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(ata_link_next);
 
 /**
  *	ata_dev_next - device iteration helper
@@ -274,6 +285,7 @@ struct ata_device *ata_dev_next(struct ata_device *dev, struct ata_link *link,
 		goto next;
 	return dev;
 }
+EXPORT_SYMBOL_GPL(ata_dev_next);
 
 /**
  *	ata_dev_phys_link - find physical link for a device
@@ -518,6 +530,7 @@ int atapi_cmd_type(u8 opcode)
 		return ATAPI_MISC;
 	}
 }
+EXPORT_SYMBOL_GPL(atapi_cmd_type);
 
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
@@ -562,6 +575,7 @@ void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 	fis[18] = (tf->auxiliary >> 16) & 0xff;
 	fis[19] = (tf->auxiliary >> 24) & 0xff;
 }
+EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 
 /**
  *	ata_tf_from_fis - Convert SATA FIS to ATA taskfile
@@ -591,6 +605,7 @@ void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf)
 	tf->nsect	= fis[12];
 	tf->hob_nsect	= fis[13];
 }
+EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 
 static const u8 ata_rw_cmds[] = {
 	/* pio multi */
@@ -862,6 +877,7 @@ unsigned long ata_pack_xfermask(unsigned long pio_mask,
 		((mwdma_mask << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA) |
 		((udma_mask << ATA_SHIFT_UDMA) & ATA_MASK_UDMA);
 }
+EXPORT_SYMBOL_GPL(ata_pack_xfermask);
 
 /**
  *	ata_unpack_xfermask - Unpack xfer_mask into pio, mwdma and udma masks
@@ -883,6 +899,7 @@ void ata_unpack_xfermask(unsigned long xfer_mask, unsigned long *pio_mask,
 	if (udma_mask)
 		*udma_mask = (xfer_mask & ATA_MASK_UDMA) >> ATA_SHIFT_UDMA;
 }
+EXPORT_SYMBOL_GPL(ata_unpack_xfermask);
 
 static const struct ata_xfer_ent {
 	int shift, bits;
@@ -917,6 +934,7 @@ u8 ata_xfer_mask2mode(unsigned long xfer_mask)
 			return ent->base + highbit - ent->shift;
 	return 0xff;
 }
+EXPORT_SYMBOL_GPL(ata_xfer_mask2mode);
 
 /**
  *	ata_xfer_mode2mask - Find matching xfer_mask for XFER_*
@@ -940,6 +958,7 @@ unsigned long ata_xfer_mode2mask(u8 xfer_mode)
 				& ~((1 << ent->shift) - 1);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_xfer_mode2mask);
 
 /**
  *	ata_xfer_mode2shift - Find matching xfer_shift for XFER_*
@@ -962,6 +981,7 @@ int ata_xfer_mode2shift(unsigned long xfer_mode)
 			return ent->shift;
 	return -1;
 }
+EXPORT_SYMBOL_GPL(ata_xfer_mode2shift);
 
 /**
  *	ata_mode_string - convert xfer_mask to string
@@ -1008,6 +1028,7 @@ const char *ata_mode_string(unsigned long xfer_mask)
 		return xfer_mode_str[highbit];
 	return "<n/a>";
 }
+EXPORT_SYMBOL_GPL(ata_mode_string);
 
 const char *sata_spd_string(unsigned int spd)
 {
@@ -1098,6 +1119,7 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
 
 	return ATA_DEV_UNKNOWN;
 }
+EXPORT_SYMBOL_GPL(ata_dev_classify);
 
 /**
  *	ata_port_classify - determine device type based on ATA-spec signature
@@ -1122,6 +1144,7 @@ unsigned int ata_port_classify(struct ata_port *ap,
 		ata_port_dbg(ap, "found unknown device\n");
 	return class;
 }
+EXPORT_SYMBOL_GPL(ata_port_classify);
 
 /**
  *	ata_id_string - Convert IDENTIFY DEVICE page into string
@@ -1158,6 +1181,7 @@ void ata_id_string(const u16 *id, unsigned char *s,
 		len -= 2;
 	}
 }
+EXPORT_SYMBOL_GPL(ata_id_string);
 
 /**
  *	ata_id_c_string - Convert IDENTIFY DEVICE page into C string
@@ -1185,6 +1209,7 @@ void ata_id_c_string(const u16 *id, unsigned char *s,
 		p--;
 	*p = '\0';
 }
+EXPORT_SYMBOL_GPL(ata_id_c_string);
 
 static u64 ata_id_n_sectors(const u16 *id)
 {
@@ -1525,6 +1550,7 @@ unsigned long ata_id_xfermask(const u16 *id)
 
 	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
 }
+EXPORT_SYMBOL_GPL(ata_id_xfermask);
 
 static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
@@ -1782,6 +1808,7 @@ unsigned int ata_pio_need_iordy(const struct ata_device *adev)
 		return 1;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
 
 /**
  *	ata_pio_mask_no_iordy	-	Return the non IORDY mask
@@ -1822,6 +1849,7 @@ unsigned int ata_do_dev_read_id(struct ata_device *dev,
 	return ata_exec_internal(dev, tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS, 0);
 }
+EXPORT_SYMBOL_GPL(ata_do_dev_read_id);
 
 /**
  *	ata_dev_read_id - Read ID data from the specified device
@@ -2791,6 +2819,7 @@ int ata_cable_40wire(struct ata_port *ap)
 {
 	return ATA_CBL_PATA40;
 }
+EXPORT_SYMBOL_GPL(ata_cable_40wire);
 
 /**
  *	ata_cable_80wire	-	return 80 wire cable type
@@ -2804,6 +2833,7 @@ int ata_cable_80wire(struct ata_port *ap)
 {
 	return ATA_CBL_PATA80;
 }
+EXPORT_SYMBOL_GPL(ata_cable_80wire);
 
 /**
  *	ata_cable_unknown	-	return unknown PATA cable.
@@ -2816,6 +2846,7 @@ int ata_cable_unknown(struct ata_port *ap)
 {
 	return ATA_CBL_PATA_UNK;
 }
+EXPORT_SYMBOL_GPL(ata_cable_unknown);
 
 /**
  *	ata_cable_ignore	-	return ignored PATA cable.
@@ -2828,6 +2859,7 @@ int ata_cable_ignore(struct ata_port *ap)
 {
 	return ATA_CBL_PATA_IGN;
 }
+EXPORT_SYMBOL_GPL(ata_cable_ignore);
 
 /**
  *	ata_cable_sata	-	return SATA cable type
@@ -2840,6 +2872,7 @@ int ata_cable_sata(struct ata_port *ap)
 {
 	return ATA_CBL_SATA;
 }
+EXPORT_SYMBOL_GPL(ata_cable_sata);
 
 /**
  *	ata_bus_probe - Reset and probe ATA bus
@@ -3022,6 +3055,7 @@ struct ata_device *ata_dev_pair(struct ata_device *adev)
 		return NULL;
 	return pair;
 }
+EXPORT_SYMBOL_GPL(ata_dev_pair);
 
 /**
  *	sata_down_spd_limit - adjust SATA spd limit downward
@@ -3182,6 +3216,7 @@ int sata_set_spd(struct ata_link *link)
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(sata_set_spd);
 
 /*
  * This mode timing computation functionality is ported over from
@@ -3256,6 +3291,7 @@ void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
 	if (what & ATA_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
 	if (what & ATA_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
 }
+EXPORT_SYMBOL_GPL(ata_timing_merge);
 
 const struct ata_timing *ata_timing_find_mode(u8 xfer_mode)
 {
@@ -3272,6 +3308,7 @@ const struct ata_timing *ata_timing_find_mode(u8 xfer_mode)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(ata_timing_find_mode);
 
 int ata_timing_compute(struct ata_device *adev, unsigned short speed,
 		       struct ata_timing *t, int T, int UT)
@@ -3348,6 +3385,7 @@ int ata_timing_compute(struct ata_device *adev, unsigned short speed,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_timing_compute);
 
 /**
  *	ata_timing_cycle2mode - find xfer mode for the specified cycle duration
@@ -3399,6 +3437,7 @@ u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle)
 
 	return last_mode;
 }
+EXPORT_SYMBOL_GPL(ata_timing_cycle2mode);
 
 /**
  *	ata_down_xfermask_limit - adjust dev xfer masks downward
@@ -3670,6 +3709,7 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 		*r_failed_dev = dev;
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_do_set_mode);
 
 /**
  *	ata_wait_ready - wait for link to become ready
@@ -3779,6 +3819,7 @@ int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 
 	return ata_wait_ready(link, deadline, check_ready);
 }
+EXPORT_SYMBOL_GPL(ata_wait_after_reset);
 
 /**
  *	sata_link_debounce - debounce SATA phy status
@@ -3849,6 +3890,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 			return -EPIPE;
 	}
 }
+EXPORT_SYMBOL_GPL(sata_link_debounce);
 
 /**
  *	sata_link_resume - resume SATA link
@@ -3915,6 +3957,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 
 	return rc != -EINVAL ? rc : 0;
 }
+EXPORT_SYMBOL_GPL(sata_link_resume);
 
 /**
  *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
@@ -3989,6 +4032,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	ehc->i.serror &= ~SERR_PHYRDY_CHG;
 	return sata_scr_write(link, SCR_ERROR, SERR_PHYRDY_CHG);
 }
+EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
 
 /**
  *	ata_std_prereset - prepare for reset
@@ -4034,6 +4078,7 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_std_prereset);
 
 /**
  *	sata_link_hardreset - reset link via SATA phy reset
@@ -4143,6 +4188,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	}
 	return rc;
 }
+EXPORT_SYMBOL_GPL(sata_link_hardreset);
 
 /**
  *	sata_std_hardreset - COMRESET w/o waiting or classification
@@ -4169,6 +4215,7 @@ int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
 	return online ? -EAGAIN : rc;
 }
+EXPORT_SYMBOL_GPL(sata_std_hardreset);
 
 /**
  *	ata_std_postreset - standard postreset callback
@@ -4193,6 +4240,7 @@ void ata_std_postreset(struct ata_link *link, unsigned int *classes)
 	/* print link status */
 	sata_print_link_status(link);
 }
+EXPORT_SYMBOL_GPL(ata_std_postreset);
 
 /**
  *	ata_dev_same_device - Determine whether new ID matches configured device
@@ -4982,11 +5030,13 @@ int ata_std_qc_defer(struct ata_queued_cmd *qc)
 
 	return ATA_DEFER_LINK;
 }
+EXPORT_SYMBOL_GPL(ata_std_qc_defer);
 
 enum ata_completion_errors ata_noop_qc_prep(struct ata_queued_cmd *qc)
 {
 	return AC_ERR_OK;
 }
+EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
 
 /**
  *	ata_sg_init - Associate command with scatter-gather table.
@@ -5008,6 +5058,7 @@ void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 	qc->n_elem = n_elem;
 	qc->cursg = qc->sg;
 }
+EXPORT_SYMBOL_GPL(ata_sg_init);
 
 #ifdef CONFIG_HAS_DMA
 
@@ -5328,6 +5379,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		__ata_qc_complete(qc);
 	}
 }
+EXPORT_SYMBOL_GPL(ata_qc_complete);
 
 /**
  *	ata_qc_get_active - get bitmask of active qcs
@@ -5410,6 +5462,7 @@ int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
 
 	return nr_done;
 }
+EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
 
 /**
  *	ata_qc_issue - issue taskfile to device
@@ -5504,6 +5557,7 @@ int sata_scr_valid(struct ata_link *link)
 
 	return (ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read;
 }
+EXPORT_SYMBOL_GPL(sata_scr_valid);
 
 /**
  *	sata_scr_read - read SCR register of the specified port
@@ -5531,6 +5585,7 @@ int sata_scr_read(struct ata_link *link, int reg, u32 *val)
 
 	return sata_pmp_scr_read(link, reg, val);
 }
+EXPORT_SYMBOL_GPL(sata_scr_read);
 
 /**
  *	sata_scr_write - write SCR register of the specified port
@@ -5558,6 +5613,7 @@ int sata_scr_write(struct ata_link *link, int reg, u32 val)
 
 	return sata_pmp_scr_write(link, reg, val);
 }
+EXPORT_SYMBOL_GPL(sata_scr_write);
 
 /**
  *	sata_scr_write_flush - write SCR register of the specified port and flush
@@ -5590,6 +5646,7 @@ int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 
 	return sata_pmp_scr_write(link, reg, val);
 }
+EXPORT_SYMBOL_GPL(sata_scr_write_flush);
 
 /**
  *	ata_phys_link_online - test whether the given link is online
@@ -5664,6 +5721,7 @@ bool ata_link_online(struct ata_link *link)
 	return ata_phys_link_online(link) ||
 		(slave && ata_phys_link_online(slave));
 }
+EXPORT_SYMBOL_GPL(ata_link_online);
 
 /**
  *	ata_link_offline - test whether the given link is offline
@@ -5690,6 +5748,7 @@ bool ata_link_offline(struct ata_link *link)
 	return ata_phys_link_offline(link) &&
 		(!slave || ata_phys_link_offline(slave));
 }
+EXPORT_SYMBOL_GPL(ata_link_offline);
 
 #ifdef CONFIG_PM
 static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
@@ -5876,6 +5935,7 @@ int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
 	host->dev->power.power_state = mesg;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_host_suspend);
 
 /**
  *	ata_host_resume - resume host
@@ -5887,6 +5947,7 @@ void ata_host_resume(struct ata_host *host)
 {
 	host->dev->power.power_state = PMSG_ON;
 }
+EXPORT_SYMBOL_GPL(ata_host_resume);
 #endif
 
 const struct device_type ata_port_type = {
@@ -6097,11 +6158,13 @@ void ata_host_get(struct ata_host *host)
 {
 	kref_get(&host->kref);
 }
+EXPORT_SYMBOL_GPL(ata_host_get);
 
 void ata_host_put(struct ata_host *host)
 {
 	kref_put(&host->kref, ata_host_release);
 }
+EXPORT_SYMBOL_GPL(ata_host_put);
 
 /**
  *	ata_host_alloc - allocate and init basic ATA host resources
@@ -6173,6 +6236,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	kfree(host);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(ata_host_alloc);
 
 /**
  *	ata_host_alloc_pinfo - alloc host and init with port_info array
@@ -6221,6 +6285,7 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 
 	return host;
 }
+EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
 
 /**
  *	ata_slave_link_init - initialize slave link
@@ -6283,6 +6348,7 @@ int ata_slave_link_init(struct ata_port *ap)
 	ap->slave_link = link;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_slave_link_init);
 
 static void ata_host_stop(struct device *gendev, void *res)
 {
@@ -6431,6 +6497,7 @@ int ata_host_start(struct ata_host *host)
 	devres_free(start_dr);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_host_start);
 
 /**
  *	ata_sas_host_init - Initialize a host struct for sas (ipr, libsas)
@@ -6449,6 +6516,7 @@ void ata_host_init(struct ata_host *host, struct device *dev,
 	host->ops = ops;
 	kref_init(&host->kref);
 }
+EXPORT_SYMBOL_GPL(ata_host_init);
 
 void __ata_port_probe(struct ata_port *ap)
 {
@@ -6602,6 +6670,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	return rc;
 
 }
+EXPORT_SYMBOL_GPL(ata_host_register);
 
 /**
  *	ata_host_activate - start host, request IRQ and register it
@@ -6664,6 +6733,7 @@ int ata_host_activate(struct ata_host *host, int irq,
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_host_activate);
 
 /**
  *	ata_port_detach - Detach ATA port in preparation of device removal
@@ -6739,6 +6809,7 @@ void ata_host_detach(struct ata_host *host)
 	/* the host is dead now, dissociate ACPI */
 	ata_acpi_dissociate(host);
 }
+EXPORT_SYMBOL_GPL(ata_host_detach);
 
 #ifdef CONFIG_PCI
 
@@ -6759,6 +6830,7 @@ void ata_pci_remove_one(struct pci_dev *pdev)
 
 	ata_host_detach(host);
 }
+EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 
 void ata_pci_shutdown_one(struct pci_dev *pdev)
 {
@@ -6779,6 +6851,7 @@ void ata_pci_shutdown_one(struct pci_dev *pdev)
 			ap->ops->port_stop(ap);
 	}
 }
+EXPORT_SYMBOL_GPL(ata_pci_shutdown_one);
 
 /* move to PCI subsystem */
 int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
@@ -6813,6 +6886,7 @@ int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
 
 	return (tmp == bits->val) ? 1 : 0;
 }
+EXPORT_SYMBOL_GPL(pci_test_config_bits);
 
 #ifdef CONFIG_PM
 void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
@@ -6823,6 +6897,7 @@ void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	if (mesg.event & PM_EVENT_SLEEP)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
+EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
 
 int ata_pci_device_do_resume(struct pci_dev *pdev)
 {
@@ -6841,6 +6916,7 @@ int ata_pci_device_do_resume(struct pci_dev *pdev)
 	pci_set_master(pdev);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
@@ -6855,6 +6931,7 @@ int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 
 int ata_pci_device_resume(struct pci_dev *pdev)
 {
@@ -6866,8 +6943,8 @@ int ata_pci_device_resume(struct pci_dev *pdev)
 		ata_host_resume(host);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 #endif /* CONFIG_PM */
-
 #endif /* CONFIG_PCI */
 
 /**
@@ -6889,6 +6966,7 @@ int ata_platform_remove_one(struct platform_device *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 
 static int __init ata_parse_force_one(char **cur,
 				      struct ata_force_ent *force_ent,
@@ -7113,6 +7191,7 @@ int ata_ratelimit(void)
 {
 	return __ratelimit(&ratelimit);
 }
+EXPORT_SYMBOL_GPL(ata_ratelimit);
 
 /**
  *	ata_msleep - ATA EH owner aware msleep
@@ -7145,6 +7224,7 @@ void ata_msleep(struct ata_port *ap, unsigned int msecs)
 	if (owns_eh)
 		ata_eh_acquire(ap);
 }
+EXPORT_SYMBOL_GPL(ata_msleep);
 
 /**
  *	ata_wait_register - wait until register value changes
@@ -7191,6 +7271,7 @@ u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask, u32 val,
 
 	return tmp;
 }
+EXPORT_SYMBOL_GPL(ata_wait_register);
 
 /**
  *	sata_lpm_ignore_phy_events - test if PHY event should be ignored
@@ -7244,10 +7325,12 @@ struct ata_port_operations ata_dummy_port_ops = {
 	.sched_eh		= ata_std_sched_eh,
 	.end_eh			= ata_std_end_eh,
 };
+EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 
 const struct ata_port_info ata_dummy_port_info = {
 	.port_ops		= &ata_dummy_port_ops,
 };
+EXPORT_SYMBOL_GPL(ata_dummy_port_info);
 
 void ata_print_version(const struct device *dev, const char *version)
 {
@@ -7255,131 +7338,6 @@ void ata_print_version(const struct device *dev, const char *version)
 }
 EXPORT_SYMBOL(ata_print_version);
 
-/*
- * libata is essentially a library of internal helper functions for
- * low-level ATA host controller drivers.  As such, the API/ABI is
- * likely to change as new drivers are added and updated.
- * Do not depend on ABI/API stability.
- */
-EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
-EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
-EXPORT_SYMBOL_GPL(sata_deb_timing_long);
-EXPORT_SYMBOL_GPL(ata_base_port_ops);
-EXPORT_SYMBOL_GPL(sata_port_ops);
-EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
-EXPORT_SYMBOL_GPL(ata_dummy_port_info);
-EXPORT_SYMBOL_GPL(ata_link_next);
-EXPORT_SYMBOL_GPL(ata_dev_next);
-EXPORT_SYMBOL_GPL(ata_std_bios_param);
-EXPORT_SYMBOL_GPL(ata_scsi_unlock_native_capacity);
-EXPORT_SYMBOL_GPL(ata_host_init);
-EXPORT_SYMBOL_GPL(ata_host_alloc);
-EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
-EXPORT_SYMBOL_GPL(ata_slave_link_init);
-EXPORT_SYMBOL_GPL(ata_host_start);
-EXPORT_SYMBOL_GPL(ata_host_register);
-EXPORT_SYMBOL_GPL(ata_host_activate);
-EXPORT_SYMBOL_GPL(ata_host_detach);
-EXPORT_SYMBOL_GPL(ata_sg_init);
-EXPORT_SYMBOL_GPL(ata_qc_complete);
-EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
-EXPORT_SYMBOL_GPL(atapi_cmd_type);
-EXPORT_SYMBOL_GPL(ata_tf_to_fis);
-EXPORT_SYMBOL_GPL(ata_tf_from_fis);
-EXPORT_SYMBOL_GPL(ata_pack_xfermask);
-EXPORT_SYMBOL_GPL(ata_unpack_xfermask);
-EXPORT_SYMBOL_GPL(ata_xfer_mask2mode);
-EXPORT_SYMBOL_GPL(ata_xfer_mode2mask);
-EXPORT_SYMBOL_GPL(ata_xfer_mode2shift);
-EXPORT_SYMBOL_GPL(ata_mode_string);
-EXPORT_SYMBOL_GPL(ata_id_xfermask);
-EXPORT_SYMBOL_GPL(ata_do_set_mode);
-EXPORT_SYMBOL_GPL(ata_std_qc_defer);
-EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
-EXPORT_SYMBOL_GPL(ata_dev_disable);
-EXPORT_SYMBOL_GPL(sata_set_spd);
-EXPORT_SYMBOL_GPL(ata_wait_after_reset);
-EXPORT_SYMBOL_GPL(sata_link_debounce);
-EXPORT_SYMBOL_GPL(sata_link_resume);
-EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
-EXPORT_SYMBOL_GPL(ata_std_prereset);
-EXPORT_SYMBOL_GPL(sata_link_hardreset);
-EXPORT_SYMBOL_GPL(sata_std_hardreset);
-EXPORT_SYMBOL_GPL(ata_std_postreset);
-EXPORT_SYMBOL_GPL(ata_dev_classify);
-EXPORT_SYMBOL_GPL(ata_port_classify);
-EXPORT_SYMBOL_GPL(ata_dev_pair);
-EXPORT_SYMBOL_GPL(ata_ratelimit);
-EXPORT_SYMBOL_GPL(ata_msleep);
-EXPORT_SYMBOL_GPL(ata_wait_register);
-EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
-EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
-EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
-EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-EXPORT_SYMBOL_GPL(__ata_change_queue_depth);
-EXPORT_SYMBOL_GPL(sata_scr_valid);
-EXPORT_SYMBOL_GPL(sata_scr_read);
-EXPORT_SYMBOL_GPL(sata_scr_write);
-EXPORT_SYMBOL_GPL(sata_scr_write_flush);
-EXPORT_SYMBOL_GPL(ata_link_online);
-EXPORT_SYMBOL_GPL(ata_link_offline);
-#ifdef CONFIG_PM
-EXPORT_SYMBOL_GPL(ata_host_suspend);
-EXPORT_SYMBOL_GPL(ata_host_resume);
-#endif /* CONFIG_PM */
-EXPORT_SYMBOL_GPL(ata_id_string);
-EXPORT_SYMBOL_GPL(ata_id_c_string);
-EXPORT_SYMBOL_GPL(ata_do_dev_read_id);
-EXPORT_SYMBOL_GPL(ata_scsi_simulate);
-
-EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
-EXPORT_SYMBOL_GPL(ata_timing_find_mode);
-EXPORT_SYMBOL_GPL(ata_timing_compute);
-EXPORT_SYMBOL_GPL(ata_timing_merge);
-EXPORT_SYMBOL_GPL(ata_timing_cycle2mode);
-
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL_GPL(pci_test_config_bits);
-EXPORT_SYMBOL_GPL(ata_pci_shutdown_one);
-EXPORT_SYMBOL_GPL(ata_pci_remove_one);
-#ifdef CONFIG_PM
-EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
-EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
-EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
-EXPORT_SYMBOL_GPL(ata_pci_device_resume);
-#endif /* CONFIG_PM */
-#endif /* CONFIG_PCI */
-
-EXPORT_SYMBOL_GPL(ata_platform_remove_one);
-
-EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
-EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
-EXPORT_SYMBOL_GPL(ata_ehi_clear_desc);
-EXPORT_SYMBOL_GPL(ata_port_desc);
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL_GPL(ata_port_pbar_desc);
-#endif /* CONFIG_PCI */
-EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
-EXPORT_SYMBOL_GPL(ata_link_abort);
-EXPORT_SYMBOL_GPL(ata_port_abort);
-EXPORT_SYMBOL_GPL(ata_port_freeze);
-EXPORT_SYMBOL_GPL(sata_async_notification);
-EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
-EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
-EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
-EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
-EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
-EXPORT_SYMBOL_GPL(ata_do_eh);
-EXPORT_SYMBOL_GPL(ata_std_error_handler);
-
-EXPORT_SYMBOL_GPL(ata_cable_40wire);
-EXPORT_SYMBOL_GPL(ata_cable_80wire);
-EXPORT_SYMBOL_GPL(ata_cable_unknown);
-EXPORT_SYMBOL_GPL(ata_cable_ignore);
-EXPORT_SYMBOL_GPL(ata_cable_sata);
-EXPORT_SYMBOL_GPL(ata_host_get);
-EXPORT_SYMBOL_GPL(ata_host_put);
-
 EXPORT_TRACEPOINT_SYMBOL_GPL(ata_tf_load);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ata_exec_command);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ata_bmdma_setup);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a14e26aa1391..827d437d8cb4 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -180,6 +180,7 @@ void __ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...)
 	__ata_ehi_pushv_desc(ehi, fmt, args);
 	va_end(args);
 }
+EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
 
 /**
  *	ata_ehi_push_desc - push error description with separator
@@ -203,6 +204,7 @@ void ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...)
 	__ata_ehi_pushv_desc(ehi, fmt, args);
 	va_end(args);
 }
+EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
 
 /**
  *	ata_ehi_clear_desc - clean error description
@@ -218,6 +220,7 @@ void ata_ehi_clear_desc(struct ata_eh_info *ehi)
 	ehi->desc[0] = '\0';
 	ehi->desc_len = 0;
 }
+EXPORT_SYMBOL_GPL(ata_ehi_clear_desc);
 
 /**
  *	ata_port_desc - append port description
@@ -245,9 +248,9 @@ void ata_port_desc(struct ata_port *ap, const char *fmt, ...)
 	__ata_ehi_pushv_desc(&ap->link.eh_info, fmt, args);
 	va_end(args);
 }
+EXPORT_SYMBOL_GPL(ata_port_desc);
 
 #ifdef CONFIG_PCI
-
 /**
  *	ata_port_pbar_desc - append PCI BAR description
  *	@ap: target ATA port
@@ -284,7 +287,7 @@ void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
 		ata_port_desc(ap, "%s 0x%llx", name,
 				start + (unsigned long long)offset);
 }
-
+EXPORT_SYMBOL_GPL(ata_port_pbar_desc);
 #endif /* CONFIG_PCI */
 
 static int ata_lookup_timeout_table(u8 cmd)
@@ -966,6 +969,7 @@ void ata_port_schedule_eh(struct ata_port *ap)
 	/* see: ata_std_sched_eh, unless you know better */
 	ap->ops->sched_eh(ap);
 }
+EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 
 static int ata_do_link_abort(struct ata_port *ap, struct ata_link *link)
 {
@@ -1008,6 +1012,7 @@ int ata_link_abort(struct ata_link *link)
 {
 	return ata_do_link_abort(link->ap, link);
 }
+EXPORT_SYMBOL_GPL(ata_link_abort);
 
 /**
  *	ata_port_abort - abort all qc's on the port
@@ -1025,6 +1030,7 @@ int ata_port_abort(struct ata_port *ap)
 {
 	return ata_do_link_abort(ap, NULL);
 }
+EXPORT_SYMBOL_GPL(ata_port_abort);
 
 /**
  *	__ata_port_freeze - freeze port
@@ -1081,6 +1087,7 @@ int ata_port_freeze(struct ata_port *ap)
 
 	return nr_aborted;
 }
+EXPORT_SYMBOL_GPL(ata_port_freeze);
 
 /**
  *	sata_async_notification - SATA async notification handler
@@ -1154,6 +1161,7 @@ int sata_async_notification(struct ata_port *ap)
 		return 0;
 	}
 }
+EXPORT_SYMBOL_GPL(sata_async_notification);
 
 /**
  *	ata_eh_freeze_port - EH helper to freeze port
@@ -1175,6 +1183,7 @@ void ata_eh_freeze_port(struct ata_port *ap)
 	__ata_port_freeze(ap);
 	spin_unlock_irqrestore(ap->lock, flags);
 }
+EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
 
 /**
  *	ata_port_thaw_port - EH helper to thaw port
@@ -1203,6 +1212,7 @@ void ata_eh_thaw_port(struct ata_port *ap)
 
 	trace_ata_port_thaw(ap);
 }
+EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
 {
@@ -1237,6 +1247,7 @@ void ata_eh_qc_complete(struct ata_queued_cmd *qc)
 	scmd->retries = scmd->allowed;
 	__ata_eh_qc_complete(qc);
 }
+EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 
 /**
  *	ata_eh_qc_retry - Tell midlayer to retry an ATA command after EH
@@ -1256,6 +1267,7 @@ void ata_eh_qc_retry(struct ata_queued_cmd *qc)
 		scmd->allowed++;
 	__ata_eh_qc_complete(qc);
 }
+EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 
 /**
  *	ata_dev_disable - disable ATA device
@@ -1282,6 +1294,7 @@ void ata_dev_disable(struct ata_device *dev)
 	 */
 	ata_ering_clear(&dev->ering);
 }
+EXPORT_SYMBOL_GPL(ata_dev_disable);
 
 /**
  *	ata_eh_detach_dev - detach ATA device
@@ -1724,6 +1737,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
+EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
 
 /**
  *	ata_eh_analyze_tf - analyze taskfile of a failed qc
@@ -4030,6 +4044,7 @@ void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 	ata_eh_finish(ap);
 }
+EXPORT_SYMBOL_GPL(ata_do_eh);
 
 /**
  *	ata_std_error_handler - standard error handler
@@ -4051,6 +4066,7 @@ void ata_std_error_handler(struct ata_port *ap)
 
 	ata_do_eh(ap, ops->prereset, ops->softreset, hardreset, ops->postreset);
 }
+EXPORT_SYMBOL_GPL(ata_std_error_handler);
 
 #ifdef CONFIG_PM
 /**
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7bdda82fe886..2b0262aa3bcc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -502,6 +502,7 @@ int ata_std_bios_param(struct scsi_device *sdev, struct block_device *bdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_std_bios_param);
 
 /**
  *	ata_scsi_unlock_native_capacity - unlock native capacity
@@ -531,6 +532,7 @@ void ata_scsi_unlock_native_capacity(struct scsi_device *sdev)
 	spin_unlock_irqrestore(ap->lock, flags);
 	ata_port_wait_eh(ap);
 }
+EXPORT_SYMBOL_GPL(ata_scsi_unlock_native_capacity);
 
 /**
  *	ata_get_identity - Handler for HDIO_GET_IDENTITY ioctl
@@ -1347,6 +1349,7 @@ int ata_scsi_slave_config(struct scsi_device *sdev)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 
 /**
  *	ata_scsi_slave_destroy - SCSI device is about to be destroyed
@@ -1386,6 +1389,7 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
 	q->dma_drain_buffer = NULL;
 	q->dma_drain_size = 0;
 }
+EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 
 /**
  *	__ata_change_queue_depth - helper for ata_scsi_change_queue_depth
@@ -1429,6 +1433,7 @@ int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
 
 	return scsi_change_queue_depth(sdev, queue_depth);
 }
+EXPORT_SYMBOL_GPL(__ata_change_queue_depth);
 
 /**
  *	ata_scsi_change_queue_depth - SCSI callback for queue depth config
@@ -1451,6 +1456,7 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 
 	return __ata_change_queue_depth(ap, sdev, queue_depth);
 }
+EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 
 /**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
@@ -4392,6 +4398,7 @@ int ata_scsi_queuecmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
@@ -4515,6 +4522,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 
 	cmd->scsi_done(cmd);
 }
+EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 {
-- 
2.24.1

