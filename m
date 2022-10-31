Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7CFFA373D
	for <linux-ide@archiver.kernel.org>; Mon, 31 Oct 2022 02:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJaC1M (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJaC1H (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2022 22:27:07 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F5BBCA1
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 19:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667183225; x=1698719225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nQOC0Pfd3xQkIpsrM2jqz2PO66oztnRmZbo1BOuXWN0=;
  b=WDMcSipDq/HrnwJSyvdJNYzbVCEwcQ8X2P9q850qz3bLAdQFY0JBVW/z
   HNzSRppf9uiwm0Jv12n5/AVZeSZ7PsE0PuOgciNewXtBi3eeaCnRZAv1U
   +il1x2fkuY2hCXstHmsVYqonIEyYMlWLcKhGJzGvLMsoG8kGPPzG9hv4/
   atr+UFE8SdGk0oG2bkp+wglK+T1FqwsA0mrKV59fZx6fAMsuJtwJNZKSh
   SC0xNITZsOzo8gVSPPUt0ObExVry/RV3lGCUMwQq4GMb16vg4kxPA5fgt
   hCxQO3aUI1iyYyroQwoZHsRn2+3bsvdtymkYGOxff8B1oacLhVSqzioRt
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="327200446"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 10:27:04 +0800
IronPort-SDR: BkI1eptpQrOJ9kxbLi2jIsrNQLg3cpAtd/QRwTGvCNBTJmYPdQCm1YBovNVSrIhHZ1ZkPFq2Y8
 ZY1iwSEc+YGFD/MENvnXdaT+74z1AtvPWsGhLFKp/YW73Wv/yoWvcgweFD8VNdSvzCCFYRnyky
 eQ+joQvsfBsWiLZt058TAeLMz2xrahxYMSI+1j5ePfH2xELA4ZSUZSkEf1f8orT8b8kugiDhVv
 DV4um6elzjEqO1bwpLNnPWcGeHhPydAJ4t1h05FZTG4i/EvtJtPh2RO18G6AvIWpwGuW0f1wEQ
 Bftmo9ii98Vk5xtBw3Kcc5aF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:40:38 -0700
IronPort-SDR: qBO07tdFHwTByZS+W0V6A51SnlKIqK/LevPe4V5jN5iB64BPg9CnkDGJlDK38Gny4GwE8ZEkQs
 BHOs15vSXdFsYvHI4KCPhkC4a6h7wkftTpEwltBbFCAvRZJP/PlwdMvQatPh/z0Y42crYjbw0f
 NdMUOM+hNIZeWq0+Yn9qEmBEUlTaD7GrwPWhKf3/FQhLCdzxZGJTkHa0Xk3E02DyikuXfa97DU
 PsZ46gF4YhujTp67blDB3som6WSmnzoHtLTkeMp8eEUm8dDHT/aP+qlv8+BTADsutpaHlyzVmP
 AI8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:27:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0xqr3bH0z1Rwrq
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 19:27:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667183224; x=1669775225; bh=nQOC0Pfd3xQkIpsrM2
        jqz2PO66oztnRmZbo1BOuXWN0=; b=lMFRxtgFdhAVjKuRBdggU+49SqLUb10GeD
        nAFhStOWn6RKqqt1NZAu2Cr4RfwBai04hr4Kbws+W/ObcsgdpCvbc6MwdWfnjppE
        a/1MP0JZhZVTGRXUJPUO++qbZOTVBAy4Eq52Dg7N2R5z/HVdDhcuAxT5D9E947Dj
        aP/yVLrzU1BEfderUbf+rMlnr1ISMwUaBY/6JuIMGPinQIlYxs8TVS6O0r5UEBPC
        HboRTvcR6Hw+7xtdl7RHbmEddZX9J+ZYNhXvduHWt4xrfbNmakJisOD1JROttzUU
        cNDdVX8F8Fjn70giP6RuHQLoHG5DJL5mdv7UWOFn88tWd7GyjnsQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YeOxA9dd8Aez for <linux-ide@vger.kernel.org>;
        Sun, 30 Oct 2022 19:27:04 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0xqq21Gfz1Rwt8;
        Sun, 30 Oct 2022 19:27:03 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 7/7] ata: libata: Enable fua support by default
Date:   Mon, 31 Oct 2022 11:26:42 +0900
Message-Id: <20221031022642.352794-8-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
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

