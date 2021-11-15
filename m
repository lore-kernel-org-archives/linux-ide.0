Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FE8C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 06:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2511062F90
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 06:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhKOGI5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:08:57 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15528 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhKOGI5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2021 01:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636956362; x=1668492362;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wouHAUVdXd20nrJTgfaedzy7dBF4ip2kdzVEUxjGjXA=;
  b=CopG3Pe2Pfg06l5qEFdT46AdwgnYZnj2YF5ofSK7CpQIA7jg9dQ1M3S8
   QPwNs0kw1jwHWbqawpZfvFhObbCxS/uXcyiWzcIwn55jeEx6T/Vmvl4UJ
   uWrwIHlZnlq8McHlk4PmVKUNlgcsUr/uWfEYv6OAG9tioixkCY1h48SF/
   7NAYOwHmomyDwoK+Rta3dyWwLoGDJdfLyyF3DFgavFPFczxWeHJoUdUz0
   SFRHvxA+JyzsHXzjZXr9mPUO5Ty5gOv+ISggO9isyVJHwHBI2MxNM3rWd
   ESXJB8uWW4XzHGiaJiwagfzQBkIBrAGRubVhZHQ6MLrP6gya8LuE1Z03Z
   A==;
X-IronPort-AV: E=Sophos;i="5.87,235,1631548800"; 
   d="scan'208";a="297418910"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2021 14:06:02 +0800
IronPort-SDR: ImVMRi7/2dHpAfy2o//rmucLJkkfP7n49uwp1HAKo8NKDDJNcnfxdkxIrHsL4IGskd/0L+VGSa
 Pj6xPc9k5IDPEJIEKi+5zXfrJihGcx87AFgNbESljrB3ybt5+lQFlYfrDZT2ro/ytFwybPI0Na
 voPLYu+IBg47WFcR9Ks2qEACLilhHsN/WDG4HQIQIvs8QAfW/G03i00FV6arR+nYi/kgEyjSRq
 wOLvyAZTINAyIO7yulHeZr6s6FJCO/TeMgud3Fmu1sZTxNILh+HyuV3ShMGY0jy3z0LzMvn7gU
 N2+dNPa4FwmmTyvBisTlYsPT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 21:39:34 -0800
IronPort-SDR: HvxkJ1K0G6eqCsrUSEcNxVcOc02EKoMjwPcaxF4XSeqTrZT9e/tKbbVSZw6IdCMdoqT5CK6LAI
 iyHH6udzZLH+7xT2YIo5Du1T1EJYW98TQU1yGoJ1P8+h9RaKJC2kYFreKFdCI5e53Vpi4AtWU/
 c27tVP9MP/8poCCMAl/OHWnfwJiG1QGOWzjD2ILviTHahQlnQYzYiLi9KDiVJCM9X/pI7vnq75
 O5jaz03M5B21OtSdL8cAJeeyG9S07XEvLx9h4+RRYIUtAtgYfq7ux40JgRLc1IMmbPvqR6+euu
 8Zo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 22:06:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HszG14MY9z1RtVn
        for <linux-ide@vger.kernel.org>; Sun, 14 Nov 2021 22:06:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1636956361;
         x=1639548362; bh=wouHAUVdXd20nrJTgfaedzy7dBF4ip2kdzVEUxjGjXA=; b=
        hr9j4widmfMHB+mH0y6BOZk5Lqi6r5h9QRHWgfwjW53HEiqLkP8/iHCkScKtgkM7
        2MsUYKE3LqFRhbuTMtIz4PJqprge77CNL7kqf/JGP27E3Zchl0qjmztVHSYNq0kP
        cl5UyLhseJeizkP6cDQZrVrrLq1jYvv8B5Oy09uSuSXfdXO9A+ngmqhecCOIvPNF
        P8zwAo/xvaU421hwKVUpNBO4YfTSGTKG/5YO+k3aij1JGCzcHTihGZulKk3ydbOt
        d1NIp44fv1XEc/OItt2ufcii+5bzVYkcYIjdrpCOsoBsYUPtInWuDNs1/uncfFwW
        FHXLmS9CJumNfde1+zTxtQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FpQQcqcc-0nq for <linux-ide@vger.kernel.org>;
        Sun, 14 Nov 2021 22:06:01 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HszG05p0zz1RtVl
        for <linux-ide@vger.kernel.org>; Sun, 14 Nov 2021 22:06:00 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 0/2] Fix log page accesses
Date:   Mon, 15 Nov 2021 15:05:57 +0900
Message-Id: <20211115060559.232835-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

A couple of patches to improve ata_read_log_page() error message and
to avoid attempts to access non-existent logs.

Damien Le Moal (2):
  libata: core: improve ata_read_log_page() error message
  libata: core: add missing ata_identify_page_supported() calls

 drivers/ata/libata-core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--=20
2.31.1

