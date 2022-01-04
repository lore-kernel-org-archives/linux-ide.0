Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F287C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiADK66 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:58 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:15911 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231767AbiADK6z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:55 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNs3cgZz1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293933; x=1643885934; bh=cqjQ/u/nAi1nsP7hMv
        ygIYhj+8OlOjgqEMjhLOKOa54=; b=ELIQ4qG8FatzV4oOkN8XY6H/juR/foOwG+
        ZreE92/C2jVoo88Fh6qpSEyEuNKjuJ1pJ//28aojdHeeqwa7+TftC/egz5MOYodA
        Rc+Jrc0f1xekuc5dY8oLSdxbacVAX3yty2vyzDwc5CdumgzTpzE8TkMCe/TPVFLO
        MH97DocfEQYii2gAFrxEdwq9MAlfV5C6rzIOk2/Q2hcdjnqbO3OSCC7t86Pjke2S
        DnYXyree0CTGxM1a219j2uDhMzkB7JUWI5V1uK6yPsFQBHXSHGqisE3PbjArHaFS
        VH0cdS4YSEErvvIScEJCiEqSnh2HWEiKqp/cWwGopTqfU1GQHmDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8egGA-L3KVIc for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:53 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNr6BPwz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:52 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 12/22] ata: pata_bk3710: add compile test support
Date:   Tue,  4 Jan 2022 19:58:33 +0900
Message-Id: <20220104105843.1730172-13-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_DAVINCI.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 8df5b32e6879..b706a3a64b11 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -616,7 +616,7 @@ config PATA_ATP867X
=20
 config PATA_BK3710
 	tristate "Palmchip BK3710 PATA support"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || COMPILE_TEST
 	select PATA_TIMINGS
 	help
 	  This option enables support for the integrated IDE controller on
--=20
2.31.1

