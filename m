Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4C7FA373F
	for <linux-ide@archiver.kernel.org>; Mon, 24 Oct 2022 07:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJXH0Y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 03:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJXH0V (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 03:26:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B842B5F7FA
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666596377; x=1698132377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zT3L1lXrdj9pPArQzXt07ys8xjPys1a7SwOMZxaf2TI=;
  b=dAVM5RrRRjLbJvAyVsO5Egy6Of3hZq7m8PRi4K0rYIiPD9r/qumvbAH1
   JFqGiiPnM5KvVW8RCTuWazF84bX+Phje/hqOPgWX8/U0ctk07W0hYbqd+
   xSqjn1pGoSvO7Jawu1Yl9NM/ja3PdOctJ9EAuC0w8gC8RkGdS7yCF/KcT
   N3T3utReo2RlW0r7vXgK6Cq0uga7oWwQmSAwlfQ3tuUdztulVfE3Xz2sj
   S0cUTkT+yXemottzAlsi/fYEor+5f38kp73o6VTRv8rSt8QzG/kRNbudG
   HgDnWjNqforra0ivaezuJPpeuxbeI0vAEkC3JKK+ysdNEHuK3V/cipkC6
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,207,1661788800"; 
   d="scan'208";a="318901548"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 15:26:14 +0800
IronPort-SDR: qnU+FHSqLUx3oKKzq2uATBE2iYWII9slUsed8XsUFWnbmmtCq/q0PwcE3fsc0hUXjEWQ9gUI/+
 k/RvYlHpoJ+mkZLFaTaTwCOqrvj30GaMkJVSREiezTa0Whd/l59fB+/QEKGkKgyv94AYwtnv8o
 fHqR1jtaiIMSqzaHDWLjZIwPX3ZDjbiyJPWKP95uaEFJHBdP2uWGIBTrR1qi2rrpQVSZYOe3WR
 /Zxcf48ULo/3Vg9RtnK5kqGv3oLB7KqVKNyqlw5QR8nlqh/yfTot+zKjEmkL7h0TlJSn4wZ/Qo
 So3Jc+AFEmAMYO30u4XQFMiZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2022 23:39:58 -0700
IronPort-SDR: NgD+2T6J3N5ROwGgUPYpEaOYUEtPeSo9VgjPdSIqBohqADV7SyW+mfEHkNdPVl73f63AHROy9y
 3g+PzZMmJbjcJsfvTWiqc7FpcY6ROcrpFykgPM0bhSROhDWIy5yw5gW0TzTiLX3PqZmZNmNaxt
 bx7ZgG24jtFYvoh3K1UYCctlpucPxjbu7MM0b+ms6mqqPdIZ4iCzWuzAWpUCrUe7c4DmgBZwwT
 cCPHjKRvrugZ3pwTlWvvMXLkg2fbPRFM//JuOFAXb8Fq5kS0qrtEnAZhib+S+W2CKNG1hWsXrw
 pwA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 00:26:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MwmpG5bb6z1RvLy
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 00:26:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666596374; x=1669188375; bh=zT3L1lXrdj9pPArQzX
        t07ys8xjPys1a7SwOMZxaf2TI=; b=ucn9vChTOPeWLSed2dM4ONjWl4reE1fLn9
        GC/KQz+123re81PQQAtw0b3ubDWAbKhwSt5lDrFsbw1lTwwXJQeRWCig2YWlQy7F
        9JLWhIb4S11Uh6StvWLTZQysXqMJs6q8uo8RKZolyfQ9x++R121LshJ/XodUfl9m
        wS6i050nB3Z0aHjzcgZQb8y6iUgo2qXF9FqjuigOfjfvIVtWlW3pW1UpyE0QsxL9
        aXnnmUT5QmLyauk/3p1AuNCMfj9T8t+TBe3tbmTPKEkkUUlLYeDhakRCdgvmXqXV
        HnVUoju5OTzOg9wwkdIb8cbel+IpwkIFkJCd0HcTY+9yEkkITFdQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1YwwPftfx-Lm for <linux-ide@vger.kernel.org>;
        Mon, 24 Oct 2022 00:26:14 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MwmpF5wQjz1RvTp;
        Mon, 24 Oct 2022 00:26:13 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 3/3] ata: libata: Enable fua support by default
Date:   Mon, 24 Oct 2022 16:26:09 +0900
Message-Id: <20221024072609.346502-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Change the default value of the fua module parameter to 1 to enable fua
support by default for all devices supporting it. This parameter
description is also updated to indicate it is deprecated and that
libata.force=3D[no]fua should be used to control fua support.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 27aec8e63a8c..867e2c423627 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -127,9 +127,9 @@ int atapi_passthru16 =3D 1;
 module_param(atapi_passthru16, int, 0444);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI dev=
ices (0=3Doff, 1=3Don [default])");
=20
-int libata_fua =3D 0;
+int libata_fua =3D 1;
 module_param_named(fua, libata_fua, int, 0444);
-MODULE_PARM_DESC(fua, "FUA support (0=3Doff [default], 1=3Don)");
+MODULE_PARM_DESC(fua, "FUA support (0=3Doff, 1=3Don [default])");
=20
 static int ata_ignore_hpa;
 module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
--=20
2.37.3

