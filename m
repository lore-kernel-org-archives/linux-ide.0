Return-Path: <SRS0=Q01X=U6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930A9C4646D
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jul 2019 22:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F78C21479
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jul 2019 22:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OakYK1iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGAWCn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Jul 2019 18:02:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39383 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAWCn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2019 18:02:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so8015917pls.6;
        Mon, 01 Jul 2019 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N9BhP6AJGX4/ArJ/JFMbWVXhcLnmYVxtC1mz1SEKSR8=;
        b=OakYK1iXiKQf8QvZ7w4rRmn6PPHBc/O4jFynWpn7nqUymMz8BwRx9/p/QGXfm7LlP7
         UBVXRtZy0IdaUvkJqZfdlfuLWdCOpB3jhEQe+oopPU2jbnIgEcXVNVkt9Aqt0ySPREcI
         y0bVdq0mEyclywJybg/c0ADTJZGQyBgAjlLRtRayPbtwy7y2BCfdMZ/HtXpdz69+VDNF
         cY81PEcxKtI6XsvPXOxk2Z0IUlWddtUveBPN+30gR5EU3TG8F/AG0J2r7+tT/UbN3SsM
         7HMadP+YBdwECnvToRr7TxA3wYAeDgLjTWGqDCN1XBl+LF4oe6LBJvTFaT4KtbGfZYSd
         Db8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N9BhP6AJGX4/ArJ/JFMbWVXhcLnmYVxtC1mz1SEKSR8=;
        b=ktBayHEHdL86f2H+kXggEJsctLydk0DPMoJ5vWkTItZJG2uYOoJG8V2IJBnUkAuWoM
         M42iHykkx+kcp8+BS9jCz03nt1bW0Oxm5kQEIztUO+db4DxFvmBduzF9AnApsx4Aj6Ef
         5g3XXCWZJqlWy/ufAvPupSz0LroxZ4e+b6DjfLkUpbh4tf8Cp4Gx3xd0/A7DUsPMxueT
         /nji/iIgPKbGsbgil5gR8npsF3szTzqxBNUx8SaGngyNjnusWeYu/i3tfr08FSDMtkej
         CaedJQimD4H7k6A/xA+CC0yaNqH2hC3+tFWVE3LkgaGGBbZKSR/Q0OqT0ONtl4exM8ZY
         LvDA==
X-Gm-Message-State: APjAAAWnJc26VRtn4193NBFs2LvuJ94Mvd6Y7e2Sf6h8IFOKFpLRcWOi
        EgDDcy54deZpxPGudg4j5lcpFj/m
X-Google-Smtp-Source: APXvYqwltHquQ/jQ+UZwX5GcwzG6W/Y9RMvPTd5MPD7Vcr8y1VfdTF367Xx+QdpvSy3ngELbOU3uBg==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6mr32169920plk.14.1562018562999;
        Mon, 01 Jul 2019 15:02:42 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id t11sm9662327pgp.1.2019.07.01.15.02.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 15:02:41 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id D7B0C360079; Tue,  2 Jul 2019 10:02:37 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com
Subject: [PATCH 0/2] Convert Atari Falcon IDE driver to platform device
Date:   Tue,  2 Jul 2019 10:02:34 +1200
Message-Id: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

As suggested by Geert, at least one of the drivers available for the Falcon
IDE interface should be converted to a platform device driver (to enable
module autoloading by the Debian installer).

Add platform device for Falcon IDE (patch 1), and rewrite the present
libata driver to make use of that device (patch 2).

Tested on ARAnyM with driver builtin.

Cheers,

	Michael

