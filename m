Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31723C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 08:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242579AbiCWIVD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242578AbiCWIUz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 04:20:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066AF5F25A
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648023564; x=1679559564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4AsyCi0QtNvalf56cLhMHGivuaVEVYo8oFkCqbF7aLE=;
  b=JqUnYcBVuhUWhVCh+ldDcA4Ejfzib3XAzFNH6/0Ch/WJlwXHt+Amkwyb
   bj3nOGHsIxdjI1W6zDuxOVk47nXHMRfnoTnDDwSRgaI3IvW65CbeZwjCP
   uZ9RktHVpp2hOCfzsrGzv6E5ZLPie1tcJzlScLNReme9LVzqkCbbOIueM
   k//9oBX7zZh/zVNKWxA+vYumCnxUfqcePAf7+IbIwRHSjcVKA3AT7I0BM
   S8HKlVAnIjulQ0TUAK7MG71aWTiwBgGBsn7a7eWkaPYAzbtlwWwZJol1B
   pDBzVkg5UpNppVndrozm1rZjMlpltrZLK0rP9OD2i1EBL7rl6ZvWBVuKW
   g==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="196047610"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 16:19:24 +0800
IronPort-SDR: VlGZU+JJIajKMVIdV0HUO+gYRoq1rzPFKsgPSszjACrgsSzu5MfH3NJ/Xkm8hqPEdc+VSbcRoM
 kkmGAKGH9QK9q1HIe2O5d9YwJc4UO0hAoawywASIgbH4Ky6mQvSr5hn1s6PGv8qXaEaWkhHI7Z
 2Njct5b5ooAty5hgpuIp6eSE8t0L7rQjenIlz6ESGzpv1ZVESjaMDS3gJ1ezzlMyhwwDhCbM5h
 e9aRyrWxm1SazVX7Dm0gONhtuD5uJosvB1jVFKjoyv8wfAqjrGE180JT8PmIECBCcHOwahMWo3
 P64IVbPQSF3j5az4T1QeYmIO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:51:19 -0700
IronPort-SDR: +imk8w8xm9GplaCd1ZNkmmxmnja/r+ttfxDy42q5sqwaUAE33RTv1WskX6/UvomfMIUyeUKeYS
 9pD5lwh4s+J3LgAVvm0hSZtXeLmdT7LUFv6Ux6KIvCvwA1sSjpU3cMJxTta8bbLQep6hjSHfuA
 AyeK0Aic2xGyxl/OpYqwES/gVuszqgIduq/JpBbpriftiqCffiaLZEqH29W+r/CK0YMiN1e4iN
 HAk83/4Scbo7kh7GwWiJDo/yLk6zYZE0OZq0mccioLAhGCER9txPYl7gbUvxRYAkRSelbyLBtr
 C6E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:19:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNh8s3zC8z1Rwrw
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:19:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1648023565; x=1650615566; bh=4AsyCi0QtNvalf56cL
        hMHGivuaVEVYo8oFkCqbF7aLE=; b=P3hkvll5iWj4MouDz+xbVrTm0V6JuiSDGt
        vt5AP53NyqxTva1O0IlwfzKWc481ndtg2FM0YlnAYQS+o4eOoQaENANROzN5uHFK
        sp3wqIrXN6wha7YeGf4EhjffRxhlckXXQervy7pGWDaOIAuC41udXJno+IJGZ2Mn
        akRf6umUc/2WdscMf/dNVgvxWtfpkWxcsIhqndSDtUMvVen/h2cHd1hDnoYF5gVw
        edKMNxl2NUD/tSzSHM6NFpMaJx+1BdT/nGP4oNLZgaOMlayBj5lWxIQzRDqjpi+Y
        1LA04PpP9A3CYb7HHS3FmZ41vY7ESiDSIQGkTWeVjD8ujRW4vZYw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TpuiZiazvID1 for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 01:19:25 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNh8r5hCjz1Rvlx;
        Wed, 23 Mar 2022 01:19:24 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 4/4] ata: libata-sata: Improve sata_link_debounce()
Date:   Wed, 23 Mar 2022 17:17:40 +0900
Message-Id: <20220323081740.540006-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

sata_link_debounce() polls the SStatus register DET field to ensure that
a stable value is provided, to reliably detect device presence and PHY
readiness. Polling is done for at least timing->duration if there is no
device detected. For the device detected case, polling last up to
deadline to ensure that the PHY becomes ready.

However, the PHY ready state is actually never checked, leading to the
poll loop duration always reaching the maximum duration.

For adapters that do not require a debounce delay (link flag
ATA_LFLAG_DEBOUNCE_DELAY no set), add a check to test if DET indicates
device present *and* PHY ready and bail out of the polling loop if it
does.

While at it, add comments to clarify the various checks in
sata_link_debounce() polling loop.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-sata.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 87ad03c2e49f..15423723c9dd 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -276,8 +276,27 @@ int sata_link_debounce(struct ata_link *link,
=20
 		/* DET stable? */
 		if (cur =3D=3D last) {
+			/*
+			 * If the device presence was detected but PHY
+			 * communication is not yet established, wait until
+			 * deadline.
+			 */
 			if (cur =3D=3D 1 && time_before(jiffies, deadline))
 				continue;
+
+			/*
+			 * If PHY is ready and the device is present, and the
+			 * driver did not request debounce delay, bail out early
+			 * assuming that the link is stable.
+			 */
+			if (cur =3D=3D 3 &&
+			    !(link->flags & ATA_LFLAG_DEBOUNCE_DELAY))
+				return 0;
+
+			/*
+			 * If DET value has remained stable for
+			 * timing->duration, bail out.
+			 */
 			if (time_after(jiffies,
 				ata_deadline(last_jiffies, timing->duration)))
 				return 0;
@@ -288,8 +307,9 @@ int sata_link_debounce(struct ata_link *link,
 		last =3D cur;
 		last_jiffies =3D jiffies;
=20
-		/* Check deadline.  If debouncing failed, return
-		 * -EPIPE to tell upper layer to lower link speed.
+		/*
+		 * If debouncing has not succeeded before dealine, return
+		 * -EPIPE to tell the upper layer to lower the link speed.
 		 */
 		if (time_after(jiffies, deadline))
 			return -EPIPE;
--=20
2.35.1

