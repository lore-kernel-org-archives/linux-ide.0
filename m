Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C25AC4332F
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiADK66 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:58 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:48315 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231766AbiADK6z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:55 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNr6MRcz1VSkZ
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293932; x=1643885933; bh=q9BWiVvZt3MIOYJ2V8
        /iUiTqcAk0PBCTR0I0ldil8n0=; b=WkdPPhm442chp58leW2K89H1/+O/MJX6zG
        qbNVRfvUTIIaprSr2L7rlC0WsAKekfLqfItEL5Z3p1u5eaAJZKxuwAWG7wgxuN34
        9e1t/MjdB4Ax5x7Eb2Oq778ru7Sv5lpsyg59p7c0lkDgPbMvELGvjQNjTikPgms7
        x9eO9BOEfNZ0tpuF2PFemDca86F/XZ9cDCc9lRCyFrCJzt0zvXNdfxv6iCMtL86B
        xJ9JVFzIEtNaKkvFvpkID8RxK+fVTsUZ6Dq5aL5TT4s9W34gZjJfsku36ISLMdFH
        Ug1KT31ZyXox8IITOI6OgVrd5iEzghfFSvtpYTG5fcjPUQNsN5TA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dSrA1R82cC6z for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:52 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNr1hxqz1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:52 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 11/22] ata: ahci_seattle: add compile test support
Date:   Tue,  4 Jan 2022 19:58:32 +0900
Message-Id: <20220104105843.1730172-12-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_SEATTLE.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1be6a14e46e1..8df5b32e6879 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -311,7 +311,7 @@ config SATA_GEMINI
=20
 config SATA_AHCI_SEATTLE
 	tristate "AMD Seattle 6.0Gbps AHCI SATA host controller support"
-	depends on ARCH_SEATTLE
+	depends on ARCH_SEATTLE || COMPILE_TEST
 	select SATA_HOST
 	help
 	 This option enables support for AMD Seattle SATA host controller.
--=20
2.31.1

