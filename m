Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF478E92730
	for <linux-ide@archiver.kernel.org>; Thu,  5 Oct 2023 19:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjJETY6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 5 Oct 2023 15:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjJETY4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 5 Oct 2023 15:24:56 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E4EBE7;
        Thu,  5 Oct 2023 12:24:50 -0700 (PDT)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 84B0C7A0090;
        Thu,  5 Oct 2023 21:24:47 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] ata: pata_parport: fix EXP Computer CD-865 with MC-1285B EPP cable
Date:   Thu,  5 Oct 2023 21:24:36 +0200
Message-Id: <20231005192440.4047-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Two bugfixes, one workaround and IDE command set registers support for fit3
driver. All needed for EXP Computer CD-865 drive with MC-1285B EPP cable to
work.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
Changes in v3:
 - add missing stable tag to first two patches
 - drop cont_map in patch 4

 drivers/ata/pata_parport/fit3.c         | 14 +-----
 drivers/ata/pata_parport/pata_parport.c | 77 ++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 14 deletions(-)

--
Ondrej Zary

