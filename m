Return-Path: <SRS0=C8TE=7S=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB0EC433DF
	for <linux-ide@archiver.kernel.org>; Fri,  5 Jun 2020 03:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46D920772
	for <linux-ide@archiver.kernel.org>; Fri,  5 Jun 2020 03:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/0NRK4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgFEDGy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDGy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jun 2020 23:06:54 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE9C08C5C0;
        Thu,  4 Jun 2020 20:06:52 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k18so8766921ion.0;
        Thu, 04 Jun 2020 20:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SEMVIaaP+S5d2kqcTtBSWBSkbg2/3nX3N1FhHRAIYII=;
        b=U/0NRK4nanZ7ouRVvRks6dfdyOA7bQhUudb/hvMEW2cG9EhzVVYNuXs5zSSbzAgWJB
         QgLv1AaWVX0/Z3+uCKL2LvhZAMI5XVqXLLfuo9pq3vZMtxgBz/MGEow/vvB+Un6gHCrV
         US2DRMwU4uBnaS7zhK+ujwr9qTs3Pzy5cj89yzlB5Y/actfjHq9piMSZQruCEexFtC2t
         yMTPrfoNLFX0Diif66qN+L/XoJCDqQR7/lsAjn7TxB3nsHFoktqCfZYvnXGH05XH4Ouw
         2LAALEjgKXoddL7aqilXkqfc2nRJA1hVcWvRwkOyGjM0/QFzv2u8d7xG92A0S4rDHrjp
         i2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SEMVIaaP+S5d2kqcTtBSWBSkbg2/3nX3N1FhHRAIYII=;
        b=qLaMNJyMRMT/X1yV8e/lHUauETtp+2vGvylzXIVmlhTPUat+EttMJogO/fX3dLyLZb
         PMY+dlfq0iFeLxgxk/WV6oDvNCT0gUbpKOuCxi1o4TGncQfScBDmTt+r8xSez3y7ZT8r
         Y/CriZ0nka1kGp+eq2YUMSJPN2fY1H+Miuf7o+b12yOk2mQkIN9F6FqXE/Tlq+gINcQ6
         QI39orsJmbAL/dyB7cqrP/Zx9fnVjbxb31JjK9EzP02MB479/OfRenns2rojGZkht9Ns
         x7hCGYqKUodPm2GlT66+5ORBipGqeJu67zIVXBJlkxKIqv3K46/W8FD+SDL+M6GrSCfr
         1D4A==
X-Gm-Message-State: AOAM532zMGWLAd8w/bSulJBLhtSmiF+Mx4IgphI0bTNsI9n5tdi6+h6h
        2j1RewfjasqCOzdic4jdRp8AtNUCjpA=
X-Google-Smtp-Source: ABdhPJzpJipSoZ1M8HHrUu4HljRD6OB4ebYX9EKJHhPU/+0/qzf384rZtu+gKb3f+4J3bEbEqEF0cw==
X-Received: by 2002:a02:654a:: with SMTP id u71mr7187436jab.7.1591326412272;
        Thu, 04 Jun 2020 20:06:52 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id z4sm2324277ilm.72.2020.06.04.20.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 20:06:51 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] sata_rcar: handle pm_runtime_get_sync failure cases
Date:   Thu,  4 Jun 2020 22:06:43 -0500
Message-Id: <20200605030643.91801-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/ata/sata_rcar.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 980aacdbcf3b..141ac600b64c 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -907,7 +907,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
-		goto err_pm_disable;
+		goto err_pm_put;
 
 	host = ata_host_alloc(dev, 1);
 	if (!host) {
@@ -937,7 +937,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 err_pm_put:
 	pm_runtime_put(dev);
-err_pm_disable:
 	pm_runtime_disable(dev);
 	return ret;
 }
@@ -991,8 +990,10 @@ static int sata_rcar_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 
 	if (priv->type == RCAR_GEN3_SATA) {
 		sata_rcar_init_module(priv);
@@ -1017,8 +1018,10 @@ static int sata_rcar_restore(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 
 	sata_rcar_setup_port(host);
 
-- 
2.17.1

