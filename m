Return-Path: <SRS0=O8dD=YP=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37085C47E49
	for <linux-ide@archiver.kernel.org>; Tue, 22 Oct 2019 16:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B1221783
	for <linux-ide@archiver.kernel.org>; Tue, 22 Oct 2019 16:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbfJVQVc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:21:32 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:44972 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731132AbfJVQVc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Oct 2019 12:21:32 -0400
X-IronPort-AV: E=Sophos;i="5.68,216,1569250800"; 
   d="scan'208";a="29712998"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Oct 2019 01:21:30 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 665C74000FBD;
        Wed, 23 Oct 2019 01:21:27 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH 0/2] Add SATA support to RZ/G2N
Date:   Tue, 22 Oct 2019 17:21:17 +0100
Message-Id: <1571761279-17347-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear All,

this series adds SoC specific SATA support for the RZ/G2N.

Thanks,
Fab

Fabrizio Castro (2):
  ata: sata_rcar: Add r8a774b1 support
  arm64: dts: renesas: r8a774b1: Add SATA controller node

 Documentation/devicetree/bindings/ata/sata_rcar.txt |  7 +++++--
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi           | 11 +++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.7.4

