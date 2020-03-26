Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D5BC2D0EE
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D721620857
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kAAnfVZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgCZP7p (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52639 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgCZP6r (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155845euoutp02c04a51490d63bba0f0c81fcb389a1343~-5dvG7hl_0032300323euoutp02t
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155845euoutp02c04a51490d63bba0f0c81fcb389a1343~-5dvG7hl_0032300323euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238325;
        bh=n+PntP1aojJXxxPbcP0a/7RmXlLZAeGzggIkVC+k30o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAAnfVZ+Mjn9cofAZbbW7Kclm6QFwdzm+cwRozU+izBNwRbeTv5frWlxiEpszAHWg
         N7azwUBcI3Lo74fWd8InaB3xqfgQC4kch2BudqON+eX3J/BppvfR/EoBG6u9XkdIwP
         OwKreo2AnHQGHEzGcSMHDhZaeiVDXmLedwkPD1vg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155845eucas1p1d5d638a100e8915a15b01df4cda50dce~-5du2gjb72821828218eucas1p1w;
        Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A4.F7.60698.531DC7E5; Thu, 26
        Mar 2020 15:58:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155845eucas1p29de94fa9d541972b78334ebfd0055320~-5duO1iK03015130151eucas1p21;
        Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155845eusmtrp123e15e70a51f6b22c9257dffeb74f0f4~-5duOQras2091520915eusmtrp1P;
        Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-99-5e7cd135c45a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.CA.07950.431DC7E5; Thu, 26
        Mar 2020 15:58:44 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155844eusmtip1d77126933676097e062b0d28a93f57f1~-5dtzxPwK1572015720eusmtip1Y;
        Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 16/27] ata: start separating SATA specific code from
 libata-core.c
Date:   Thu, 26 Mar 2020 16:58:11 +0100
Message-Id: <20200326155822.19400-17-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7qmF2viDJa8ULdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnLXs1mLdg6h7Fiyr797A2Mv2q6GDk5
        JARMJLbNPcvUxcjFISSwglFiysvfjBDOF0aJDSvvs0A4nxkl1i9fxwjTsmXJSTaIxHJGiaVb
        XyC0nDzazQpSxSZgJTGxfRVYh4iAgkTP75VgHcwC7xklVkzaywKSEBYIl/hwph+sgUVAVWLT
        7slgDbwCdhJzJ/xhglgnL7H12yewGk6g+PJ185khagQlTs58AjaHGaimeetsZpAFEgLL2CUO
        3ZsNdauLxLdds1khbGGJV8e3sEPYMhKnJ/ewQDSsY5T42/ECqns7o8Tyyf/YIKqsJe6c+wVk
        cwCt0JRYv0sfIuwo8fxsHxNIWEKAT+LGW0GII/gkJm2bzgwR5pXoaBOCqFaT2LBsAxvM2q6d
        K5khbA+JmzuOM05gVJyF5J1ZSN6ZhbB3ASPzKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxN
        jMB0dPrf8a87GPf9STrEKMDBqMTD29BWEyfEmlhWXJl7iFGCg1lJhPdpJFCINyWxsiq1KD++
        qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkGRvPZ7WlBLgmn+swP7v0kKBfC
        rLHoiXCTmdfP5c4nBR8nTDq8YLP7L83U2YHKEiEeeUrOL/m5djQEL1P0lZzotIkrylDi0Y5A
        ldus68QZVvwIK/+WnP85/q+Fb9PLGyHM7JdOHpphaTJhdn1GJuvkaZv3rLzTuj8lTXm15gQG
        pfAC0Zj7krOuKrEUZyQaajEXFScCAMIzzm1DAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7omF2viDBa0WlqsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYxlr2azFmydw1gxZd9+9gbGXzVdjJwcEgImEluWnGTrYuTiEBJYyiix
        uqOZqYuRAyghI3F8fRlEjbDEn2tdUDWfGCUOnVvHBJJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndzCCDhAVCJTpX8oLUsAioSmzaPRmsnlfATmLuhD9MEAvkJbZ++8QKYnMCxZevm88M
        YgsJ2Eos/vKBCaJeUOLkzCcsIDYzUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgx
        t7g0L10vOT93EyMwYrYd+7llB2PXu+BDjAIcjEo8vBotNXFCrIllxZW5hxglOJiVRHifRgKF
        eFMSK6tSi/Lji0pzUosPMZoCPTGRWUo0OR8YzXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATS
        E0tSs1NTC1KLYPqYODilGhgrdi5ax/vnZG2DiWPAWluR5LQ0s+7/XC0eUexlsRs5bj1r6K6M
        m8S2IGDGluPHkjq/a69x35tvV6f2+soEAY/9ZkkqkdYsU+7eX/20ya3WiHO7V6NAeHyMd95l
        9TKFyKOneQ93PF4VJ6Psu8fwufdW6+L3V7LDKozqvukEH0tfpGdtnNRkoMRSnJFoqMVcVJwI
        AGctHN+uAgAA
X-CMS-MailID: 20200326155845eucas1p29de94fa9d541972b78334ebfd0055320
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155845eucas1p29de94fa9d541972b78334ebfd0055320
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155845eucas1p29de94fa9d541972b78334ebfd0055320
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155845eucas1p29de94fa9d541972b78334ebfd0055320@eucas1p2.samsung.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index dcdb7fb46dbd..b4a952dce7ab 100644
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
@@ -3779,81 +3704,6 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
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
@@ -6118,69 +5968,6 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
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
@@ -7106,38 +6893,6 @@ u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask, u32 val,
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
index 661d76038684..b419d7412f71 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1082,8 +1082,6 @@ extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
-extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
-			     bool spm_wakeup);
 extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *));
@@ -1094,7 +1092,6 @@ extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
 extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 			const struct ata_port_info * const * ppi, int n_ports);
-extern int ata_slave_link_init(struct ata_port *ap);
 extern void ata_host_get(struct ata_host *host);
 extern void ata_host_put(struct ata_host *host);
 extern int ata_host_start(struct ata_host *host);
@@ -1152,9 +1149,6 @@ extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
 extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
 			u32 val, unsigned long interval, unsigned long timeout);
 extern int atapi_cmd_type(u8 opcode);
-extern void ata_tf_to_fis(const struct ata_taskfile *tf,
-			  u8 pmp, int is_cmd, u8 *fis);
-extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern unsigned long ata_pack_xfermask(unsigned long pio_mask,
 			unsigned long mwdma_mask, unsigned long udma_mask);
 extern void ata_unpack_xfermask(unsigned long xfer_mask,
@@ -1195,6 +1189,16 @@ extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
 extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap, struct list_head *eh_q);
+
+/*
+ * SATA specific code - drivers/ata/libata-sata.c
+ */
+extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+			     bool spm_wakeup);
+extern int ata_slave_link_init(struct ata_port *ap);
+extern void ata_tf_to_fis(const struct ata_taskfile *tf,
+			  u8 pmp, int is_cmd, u8 *fis);
+extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 
 extern int ata_cable_40wire(struct ata_port *ap);
-- 
2.24.1

