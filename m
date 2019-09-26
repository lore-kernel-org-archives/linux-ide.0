Return-Path: <SRS0=z20e=XV=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF549C432C2
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 03:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBA8207FF
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 03:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzFECibO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfIZDyi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Sep 2019 23:54:38 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:46307 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfIZDyi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2019 23:54:38 -0400
Received: by mail-pl1-f181.google.com with SMTP id q24so425954plr.13;
        Wed, 25 Sep 2019 20:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6iT2rVRbh+uIy3YYln7TJjohTVuih+fkUh+nEZdvWpM=;
        b=DzFECibO1LVSM93pomm9jWlQQMkSPVE/dExMybwC2Ky/AgQcpRi+VOOkTv9fTiTPw2
         5OnjO8SdQQsRb0aMdr+9JT9pWGNjYOFzlZlaWZE9eRFmA0JaGs+kh0iKwi/ONL0Sj+vj
         EctwQVAzslIgB+qliX9nTeHnUSEqDN6Ge5LGOJsskgJHz6b71oMCBevEnftFny88IenX
         D7yzpYW0t/v8VB6/PB0JTIqeDoSmzWSGmgqcs4+cF9a1/yus4jVAQRWvwLOgXY8/6vVw
         NDGgcIbxVofFEeDmCgKvJFCix+eZ9KzKkY2ACMbTVp721PB7dlC619Yiioq29rw+///j
         I9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6iT2rVRbh+uIy3YYln7TJjohTVuih+fkUh+nEZdvWpM=;
        b=EIOOhOtVyrdV9aAb1kGZtQCNwJmfUu7LeOGW34Q3aYpOUsRdXD+3NSpVlDkFgODM0N
         lju6TFZYNUelTsdG5igE1alqZSJpZuaYnDxxx4BmvWd5/yA620SCgUyTAW+iUrXKYWQa
         babc7pbYj5mF/6w6DTfcZuzmXNbq7gHOo4ghczRwGlUc4tZqKGCfoCW2c5M4Ru55Xtnw
         1rgxK6rrVI3wAz/HHZX2nqf7k8JvxKcnPvVaZVeCSl5pphQn1djN1l5Ythw3MRGZD9vO
         ftPGFmGGqnULs0haK1kVYRXXQNdLnaZ7qgZB9d5STOm599S0lG+mxLj9Nrmd4MsiBjxO
         vxFg==
X-Gm-Message-State: APjAAAXuhpR5td3hEeiHZsBsrPSmVjAAFidz986W+9OqcxvP7GXGISal
        SoQ9oinVjEmh32UB98A6Jqc=
X-Google-Smtp-Source: APXvYqzFj7vC1vcXIgDvDnVKdj6FUZfTMFVENfzcAu/WRJIEYciRnkr9i8OMqhrjw5yoPWIiKwC2rw==
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr2053715plr.64.1569470077472;
        Wed, 25 Sep 2019 20:54:37 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id 196sm581684pfz.99.2019.09.25.20.54.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 20:54:36 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id A2737360079; Thu, 26 Sep 2019 15:54:32 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com
Subject: [PATCH RESEND v2 0/2] Convert Atari Falcon IDE driver to platform device
Date:   Thu, 26 Sep 2019 15:54:22 +1200
Message-Id: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


[Resend because linux-m68k was dropped from the recipient list ...]

As suggested by Geert, at least one of the drivers available for the Falcon
IDE interface should be converted to a platform device driver (to enable
module autoloading by the Debian installer).

Add platform device for Falcon IDE (patch 1), and rewrite the present
libata driver to make use of that device (patch 2).

Changes from v1: 

Incorporated review comments by Geert; corrected silly mismatch between
platform device name and platform driver name that caused loading driver
to fail locating the related resource; check return code of platform device
register call.

Tested on ARAnyM with only the pata_falcon driver builtin.

Cheers,

	Michael

