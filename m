Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A04EFA3742
	for <linux-ide@archiver.kernel.org>; Mon, 31 Oct 2022 01:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJaBx4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Oct 2022 21:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJaBxo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2022 21:53:44 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E72E9FD6
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 18:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667181223; x=1698717223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nQOC0Pfd3xQkIpsrM2jqz2PO66oztnRmZbo1BOuXWN0=;
  b=LhmdhBTVDdNr20/yUUok+hWpJPSaZ8IdsEU3tRb3I7gUy/GgmZxqXmSW
   t6iJaum6leS9yg3YP+tUmWxJ2cL38GvSYVk6mkMZ6JbgqjQUx6dKdZomo
   XyRns2ufFOsFau/joyKk1wn4Lc0zOmVRrqjUy8QPILkoBaO052/ddOcV2
   QNjJPHXnuNwL0hsSt6u+hl4CG68InscrTdVCwEctXnl6DT78pvNaxCsTt
   7rG4QDIFf8vWhQddAm94XW81X5qWq+h29KZhTOf9lPF2wX/wxbvvc4y2m
   8qCFyYhiQovAHfEC26qPzp/Su1uueRH/8e4PXQhUUbjtJkAD1brN49adt
   A==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="213387076"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 09:53:42 +0800
IronPort-SDR: iXQdsZP3sQcdKn0eVftkj5P6JSVyZsrDNy2Xhhsjs6IocNbtLNFYP7wBJCPoRcpNDyL9e8mQxb
 3UTlv1QPbytyY08HnXy+UskCnseJ8z25M36RM/6TSYw9SM/Qcrq8dsT8R6kDs5bL1/qnP8RzXu
 1rYhN+As9xhUeUFg1y21doplRZ/kuDNhv3naJeiROg1VZkfbWN6RZnL1E+rv3qZnRo7wr4QvwC
 FiZ98+lwAX8ZihWDeVDac0jXqtJSIR8CxJthPZA9pjNx5nhTV8041+1/1WWldMQcoKmrn0jdm8
 92Xmd50g3u7K94duHpcE4KLW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:12:59 -0700
IronPort-SDR: 8xOYot2cMAT8I3RS+8xonQxZaLF39d5y//KgT6E+GdsMdqjmTIlOZA0zlkn3vE2baLdjH+U1ri
 ILfuRmg4cDKkEJpW53Qq7kLfsq/qm2AHoRobP5x0MsdWxGQH1pDBwWgQhEiJTh1e3s90Qe3H62
 y0LtwPntFaOE0/qMo8wF3wQW/pCXOKVXdeXjJICxv0tLcEVhqUkcTqnrzUEn+wN3qQHwgfQTFF
 G1RIHTHLulsZ23mUTMQbdxn+duyzeGwx/Vdqlpt752Zy4fAbVIfr9sHb2aXucpzOq2/VD4Dm3u
 ivE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:53:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0x5L3Mhsz1RvLy
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 18:53:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667181222; x=1669773223; bh=nQOC0Pfd3xQkIpsrM2
        jqz2PO66oztnRmZbo1BOuXWN0=; b=cyeiD+0Tf1+QCVcztZMvBqQJxAn3gC4Pvc
        r0boeleua/9kJZYMOdoB85X2+y8tuRIib75BAjQ3odcIr8qI0pUcP4aOan4mgCRH
        4/K1+9DGSK8lWEDW0TK1O6UbljvJsE/CQsbjTqdI6J9EZicvco38VBwFySjLetoo
        6E42PjfBkt/104x3FZwVEvnlBzG/vW3CUTZgnEoLiS4OuvmZxuFZwJDW7bUmsooJ
        pyw9g4SPIZXbbureOScyRITEqzVPtjwtfbANvvP1fMLeakPTP8ae8Qe1wAlghWzz
        4BRet5dWKTF1c+BXahHF5lCrEk6AI8vwJPtIQoAK6fSigYpikVBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SmKq9Bi6qKl9 for <linux-ide@vger.kernel.org>;
        Sun, 30 Oct 2022 18:53:42 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0x5J5CBQz1RvTp;
        Sun, 30 Oct 2022 18:53:40 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 7/7] ata: libata: Enable fua support by default
Date:   Mon, 31 Oct 2022 10:53:29 +0900
Message-Id: <20221031015329.141954-8-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
References: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Change the default value of the fua module parameter to 1 to enable fua
support by default for all devices supporting it.

FUA support can be disabled for individual drives using the
force=3D[ID]nofua libata module argument.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 29042665c550..9e9ce1905992 100644
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
2.38.1

