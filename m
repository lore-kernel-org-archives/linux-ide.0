Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E02C2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C456B22522
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h3nPfmnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA1NfW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:35:22 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58898 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgA1NeR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133415euoutp010f8dabb9809a2106db752384fd277a72~uEFAYxAkd0286702867euoutp01W
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133415euoutp010f8dabb9809a2106db752384fd277a72~uEFAYxAkd0286702867euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218455;
        bh=3uYMSAA1WyojWrdPwQGuRlb/VV0u+NCe8ys3XAQpI7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3nPfmnZove6ymJ0F2+Ti/vVXUMcp+yEPG9lwLrXWDKEs4ympICj4XuxmbfSpgrNg
         tGn/A2YTjrdITaMx8kWCuyChrsPj8oNpbKEsMoN75gInt2ofT/g+Gpm3OFE/TmBxhx
         OZkmAGmCQCdbcGSicgkg0EaMKZ471DWjDpzZB4yA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133415eucas1p13a1220ac6eb18b14ef4d123862821eec~uEFAJfkqK1372113721eucas1p1D;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3E.CA.61286.758303E5; Tue, 28
        Jan 2020 13:34:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133414eucas1p2baefeb1a492375b18bdf6cdfbd0db796~uEE-wxc433228632286eucas1p2l;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133414eusmtrp2d069b470b42661cdc5dd67ff1b4e3ddd~uEE-wOcls0330103301eusmtrp2w;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-7e-5e30385729dc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F2.92.08375.658303E5; Tue, 28
        Jan 2020 13:34:14 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133414eusmtip21b39c6c1bb4b68cbd13b411ebb4e7ec5~uEE-Xb22a0657406574eusmtip2e;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 12/28] ata: start separating SATA specific code from
 libata-core.c
Date:   Tue, 28 Jan 2020 14:33:27 +0100
Message-Id: <20200128133343.29905-13-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87rhFgZxBq8msFusvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK+P7+ttsBdfmMlZs/LuEvYHxZ20XIyeHhICJxLnjh9m6GLk4hARWMEr0fu5m
        BUkICXxhlFjc7QuR+Mwo8ff9VDaYjolvvrJCJJYzStz928oE4QB1/O/awQ5SxSZgJTGxfRUj
        iC0ioCDR83sl2A5mgTWMEqsON4ElhAVCJJ7OPgrWwCKgKnH4wi8wm1fATmL1vdtQ6+Qltn77
        BLSOg4MTKN6z1xyiRFDi5MwnLCA2M1BJ89bZzCDzJQTa2SU+zvzLDtHrIrHr6m0mCFtY4tXx
        LVBxGYn/O+czQTSsA/qt4wVU93ZGieWT/0Fttpa4c+4XG8hmZgFNifW79CHCjhLv+1sZQcIS
        AnwSN94KQhzBJzFp23RmiDCvREebEES1msSGZRvYYNZ27VzJDGF7SJxcfZRlAqPiLCTvzELy
        ziyEvQsYmVcxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEppjT/45/2sH49VLSIUYBDkYl
        Ht4ZKgZxQqyJZcWVuYcYJTiYlUR4O5mAQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJI
        TyxJzU5NLUgtgskycXBKNTDmxDKv+3PuXIDOw/rUS6cZVhyRctu1z2VjRlOuBfuGHUeUlr0O
        3vMypFUoyMVEIvbnpPQflmwWuYetXATnSR1SP/A44XnrTZPfR6v9047GzDXPvL7z2rJvz+Yd
        NTZ1m30/IWbKnP8py+6u/Wc7TeWWdFKbwm8vxhtvGtbP27bK/GeV7nXxop4yJZbijERDLeai
        4kQA8IWspS0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd0wC4M4g8M/NCxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/F9/W22gmtz
        GSs2/l3C3sD4s7aLkZNDQsBEYuKbr6xdjFwcQgJLGSVe7pwN5HAAJWQkjq8vg6gRlvhzrYsN
        ouYTUM30m2wgCTYBK4mJ7asYQWwRAQWJnt8rwYqYBTYwSry6+YUFZJCwQJDErm1gg1gEVCUO
        X/jFDmLzCthJrL53mw1igbzE1m+fwPZyAsV79pqDhIUEbCXWn3nKClEuKHFy5hMWEJsZqLx5
        62zmCYwCs5CkZiFJLWBkWsUoklpanJueW2yoV5yYW1yal66XnJ+7iREYB9uO/dy8g/HSxuBD
        jAIcjEo8vDNUDOKEWBPLiitzDzFKcDArifB2MgGFeFMSK6tSi/Lji0pzUosPMZoC/TCRWUo0
        OR8Yo3kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhi7ZLLNLEU9
        A0W3S7FPtEs6UPzhguwqzsLOJwJzFudK72GWZjdv2B/Ju8WffVPu38ld+vXq09dM79APtlr5
        LOL0CbsGTevrrRuldhxYpLyhx+yq6m3THUuNruqxBYa9mSHKEfAg1jFw6rZb21duKVdwaZA4
        kCn2fe0yl86vH4QUbnvV+R7gn6HEUpyRaKjFXFScCABAP4v2mQIAAA==
X-CMS-MailID: 20200128133414eucas1p2baefeb1a492375b18bdf6cdfbd0db796
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133414eucas1p2baefeb1a492375b18bdf6cdfbd0db796
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133414eucas1p2baefeb1a492375b18bdf6cdfbd0db796
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133414eucas1p2baefeb1a492375b18bdf6cdfbd0db796@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Start separating SATA specific code from libata-core.c:

* move following functions to libata-core-sata.c:
  - ata_tf_to_fis()
  - ata_tf_from_fis()
  - sata_link_scr_lpm()
  - ata_slave_link_init()
  - sata_lpm_ignore_phy_events()

* group above functions together in <linux/libata.h> and cover
  them with CONFIG_SATA_HOST ifdef

* include libata-core-sata.c in the build when CONFIG_SATA_HOST=y

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  37582     572      40   38194    9532 drivers/ata/libata-core.o
after:
  36762     572      40   37374    91fe drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Makefile           |   1 +
 drivers/ata/libata-core-sata.c | 258 +++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c      | 245 -------------------------------
 include/linux/libata.h         |  18 ++-
 4 files changed, 271 insertions(+), 251 deletions(-)
 create mode 100644 drivers/ata/libata-core-sata.c

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index cdaf965fed25..b06b9a211691 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
 
 libata-y	:= libata-core.o libata-scsi.o libata-eh.o \
 	libata-transport.o libata-trace.o
+libata-$(CONFIG_SATA_HOST)	+= libata-core-sata.o
 libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
 libata-$(CONFIG_SATA_PMP)	+= libata-pmp.o
 libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
new file mode 100644
index 000000000000..8b939d2db0a6
--- /dev/null
+++ b/drivers/ata/libata-core-sata.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  libata-core-sata.c - SATA specific part of ATA helper library
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
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 408dee580f24..24b8ee668e6f 100644
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
@@ -3777,81 +3702,6 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
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
@@ -6116,69 +5966,6 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
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
@@ -7083,38 +6870,6 @@ u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask, u32 val,
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5b7bed18f56e..6bb0bd644f17 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1084,8 +1084,6 @@ extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
-extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
-			     bool spm_wakeup);
 extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *));
@@ -1096,7 +1094,6 @@ extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
 extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 			const struct ata_port_info * const * ppi, int n_ports);
-extern int ata_slave_link_init(struct ata_port *ap);
 extern void ata_host_get(struct ata_host *host);
 extern void ata_host_put(struct ata_host *host);
 extern int ata_host_start(struct ata_host *host);
@@ -1154,9 +1151,6 @@ extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
 extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
 			u32 val, unsigned long interval, unsigned long timeout);
 extern int atapi_cmd_type(u8 opcode);
-extern void ata_tf_to_fis(const struct ata_taskfile *tf,
-			  u8 pmp, int is_cmd, u8 *fis);
-extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern unsigned long ata_pack_xfermask(unsigned long pio_mask,
 			unsigned long mwdma_mask, unsigned long udma_mask);
 extern void ata_unpack_xfermask(unsigned long xfer_mask,
@@ -1197,7 +1191,19 @@ extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
 extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap, struct list_head *eh_q);
+
+/*
+ * Core layer (SATA specific part) - drivers/ata/libata-core-sata.c
+ */
+#ifdef CONFIG_SATA_HOST
+extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+			     bool spm_wakeup);
+extern int ata_slave_link_init(struct ata_port *ap);
+extern void ata_tf_to_fis(const struct ata_taskfile *tf,
+			  u8 pmp, int is_cmd, u8 *fis);
+extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
+#endif
 
 extern int ata_cable_40wire(struct ata_port *ap);
 extern int ata_cable_80wire(struct ata_port *ap);
-- 
2.24.1

