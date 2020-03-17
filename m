Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71968C18E5B
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD83205ED
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kKLmIcmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgCQOoo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40384 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgCQOnv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144349euoutp0249711aceeb6a81239aa91ad863e5e1a5~9HovGRDYe1539415394euoutp02d
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144349euoutp0249711aceeb6a81239aa91ad863e5e1a5~9HovGRDYe1539415394euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456229;
        bh=fIlm3ITBgwbptURlCawUpKL68qsXuBK785QMBGuUUaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKLmIcmT8LmF6Khf/d5KxWpwU+DEBjIVT3T8jRo6BryZqJ3PAyaOrflz48MOwXAMJ
         MZ6WmN3lzQOM32TZ/KwmRWkd6H1qu4oEIVZGjC+UA2vCMN1cRih632F0+PctM3RTdP
         isfXikCb8B+2o1u8G+W4GVkS8HYBsfiZ/WtQz/eo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144349eucas1p1c8493d62126d723d3b5063eb758f434e~9Hou3EmTu1082710827eucas1p1n;
        Tue, 17 Mar 2020 14:43:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 84.E9.60698.522E07E5; Tue, 17
        Mar 2020 14:43:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144349eucas1p1921dee3dcd097f695ba708c54325f226~9HounmEC21084510845eucas1p1S;
        Tue, 17 Mar 2020 14:43:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144349eusmtrp27c8480b9a899148d28abec26b60084f6~9HounAcyX0147801478eusmtrp2A;
        Tue, 17 Mar 2020 14:43:49 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-ee-5e70e2253ccc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.23.07950.422E07E5; Tue, 17
        Mar 2020 14:43:48 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144348eusmtip1c85b3ac90a69a8162707bbb023e091d0~9HouI0MnW0538205382eusmtip1L;
        Tue, 17 Mar 2020 14:43:48 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 16/27] ata: start separating SATA specific code from
 libata-core.c
Date:   Tue, 17 Mar 2020 15:43:22 +0100
Message-Id: <20200317144333.2904-17-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7qqjwriDA71ClisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErowVsz8yF8yazVhx/3xsA+P26i5GTg4J
        AROJg9/XM3cxcnEICaxglDhycSULhPOFUeJYzzUmCOczo8TKabvZYFpOHG9ihEgsZ5SY93I2
        E1zLw+cLWEGq2ASsJCa2r2IEsUUEFCR6fq9kAyliFnjPKLFi0l6gJRwcwgLhEp8We4DUsAio
        SuxsOcMMYvMK2Eo8mT2JGWKbvMTWb5/AZnICxa8d/scGUSMocXLmExYQmxmopnnrbKj6VewS
        W1ptIWwXia7Jm1khbGGJV8e3sEPYMhL/d84HO1pCYB2jxN+OF8wQznZGieWT/0H9aS1x59wv
        NpBDmQU0Jdbv0ocIO0ocbmxkAglLCPBJ3HgrCHEDn8SkbdOZIcK8Eh1tQhDVahIblm1gg1nb
        tXMl1JkeEtsP9DFOYFScheSbWUi+mYWwdwEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95Pzc
        TYzARHT63/GvOxj3/Uk6xCjAwajEw5uwqSBOiDWxrLgy9xCjBAezkgjv4sL8OCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYWfLub0+/cemG9rPb11sP
        GAuf2Cd2Nn5KMP8Mb/vCH/evbTXbP0W75XcS42mR1L7crB8BJdP7+GOUbndXxMw2jQqI/CT7
        ttthNt+3wBsTj3Sa3G//F+aYauukabLWz6em0UlCWs/9T0yjEvOksJQ4PabF2W/Vvu8XM+HY
        92uywoGPTJIippZKLMUZiYZazEXFiQDmkOGRQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7oqjwriDOYfsLFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkrZn9kLpg1m7Hi/vnYBsbt1V2MnBwSAiYSJ443MXYxcnEICSxllDj5
        5iBLFyMHUEJG4vj6MogaYYk/17rYIGo+MUrc2bqMBSTBJmAlMbF9FSOILSKgINHzeyVYEbPA
        V0aJpZO6mUESwgKhEqsPT2MCsVkEVCV2tpwBi/MK2Eo8mT2JGWKDvMTWb59YQWxOoPi1w//Y
        QGwhARuJF2/+M0HUC0qcnPkEbDEzUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgx
        t7g0L10vOT93EyMwYrYd+7llB2PXu+BDjAIcjEo8vBwbCuKEWBPLiitzDzFKcDArifAuLsyP
        E+JNSaysSi3Kjy8qzUktPsRoCvTERGYp0eR8YDTnlcQbmhqaW1gamhubG5tZKInzdggcjBES
        SE8sSc1OTS1ILYLpY+LglGpgbJB/09YvM2Xt4nO+89r938c0/b0y/dSPqiNrXNh+R2vz60pm
        z366QPZ9wFkuh6Q9FVX7BO7vza6/Ffi5y9nN5EmXvk7ajvJbbP0zuk+Uv/u6UjHI4PzB8DUR
        C535uPU2hbbde6kntnVaw64PKzUZxd58uMvUveDU/EWWp861FPVML9jp2OvzRImlOCPRUIu5
        qDgRAJZHNXCuAgAA
X-CMS-MailID: 20200317144349eucas1p1921dee3dcd097f695ba708c54325f226
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144349eucas1p1921dee3dcd097f695ba708c54325f226
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144349eucas1p1921dee3dcd097f695ba708c54325f226
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144349eucas1p1921dee3dcd097f695ba708c54325f226@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Start separating SATA specific code from libata-core.c:

* move following functions to libata-sata.c:
  - ata_tf_to_fis()
  - ata_tf_from_fis()
  - sata_link_scr_lpm()
  - ata_slave_link_init()
  - sata_lpm_ignore_phy_events()

* group above functions together in <linux/libata.h>

* include libata-sata.c in the build when CONFIG_SATA_HOST=y

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  37582     572      40   38194    9532 drivers/ata/libata-core.o
after:
  36762     572      40   37374    91fe drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Makefile      |   1 +
 drivers/ata/libata-core.c | 245 ------------------------------------
 drivers/ata/libata-sata.c | 258 ++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  16 ++-
 4 files changed, 269 insertions(+), 251 deletions(-)
 create mode 100644 drivers/ata/libata-sata.c

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index cdaf965fed25..b8aebfb14e82 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
 
 libata-y	:= libata-core.o libata-scsi.o libata-eh.o \
 	libata-transport.o libata-trace.o
+libata-$(CONFIG_SATA_HOST)	+= libata-sata.o
 libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
 libata-$(CONFIG_SATA_PMP)	+= libata-pmp.o
 libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fa1fd0735321..270fe10468c1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -531,81 +531,6 @@ int atapi_cmd_type(u8 opcode)
 }
 EXPORT_SYMBOL_GPL(atapi_cmd_type);
 
-/**
- *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
- *	@tf: Taskfile to convert
- *	@pmp: Port multiplier port
- *	@is_cmd: This FIS is for command
- *	@fis: Buffer into which data will output
- *
- *	Converts a standard ATA taskfile to a Serial ATA
- *	FIS structure (Register - Host to Device).
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
-{
-	fis[0] = 0x27;			/* Register - Host to Device FIS */
-	fis[1] = pmp & 0xf;		/* Port multiplier number*/
-	if (is_cmd)
-		fis[1] |= (1 << 7);	/* bit 7 indicates Command FIS */
-
-	fis[2] = tf->command;
-	fis[3] = tf->feature;
-
-	fis[4] = tf->lbal;
-	fis[5] = tf->lbam;
-	fis[6] = tf->lbah;
-	fis[7] = tf->device;
-
-	fis[8] = tf->hob_lbal;
-	fis[9] = tf->hob_lbam;
-	fis[10] = tf->hob_lbah;
-	fis[11] = tf->hob_feature;
-
-	fis[12] = tf->nsect;
-	fis[13] = tf->hob_nsect;
-	fis[14] = 0;
-	fis[15] = tf->ctl;
-
-	fis[16] = tf->auxiliary & 0xff;
-	fis[17] = (tf->auxiliary >> 8) & 0xff;
-	fis[18] = (tf->auxiliary >> 16) & 0xff;
-	fis[19] = (tf->auxiliary >> 24) & 0xff;
-}
-EXPORT_SYMBOL_GPL(ata_tf_to_fis);
-
-/**
- *	ata_tf_from_fis - Convert SATA FIS to ATA taskfile
- *	@fis: Buffer from which data will be input
- *	@tf: Taskfile to output
- *
- *	Converts a serial ATA FIS structure to a standard ATA taskfile.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf)
-{
-	tf->command	= fis[2];	/* status */
-	tf->feature	= fis[3];	/* error */
-
-	tf->lbal	= fis[4];
-	tf->lbam	= fis[5];
-	tf->lbah	= fis[6];
-	tf->device	= fis[7];
-
-	tf->hob_lbal	= fis[8];
-	tf->hob_lbam	= fis[9];
-	tf->hob_lbah	= fis[10];
-
-	tf->nsect	= fis[12];
-	tf->hob_nsect	= fis[13];
-}
-EXPORT_SYMBOL_GPL(ata_tf_from_fis);
-
 static const u8 ata_rw_cmds[] = {
 	/* pio multi */
 	ATA_CMD_READ_MULTI,
@@ -3791,81 +3716,6 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 }
 EXPORT_SYMBOL_GPL(sata_link_resume);
 
-/**
- *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
- *	@link: ATA link to manipulate SControl for
- *	@policy: LPM policy to configure
- *	@spm_wakeup: initiate LPM transition to active state
- *
- *	Manipulate the IPM field of the SControl register of @link
- *	according to @policy.  If @policy is ATA_LPM_MAX_POWER and
- *	@spm_wakeup is %true, the SPM field is manipulated to wake up
- *	the link.  This function also clears PHYRDY_CHG before
- *	returning.
- *
- *	LOCKING:
- *	EH context.
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
-		      bool spm_wakeup)
-{
-	struct ata_eh_context *ehc = &link->eh_context;
-	bool woken_up = false;
-	u32 scontrol;
-	int rc;
-
-	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
-	if (rc)
-		return rc;
-
-	switch (policy) {
-	case ATA_LPM_MAX_POWER:
-		/* disable all LPM transitions */
-		scontrol |= (0x7 << 8);
-		/* initiate transition to active state */
-		if (spm_wakeup) {
-			scontrol |= (0x4 << 12);
-			woken_up = true;
-		}
-		break;
-	case ATA_LPM_MED_POWER:
-		/* allow LPM to PARTIAL */
-		scontrol &= ~(0x1 << 8);
-		scontrol |= (0x6 << 8);
-		break;
-	case ATA_LPM_MED_POWER_WITH_DIPM:
-	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
-	case ATA_LPM_MIN_POWER:
-		if (ata_link_nr_enabled(link) > 0)
-			/* no restrictions on LPM transitions */
-			scontrol &= ~(0x7 << 8);
-		else {
-			/* empty port, power off */
-			scontrol &= ~0xf;
-			scontrol |= (0x1 << 2);
-		}
-		break;
-	default:
-		WARN_ON(1);
-	}
-
-	rc = sata_scr_write(link, SCR_CONTROL, scontrol);
-	if (rc)
-		return rc;
-
-	/* give the link time to transit out of LPM state */
-	if (woken_up)
-		msleep(10);
-
-	/* clear PHYRDY_CHG from SError */
-	ehc->i.serror &= ~SERR_PHYRDY_CHG;
-	return sata_scr_write(link, SCR_ERROR, SERR_PHYRDY_CHG);
-}
-EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
-
 /**
  *	ata_std_prereset - prepare for reset
  *	@link: ATA link to be reset
@@ -6117,69 +5967,6 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
 
-/**
- *	ata_slave_link_init - initialize slave link
- *	@ap: port to initialize slave link for
- *
- *	Create and initialize slave link for @ap.  This enables slave
- *	link handling on the port.
- *
- *	In libata, a port contains links and a link contains devices.
- *	There is single host link but if a PMP is attached to it,
- *	there can be multiple fan-out links.  On SATA, there's usually
- *	a single device connected to a link but PATA and SATA
- *	controllers emulating TF based interface can have two - master
- *	and slave.
- *
- *	However, there are a few controllers which don't fit into this
- *	abstraction too well - SATA controllers which emulate TF
- *	interface with both master and slave devices but also have
- *	separate SCR register sets for each device.  These controllers
- *	need separate links for physical link handling
- *	(e.g. onlineness, link speed) but should be treated like a
- *	traditional M/S controller for everything else (e.g. command
- *	issue, softreset).
- *
- *	slave_link is libata's way of handling this class of
- *	controllers without impacting core layer too much.  For
- *	anything other than physical link handling, the default host
- *	link is used for both master and slave.  For physical link
- *	handling, separate @ap->slave_link is used.  All dirty details
- *	are implemented inside libata core layer.  From LLD's POV, the
- *	only difference is that prereset, hardreset and postreset are
- *	called once more for the slave link, so the reset sequence
- *	looks like the following.
- *
- *	prereset(M) -> prereset(S) -> hardreset(M) -> hardreset(S) ->
- *	softreset(M) -> postreset(M) -> postreset(S)
- *
- *	Note that softreset is called only for the master.  Softreset
- *	resets both M/S by definition, so SRST on master should handle
- *	both (the standard method will work just fine).
- *
- *	LOCKING:
- *	Should be called before host is registered.
- *
- *	RETURNS:
- *	0 on success, -errno on failure.
- */
-int ata_slave_link_init(struct ata_port *ap)
-{
-	struct ata_link *link;
-
-	WARN_ON(ap->slave_link);
-	WARN_ON(ap->flags & ATA_FLAG_PMP);
-
-	link = kzalloc(sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
-	ata_link_init(ap, link, 1);
-	ap->slave_link = link;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ata_slave_link_init);
-
 static void ata_host_stop(struct device *gendev, void *res)
 {
 	struct ata_host *host = dev_get_drvdata(gendev);
@@ -7103,38 +6890,6 @@ u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask, u32 val,
 }
 EXPORT_SYMBOL_GPL(ata_wait_register);
 
-/**
- *	sata_lpm_ignore_phy_events - test if PHY event should be ignored
- *	@link: Link receiving the event
- *
- *	Test whether the received PHY event has to be ignored or not.
- *
- *	LOCKING:
- *	None:
- *
- *	RETURNS:
- *	True if the event has to be ignored.
- */
-bool sata_lpm_ignore_phy_events(struct ata_link *link)
-{
-	unsigned long lpm_timeout = link->last_lpm_change +
-				    msecs_to_jiffies(ATA_TMOUT_SPURIOUS_PHY);
-
-	/* if LPM is enabled, PHYRDY doesn't mean anything */
-	if (link->lpm_policy > ATA_LPM_MAX_POWER)
-		return true;
-
-	/* ignore the first PHY event after the LPM policy changed
-	 * as it is might be spurious
-	 */
-	if ((link->flags & ATA_LFLAG_CHANGED) &&
-	    time_before(jiffies, lpm_timeout))
-		return true;
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(sata_lpm_ignore_phy_events);
-
 /*
  * Dummy port_ops
  */
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
new file mode 100644
index 000000000000..04f1ecaf414c
--- /dev/null
+++ b/drivers/ata/libata-sata.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  SATA specific part of ATA helper library
+ *
+ *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2003-2004 Jeff Garzik
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/libata.h>
+
+#include "libata.h"
+
+/**
+ *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
+ *	@tf: Taskfile to convert
+ *	@pmp: Port multiplier port
+ *	@is_cmd: This FIS is for command
+ *	@fis: Buffer into which data will output
+ *
+ *	Converts a standard ATA taskfile to a Serial ATA
+ *	FIS structure (Register - Host to Device).
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
+{
+	fis[0] = 0x27;			/* Register - Host to Device FIS */
+	fis[1] = pmp & 0xf;		/* Port multiplier number*/
+	if (is_cmd)
+		fis[1] |= (1 << 7);	/* bit 7 indicates Command FIS */
+
+	fis[2] = tf->command;
+	fis[3] = tf->feature;
+
+	fis[4] = tf->lbal;
+	fis[5] = tf->lbam;
+	fis[6] = tf->lbah;
+	fis[7] = tf->device;
+
+	fis[8] = tf->hob_lbal;
+	fis[9] = tf->hob_lbam;
+	fis[10] = tf->hob_lbah;
+	fis[11] = tf->hob_feature;
+
+	fis[12] = tf->nsect;
+	fis[13] = tf->hob_nsect;
+	fis[14] = 0;
+	fis[15] = tf->ctl;
+
+	fis[16] = tf->auxiliary & 0xff;
+	fis[17] = (tf->auxiliary >> 8) & 0xff;
+	fis[18] = (tf->auxiliary >> 16) & 0xff;
+	fis[19] = (tf->auxiliary >> 24) & 0xff;
+}
+EXPORT_SYMBOL_GPL(ata_tf_to_fis);
+
+/**
+ *	ata_tf_from_fis - Convert SATA FIS to ATA taskfile
+ *	@fis: Buffer from which data will be input
+ *	@tf: Taskfile to output
+ *
+ *	Converts a serial ATA FIS structure to a standard ATA taskfile.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
+void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf)
+{
+	tf->command	= fis[2];	/* status */
+	tf->feature	= fis[3];	/* error */
+
+	tf->lbal	= fis[4];
+	tf->lbam	= fis[5];
+	tf->lbah	= fis[6];
+	tf->device	= fis[7];
+
+	tf->hob_lbal	= fis[8];
+	tf->hob_lbam	= fis[9];
+	tf->hob_lbah	= fis[10];
+
+	tf->nsect	= fis[12];
+	tf->hob_nsect	= fis[13];
+}
+EXPORT_SYMBOL_GPL(ata_tf_from_fis);
+
+/**
+ *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
+ *	@link: ATA link to manipulate SControl for
+ *	@policy: LPM policy to configure
+ *	@spm_wakeup: initiate LPM transition to active state
+ *
+ *	Manipulate the IPM field of the SControl register of @link
+ *	according to @policy.  If @policy is ATA_LPM_MAX_POWER and
+ *	@spm_wakeup is %true, the SPM field is manipulated to wake up
+ *	the link.  This function also clears PHYRDY_CHG before
+ *	returning.
+ *
+ *	LOCKING:
+ *	EH context.
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+		      bool spm_wakeup)
+{
+	struct ata_eh_context *ehc = &link->eh_context;
+	bool woken_up = false;
+	u32 scontrol;
+	int rc;
+
+	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
+	if (rc)
+		return rc;
+
+	switch (policy) {
+	case ATA_LPM_MAX_POWER:
+		/* disable all LPM transitions */
+		scontrol |= (0x7 << 8);
+		/* initiate transition to active state */
+		if (spm_wakeup) {
+			scontrol |= (0x4 << 12);
+			woken_up = true;
+		}
+		break;
+	case ATA_LPM_MED_POWER:
+		/* allow LPM to PARTIAL */
+		scontrol &= ~(0x1 << 8);
+		scontrol |= (0x6 << 8);
+		break;
+	case ATA_LPM_MED_POWER_WITH_DIPM:
+	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
+	case ATA_LPM_MIN_POWER:
+		if (ata_link_nr_enabled(link) > 0)
+			/* no restrictions on LPM transitions */
+			scontrol &= ~(0x7 << 8);
+		else {
+			/* empty port, power off */
+			scontrol &= ~0xf;
+			scontrol |= (0x1 << 2);
+		}
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	rc = sata_scr_write(link, SCR_CONTROL, scontrol);
+	if (rc)
+		return rc;
+
+	/* give the link time to transit out of LPM state */
+	if (woken_up)
+		msleep(10);
+
+	/* clear PHYRDY_CHG from SError */
+	ehc->i.serror &= ~SERR_PHYRDY_CHG;
+	return sata_scr_write(link, SCR_ERROR, SERR_PHYRDY_CHG);
+}
+EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
+
+/**
+ *	ata_slave_link_init - initialize slave link
+ *	@ap: port to initialize slave link for
+ *
+ *	Create and initialize slave link for @ap.  This enables slave
+ *	link handling on the port.
+ *
+ *	In libata, a port contains links and a link contains devices.
+ *	There is single host link but if a PMP is attached to it,
+ *	there can be multiple fan-out links.  On SATA, there's usually
+ *	a single device connected to a link but PATA and SATA
+ *	controllers emulating TF based interface can have two - master
+ *	and slave.
+ *
+ *	However, there are a few controllers which don't fit into this
+ *	abstraction too well - SATA controllers which emulate TF
+ *	interface with both master and slave devices but also have
+ *	separate SCR register sets for each device.  These controllers
+ *	need separate links for physical link handling
+ *	(e.g. onlineness, link speed) but should be treated like a
+ *	traditional M/S controller for everything else (e.g. command
+ *	issue, softreset).
+ *
+ *	slave_link is libata's way of handling this class of
+ *	controllers without impacting core layer too much.  For
+ *	anything other than physical link handling, the default host
+ *	link is used for both master and slave.  For physical link
+ *	handling, separate @ap->slave_link is used.  All dirty details
+ *	are implemented inside libata core layer.  From LLD's POV, the
+ *	only difference is that prereset, hardreset and postreset are
+ *	called once more for the slave link, so the reset sequence
+ *	looks like the following.
+ *
+ *	prereset(M) -> prereset(S) -> hardreset(M) -> hardreset(S) ->
+ *	softreset(M) -> postreset(M) -> postreset(S)
+ *
+ *	Note that softreset is called only for the master.  Softreset
+ *	resets both M/S by definition, so SRST on master should handle
+ *	both (the standard method will work just fine).
+ *
+ *	LOCKING:
+ *	Should be called before host is registered.
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int ata_slave_link_init(struct ata_port *ap)
+{
+	struct ata_link *link;
+
+	WARN_ON(ap->slave_link);
+	WARN_ON(ap->flags & ATA_FLAG_PMP);
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	ata_link_init(ap, link, 1);
+	ap->slave_link = link;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_slave_link_init);
+
+/**
+ *	sata_lpm_ignore_phy_events - test if PHY event should be ignored
+ *	@link: Link receiving the event
+ *
+ *	Test whether the received PHY event has to be ignored or not.
+ *
+ *	LOCKING:
+ *	None:
+ *
+ *	RETURNS:
+ *	True if the event has to be ignored.
+ */
+bool sata_lpm_ignore_phy_events(struct ata_link *link)
+{
+	unsigned long lpm_timeout = link->last_lpm_change +
+				    msecs_to_jiffies(ATA_TMOUT_SPURIOUS_PHY);
+
+	/* if LPM is enabled, PHYRDY doesn't mean anything */
+	if (link->lpm_policy > ATA_LPM_MAX_POWER)
+		return true;
+
+	/* ignore the first PHY event after the LPM policy changed
+	 * as it is might be spurious
+	 */
+	if ((link->flags & ATA_LFLAG_CHANGED) &&
+	    time_before(jiffies, lpm_timeout))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(sata_lpm_ignore_phy_events);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b1b3e5e0a301..f38faa80b2ba 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1074,8 +1074,6 @@ extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
-extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
-			     bool spm_wakeup);
 extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *));
@@ -1086,7 +1084,6 @@ extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
 extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 			const struct ata_port_info * const * ppi, int n_ports);
-extern int ata_slave_link_init(struct ata_port *ap);
 extern void ata_host_get(struct ata_host *host);
 extern void ata_host_put(struct ata_host *host);
 extern int ata_host_start(struct ata_host *host);
@@ -1146,9 +1143,6 @@ extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
 extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
 			u32 val, unsigned long interval, unsigned long timeout);
 extern int atapi_cmd_type(u8 opcode);
-extern void ata_tf_to_fis(const struct ata_taskfile *tf,
-			  u8 pmp, int is_cmd, u8 *fis);
-extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern unsigned long ata_pack_xfermask(unsigned long pio_mask,
 			unsigned long mwdma_mask, unsigned long udma_mask);
 extern void ata_unpack_xfermask(unsigned long xfer_mask,
@@ -1197,6 +1191,16 @@ extern void ata_scsi_port_error_handler(struct Scsi_Host *host,
 extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host,
 				       struct ata_port *ap,
 				       struct list_head *eh_q);
+
+/*
+ * SATA specific code - drivers/ata/libata-sata.c
+ */
+extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+                            bool spm_wakeup);
+extern int ata_slave_link_init(struct ata_port *ap);
+extern void ata_tf_to_fis(const struct ata_taskfile *tf,
+                         u8 pmp, int is_cmd, u8 *fis);
+extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 
 extern int ata_cable_40wire(struct ata_port *ap);
-- 
2.24.1

