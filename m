Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CBDC35246
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E446C24686
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GD//P2aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgA1NeY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59031 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgA1NeX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:23 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133421euoutp013d968f1ef663b3f928e32dbd51ab233d~uEFFz1Tpg0328903289euoutp01N
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133421euoutp013d968f1ef663b3f928e32dbd51ab233d~uEFFz1Tpg0328903289euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218461;
        bh=f4pGIZF5n68twmRaSlTYAptwbRCwIxi64/HHyKcDMRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GD//P2aasZ8cxk7SJt0DxoYzk+vWarE2gBBggI9hkUyBQt4+IhOQQzpf1a8PGrTKW
         mIKV/Y+HhmeMRI1bdx/NJImRN7IGfqfrrpDFOK2PgeSKx5L2S4AM7J5CBAiiR3VseN
         +31+JYqV8wrlsftJt6OoTs2WtoYxEm+T8fX6alZs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133421eucas1p20f62ac9c228146101fd2558b27b6e450~uEFFk5LEM1871818718eucas1p2S;
        Tue, 28 Jan 2020 13:34:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.5A.60679.C58303E5; Tue, 28
        Jan 2020 13:34:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133420eucas1p23e99a72e7735412f93dc015b8cb25d4b~uEFFKrQ9Q0683706837eucas1p2R;
        Tue, 28 Jan 2020 13:34:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133420eusmtrp25db619364d396acfb9065a41acc5c03c~uEFFKGqXl0330003300eusmtrp2D;
        Tue, 28 Jan 2020 13:34:20 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-65-5e30385c2808
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E7.92.08375.C58303E5; Tue, 28
        Jan 2020 13:34:20 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133420eusmtip2ecd0ea1077e217ad84af2e9868b97c29~uEFExJU-80724907249eusmtip2D;
        Tue, 28 Jan 2020 13:34:20 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 28/28] ata: move ata_eh_set_lpm() to libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:43 +0100
Message-Id: <20200128133343.29905-29-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87qxFgZxBpPsLFbf7Wez2DhjPavF
        s1t7mSyO7XjEZHF51xw2i7mt09kd2Dx2zrrL7nH5bKnHocMdjB59W1YxenzeJBfAGsVlk5Ka
        k1mWWqRvl8CVcfrZCtaC7f4V278mNzDuteti5OCQEDCROHhQoYuRi0NIYAWjRM/FCewQzhdG
        iY+3j7JCOJ8ZJdZe/cLcxcgJ1vHl0jwmEFtIYDmjxIf5KXAd0xsPsoAk2ASsJCa2r2IEsUUE
        FCR6fq9kAyliFljDKLHqcBNYQljAXeLCp/lsIDaLgKrE1cvfwZp5Bewk9lyZxwixTV5i67dP
        rCC3cgLFe/aaQ5QISpyc+QSsnBmopHnrbKjj2tklmk/GQdguEt83fWaDsIUlXh3fwg5hy0j8
        3zmfCeQeCYF1jBJ/O14wQzjbGSWWT/4H1WEtcefcLzaQxcwCmhLrd+lDhB0lHqy5xQYJOz6J
        G28FIW7gk5i0bTozRJhXoqNNCKJaTWLDsg1sMGu7dq6EOtND4uj+N4wTGBVnIflmFpJvZiHs
        XcDIvIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwsZz+d/zLDsZdf5IOMQpwMCrx8M5Q
        MYgTYk0sK67MPcQowcGsJMLbyQQU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6Yklq
        dmpqQWoRTJaJg1OqgTGQR/37FCvhS0xyJ297V+Xx6yvyPmZo82kOitk+1/Z0tqNX1EzV19sN
        nu9knpeh1/BzqcNbtYIDuseF9l3c2n/fWDvxQ2CeTUBjrFqFRUO+nb/sW1tJ9Z/xW373HO3x
        C52i++WV+ZdSxXhfM7czOY92/S6sEryb3u7xW+XRHyPpY0GO3bdMlViKMxINtZiLihMBLTqv
        TigDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Pd0YC4M4gz3HZSxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3H62QrWgu3+
        Fdu/Jjcw7rXrYuTkkBAwkfhyaR5TFyMXh5DAUkaJxuY21i5GDqCEjMTx9WUQNcISf651sUHU
        fGKUOHd8NitIgk3ASmJi+ypGEFtEQEGi5/dKsCJmgQ2MEq9ufmEBSQgLuEtc+DSfDcRmEVCV
        uHr5O1icV8BOYs+VeYwQG+Qltn77BLaYEyjes9ccJCwkYCux/sxTVohyQYmTM5+AtTIDlTdv
        nc08gVFgFpLULCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQKjYNuxn5t3MF7aGHyI
        UYCDUYmHd4aKQZwQa2JZcWXuIUYJDmYlEd5OJqAQb0piZVVqUX58UWlOavEhRlOgHyYyS4km
        5wMjNK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+PckvdT4s+9
        nrv52va9t229v2zv23Tsx6pHfD7bP22etujklhMWgbMqLK7tvPn3xLxvIvN/sNycU1rQNL8n
        3lmw873Nqnitzb3M/g+db99t2F0uVXCjIdVsZdSpRr9j8eK7ZA+KNxbXT2Bd9SG4ye2B8Y6s
        rDuT2rYVXjQ8zP5zz//FUhP0PjP+UWIpzkg01GIuKk4EABKbaveYAgAA
X-CMS-MailID: 20200128133420eucas1p23e99a72e7735412f93dc015b8cb25d4b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133420eucas1p23e99a72e7735412f93dc015b8cb25d4b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133420eucas1p23e99a72e7735412f93dc015b8cb25d4b
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133420eucas1p23e99a72e7735412f93dc015b8cb25d4b@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* un-static ata_eh_set_lpm() and move it to libata-eh-sata.c

* add static inline for ata_eh_set_lpm() for CONFIG_SATA_HOST=n
  case (for PATA hosts "ap && !ap->ops->set_lpm" condition is
  always true so it's sufficient for the function to return zero)

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  16092      18       0   16110    3eee drivers/ata/libata-eh.o
after:
  15346      18       0   15364    3c04 drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh-sata.c | 133 +++++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c      | 133 -----------------------------------
 drivers/ata/libata.h         |   9 +++
 3 files changed, 142 insertions(+), 133 deletions(-)

diff --git a/drivers/ata/libata-eh-sata.c b/drivers/ata/libata-eh-sata.c
index 4b55d89862fb..cd7b1b434d53 100644
--- a/drivers/ata/libata-eh-sata.c
+++ b/drivers/ata/libata-eh-sata.c
@@ -214,3 +214,136 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
 EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
+
+/**
+ *	ata_eh_set_lpm - configure SATA interface power management
+ *	@link: link to configure power management
+ *	@policy: the link power management policy
+ *	@r_failed_dev: out parameter for failed device
+ *
+ *	Enable SATA Interface power management.  This will enable
+ *	Device Interface Power Management (DIPM) for min_power and
+ *	medium_power_with_dipm policies, and then call driver specific
+ *	callbacks for enabling Host Initiated Power management.
+ *
+ *	LOCKING:
+ *	EH context.
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+		   struct ata_device **r_failed_dev)
+{
+	struct ata_port *ap = ata_is_host_link(link) ? link->ap : NULL;
+	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_device *dev, *link_dev = NULL, *lpm_dev = NULL;
+	enum ata_lpm_policy old_policy = link->lpm_policy;
+	bool no_dipm = link->ap->flags & ATA_FLAG_NO_DIPM;
+	unsigned int hints = ATA_LPM_EMPTY | ATA_LPM_HIPM;
+	unsigned int err_mask;
+	int rc;
+
+	/* if the link or host doesn't do LPM, noop */
+	if ((link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
+		return 0;
+
+	/*
+	 * DIPM is enabled only for MIN_POWER as some devices
+	 * misbehave when the host NACKs transition to SLUMBER.  Order
+	 * device and link configurations such that the host always
+	 * allows DIPM requests.
+	 */
+	ata_for_each_dev(dev, link, ENABLED) {
+		bool hipm = ata_id_has_hipm(dev->id);
+		bool dipm = ata_id_has_dipm(dev->id) && !no_dipm;
+
+		/* find the first enabled and LPM enabled devices */
+		if (!link_dev)
+			link_dev = dev;
+
+		if (!lpm_dev && (hipm || dipm))
+			lpm_dev = dev;
+
+		hints &= ~ATA_LPM_EMPTY;
+		if (!hipm)
+			hints &= ~ATA_LPM_HIPM;
+
+		/* disable DIPM before changing link config */
+		if (policy < ATA_LPM_MED_POWER_WITH_DIPM && dipm) {
+			err_mask = ata_dev_set_feature(dev,
+					SETFEATURES_SATA_DISABLE, SATA_DIPM);
+			if (err_mask && err_mask != AC_ERR_DEV) {
+				ata_dev_warn(dev,
+					     "failed to disable DIPM, Emask 0x%x\n",
+					     err_mask);
+				rc = -EIO;
+				goto fail;
+			}
+		}
+	}
+
+	if (ap) {
+		rc = ap->ops->set_lpm(link, policy, hints);
+		if (!rc && ap->slave_link)
+			rc = ap->ops->set_lpm(ap->slave_link, policy, hints);
+	} else
+		rc = sata_pmp_set_lpm(link, policy, hints);
+
+	/*
+	 * Attribute link config failure to the first (LPM) enabled
+	 * device on the link.
+	 */
+	if (rc) {
+		if (rc == -EOPNOTSUPP) {
+			link->flags |= ATA_LFLAG_NO_LPM;
+			return 0;
+		}
+		dev = lpm_dev ? lpm_dev : link_dev;
+		goto fail;
+	}
+
+	/*
+	 * Low level driver acked the transition.  Issue DIPM command
+	 * with the new policy set.
+	 */
+	link->lpm_policy = policy;
+	if (ap && ap->slave_link)
+		ap->slave_link->lpm_policy = policy;
+
+	/* host config updated, enable DIPM if transitioning to MIN_POWER */
+	ata_for_each_dev(dev, link, ENABLED) {
+		if (policy >= ATA_LPM_MED_POWER_WITH_DIPM && !no_dipm &&
+		    ata_id_has_dipm(dev->id)) {
+			err_mask = ata_dev_set_feature(dev,
+					SETFEATURES_SATA_ENABLE, SATA_DIPM);
+			if (err_mask && err_mask != AC_ERR_DEV) {
+				ata_dev_warn(dev,
+					"failed to enable DIPM, Emask 0x%x\n",
+					err_mask);
+				rc = -EIO;
+				goto fail;
+			}
+		}
+	}
+
+	link->last_lpm_change = jiffies;
+	link->flags |= ATA_LFLAG_CHANGED;
+
+	return 0;
+
+fail:
+	/* restore the old policy */
+	link->lpm_policy = old_policy;
+	if (ap && ap->slave_link)
+		ap->slave_link->lpm_policy = old_policy;
+
+	/* if no device or only one more chance is left, disable LPM */
+	if (!dev || ehc->tries[dev->devno] <= 2) {
+		ata_link_warn(link, "disabling LPM on the link\n");
+		link->flags |= ATA_LFLAG_NO_LPM;
+	}
+	if (r_failed_dev)
+		*r_failed_dev = dev;
+	return rc;
+}
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b37e93c5013d..723645cefee9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3208,139 +3208,6 @@ static int ata_eh_maybe_retry_flush(struct ata_device *dev)
 	return rc;
 }
 
-/**
- *	ata_eh_set_lpm - configure SATA interface power management
- *	@link: link to configure power management
- *	@policy: the link power management policy
- *	@r_failed_dev: out parameter for failed device
- *
- *	Enable SATA Interface power management.  This will enable
- *	Device Interface Power Management (DIPM) for min_power and
- *	medium_power_with_dipm policies, and then call driver specific
- *	callbacks for enabling Host Initiated Power management.
- *
- *	LOCKING:
- *	EH context.
- *
- *	RETURNS:
- *	0 on success, -errno on failure.
- */
-static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
-			  struct ata_device **r_failed_dev)
-{
-	struct ata_port *ap = ata_is_host_link(link) ? link->ap : NULL;
-	struct ata_eh_context *ehc = &link->eh_context;
-	struct ata_device *dev, *link_dev = NULL, *lpm_dev = NULL;
-	enum ata_lpm_policy old_policy = link->lpm_policy;
-	bool no_dipm = link->ap->flags & ATA_FLAG_NO_DIPM;
-	unsigned int hints = ATA_LPM_EMPTY | ATA_LPM_HIPM;
-	unsigned int err_mask;
-	int rc;
-
-	/* if the link or host doesn't do LPM, noop */
-	if ((link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
-		return 0;
-
-	/*
-	 * DIPM is enabled only for MIN_POWER as some devices
-	 * misbehave when the host NACKs transition to SLUMBER.  Order
-	 * device and link configurations such that the host always
-	 * allows DIPM requests.
-	 */
-	ata_for_each_dev(dev, link, ENABLED) {
-		bool hipm = ata_id_has_hipm(dev->id);
-		bool dipm = ata_id_has_dipm(dev->id) && !no_dipm;
-
-		/* find the first enabled and LPM enabled devices */
-		if (!link_dev)
-			link_dev = dev;
-
-		if (!lpm_dev && (hipm || dipm))
-			lpm_dev = dev;
-
-		hints &= ~ATA_LPM_EMPTY;
-		if (!hipm)
-			hints &= ~ATA_LPM_HIPM;
-
-		/* disable DIPM before changing link config */
-		if (policy < ATA_LPM_MED_POWER_WITH_DIPM && dipm) {
-			err_mask = ata_dev_set_feature(dev,
-					SETFEATURES_SATA_DISABLE, SATA_DIPM);
-			if (err_mask && err_mask != AC_ERR_DEV) {
-				ata_dev_warn(dev,
-					     "failed to disable DIPM, Emask 0x%x\n",
-					     err_mask);
-				rc = -EIO;
-				goto fail;
-			}
-		}
-	}
-
-	if (ap) {
-		rc = ap->ops->set_lpm(link, policy, hints);
-		if (!rc && ap->slave_link)
-			rc = ap->ops->set_lpm(ap->slave_link, policy, hints);
-	} else
-		rc = sata_pmp_set_lpm(link, policy, hints);
-
-	/*
-	 * Attribute link config failure to the first (LPM) enabled
-	 * device on the link.
-	 */
-	if (rc) {
-		if (rc == -EOPNOTSUPP) {
-			link->flags |= ATA_LFLAG_NO_LPM;
-			return 0;
-		}
-		dev = lpm_dev ? lpm_dev : link_dev;
-		goto fail;
-	}
-
-	/*
-	 * Low level driver acked the transition.  Issue DIPM command
-	 * with the new policy set.
-	 */
-	link->lpm_policy = policy;
-	if (ap && ap->slave_link)
-		ap->slave_link->lpm_policy = policy;
-
-	/* host config updated, enable DIPM if transitioning to MIN_POWER */
-	ata_for_each_dev(dev, link, ENABLED) {
-		if (policy >= ATA_LPM_MED_POWER_WITH_DIPM && !no_dipm &&
-		    ata_id_has_dipm(dev->id)) {
-			err_mask = ata_dev_set_feature(dev,
-					SETFEATURES_SATA_ENABLE, SATA_DIPM);
-			if (err_mask && err_mask != AC_ERR_DEV) {
-				ata_dev_warn(dev,
-					"failed to enable DIPM, Emask 0x%x\n",
-					err_mask);
-				rc = -EIO;
-				goto fail;
-			}
-		}
-	}
-
-	link->last_lpm_change = jiffies;
-	link->flags |= ATA_LFLAG_CHANGED;
-
-	return 0;
-
-fail:
-	/* restore the old policy */
-	link->lpm_policy = old_policy;
-	if (ap && ap->slave_link)
-		ap->slave_link->lpm_policy = old_policy;
-
-	/* if no device or only one more chance is left, disable LPM */
-	if (!dev || ehc->tries[dev->devno] <= 2) {
-		ata_link_warn(link, "disabling LPM on the link\n");
-		link->flags |= ATA_LFLAG_NO_LPM;
-	}
-	if (r_failed_dev)
-		*r_failed_dev = dev;
-	return rc;
-}
-
 int ata_link_nr_enabled(struct ata_link *link)
 {
 	struct ata_device *dev;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 2bb87a3e7a62..5860ad5f348e 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -220,6 +220,15 @@ extern int ata_ering_map(struct ata_ering *ering,
 extern unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key);
 extern unsigned int atapi_eh_request_sense(struct ata_device *dev,
 					   u8 *sense_buf, u8 dfl_sense_key);
+/* libata-eh-sata.c */
+#ifdef CONFIG_SATA_HOST
+int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+		   struct ata_device **r_failed_dev);
+#else
+static inline int ata_eh_set_lpm(struct ata_link *link,
+				 enum ata_lpm_policy policy,
+				 struct ata_device **r_failed_dev) { return 0; }
+#endif
 
 /* libata-pmp.c */
 #ifdef CONFIG_SATA_PMP
-- 
2.24.1

