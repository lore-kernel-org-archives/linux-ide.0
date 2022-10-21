Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1D8C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 05:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJUFiP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJUFiO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 01:38:14 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D16A1D3EB9
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 22:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666330693; x=1697866693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ZTcLMwdxaPgg4FsTQzlZAD3d3RyuFg5daFjUZLmm+U=;
  b=okKJR3U7BCFgmxwPxwgqrSLBhQSaTN5LH4dd2OxKE+V1B46ScJ3b1udt
   7+qQ0HbSD88S6UZMvpvwWTfUsV/INs5sAqrwSOpV/oq3uKoVx57f4YMK3
   1YJypsSY2jnEnTIozIkWkMy3cNvqNMH7YzwK2JeG/cMPnVGLqhDe+OlNw
   mfztf5suk1xDC5OpVDPawF9orMc96muyeXfhEnrkey8lIeSBYTl/Qb7TW
   S5c8/UXZA/UoX0rUucbsrCsphtY4TtlS2wdrVRtw2Kb802NK5Rhl4vcTc
   ZqZWlMrrGMKI9DC703boCay8a6dhS7fXe0aF7sp/wIuPHeE+QvhgJjsoJ
   g==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="326518272"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 13:38:12 +0800
IronPort-SDR: BQpL54fSsfkv7DRa+crscGC/U/NNjETp4YnzLLw/OrMbf/s0rbXRzJTXsfHgF4nN+9ulZkB3Is
 TMbDJHGJQHmz7u66aRw9lWMpN/v8Et67ePrFdL5833OjOQjhFdO9HZHDgnqq3BKwp9x2ikUwKd
 Vpsql7IaECiWtbFp8i8xdYAi0OmaWWGreI2Du67ThIRD/LMZPq3FAMZIwismS1Hgfs+4i2vqw9
 97NIpKQecNuxNzKyhcf/Gnwia1v91OtbJ/GDPncw7LDBdsITZbNJvwPMD+dt6G7K1UgtmD2aZ/
 sJeiiOP6/d0cMZLuH/NKMZM2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 21:57:40 -0700
IronPort-SDR: jcv5os1vYXA6P/2JMtcxrB9F+DboC6RkhfQlcj3fkB7kYE3CqC9msloAMQ8yy98cWFoVNjOtdm
 1f2nN5pBYjpzWXwP4BYmrkZdbhJpEKL23SuBoUhG+5tH4Tlp+EdWVdUmauFrU1zXLLHl0Z/vcw
 UD5yU5KQzqPkFElbXHQxm8Jlp1zC1EQswM15kAAOcpewx84csRKUaFuuLDMMk8HWbWtjm3e8QP
 DpnT307ox/mvMEV701iIIJ+N3Li7rcfQ+2uZoP/+9P3i+lzu7u1GG4fok+7sd+hVAlva7aQZgU
 fTY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 22:38:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MttXz4t9mz1RwqL
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 22:38:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1666330691;
         x=1668922692; bh=3ZTcLMwdxaPgg4FsTQzlZAD3d3RyuFg5daFjUZLmm+U=; b=
        Iy++xc6+a9F+jj/Coc2LHsoafNmrEnNb1l786tf+WQt2urV8QrSk+enUd5wERlB+
        9L5Sp9GtMYFsoDdHoKizxwkqoumEC7vyukXyAgebHknc6XCfQh7MXvm9CQe2ISXu
        k2kHoD+an6fX5c6N2+LjHNAt1T0re+DWkZTsS+g4lowadmVFZOfeK/ymRHtkFFH1
        kH92OIrmruY/SYHnmS6KF/Fhgwjx3Cvum46fgGuVXMIYE2IUFJSIMMBOgFrRlVLa
        2N8xKuUk/mvfTLfvWUrkb7ptPo1/Y0wUQINhVsy90OiBYfHZJ/y+rOY8M0CuDpAI
        PLVg+rkqib06BtNvRkAhEA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dOtis5OgTc85 for <linux-ide@vger.kernel.org>;
        Thu, 20 Oct 2022 22:38:11 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MttXy4t6qz1RvLy;
        Thu, 20 Oct 2022 22:38:10 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/3] Improve libata support for FUA
Date:   Fri, 21 Oct 2022 14:38:06 +0900
Message-Id: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

These patches cleanup and improve libata support for the FUA device
feature. Patch 3 enables FUA support by default for any drive that
reports supporting the feature.

Damien Le Moal (2):
  ata: libata: cleanup fua handling
  ata: libata: Enable fua support by default

Maciej S. Szmigiero (1):
  ata: libata: allow toggling fua parameter at runtime

 .../admin-guide/kernel-parameters.txt         |  3 ++
 drivers/ata/libata-core.c                     | 35 ++++++++++++++++---
 drivers/ata/libata-scsi.c                     | 30 ++--------------
 include/linux/libata.h                        |  8 +++--
 4 files changed, 41 insertions(+), 35 deletions(-)

--=20
2.37.3

