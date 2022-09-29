Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D631C07E9D
	for <linux-ide@archiver.kernel.org>; Thu, 29 Sep 2022 03:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiI2DpO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Sep 2022 23:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI2DpL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Sep 2022 23:45:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B110A3
        for <linux-ide@vger.kernel.org>; Wed, 28 Sep 2022 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664423108; x=1695959108;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mis1j5m8KK41I90mx6NFyNQ2Qf7KLgRDmDKqjpmAzZw=;
  b=bRmuF3On5ZL67H2cwZbkMCH+4d+UtvvHtdUy6y3KowU+jxx6wNqg3bcH
   7xyc/y5seyxBNiQGspw31RGa9CzJbXAvPx5m9SoZ1cUZEX5OaNKYhmF7n
   GDIAYJ6sh7w2rko2s/gKv0AWFcsTF6B6wIOHDdfEZau1vKUyc8jFSJCa4
   sALHmX5CXDWk0XzdHG31NJv9zU+BezP4aXOqUd7CEXu/QcQWIsucPjq8s
   BtIabWdPTXrgIKF9xRW/O7//hhce0dVD+xpZL/O+DArZyhTPWyPWO8a6S
   bPySSvQ2UGxRmXOj/yMcs/JrpfOtlIEMqDrwKnpkfjuiMuFo+QiShFEYb
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654531200"; 
   d="scan'208";a="217721323"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 11:45:07 +0800
IronPort-SDR: kzAex6YDNBWWzgTvWJ3G/m0b+rt3i9VYFhatjpBorSMw07b481JzP/WVMSW7i73CUQMaxvGr56
 wmj76fwJ43ziD0wQFDXrAbV9T0/7YcPCYOe3Oy6Q474loK+raLG0ZOkuphFEVJNrRigbWFBMXU
 RhDd9zRCIgZPl9+igsNECQvQ2gOeRPs0RTaV99gyFLCOkSEw3t5K6FwUpl0VMui93LfCOGjBO4
 gwN8+SdOcODglxuisl9DMldITQdctVhDTzArOJnr44i3UHQOns4zBEEbanPNv/FjQBFtGNYSm6
 10s2yw58jS940WyIZrFy0Sd2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 19:59:29 -0700
IronPort-SDR: 9ZR5TwfsxVdpHoX/AuCVvgUfeDIvB2GAU2yOnClg/8A0RVs6jF24WyqDH5BYuQA6xGgsZrII8g
 YOH9vYrVqyHY2NDawZw3r+ZQIglWmAwQ9ia/6KNZorfT+QnBsIoMdBWPB/6hLtIUq/avc0vUBu
 nXrXuwfl8ZZp7BiHzjoXNZg0mjImmiEVvmdQP0qg2c6a/j0t36W7KVizEWuZO07VEdqblWr3di
 y98teegf3bw4cHRB2vABA75flavrnSolALntLXZ2zS7mNX1o/Qp/yCG5abP+I9A6lMwVRiI4FY
 fAM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 20:45:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MdK4b5SmJz1RvTp
        for <linux-ide@vger.kernel.org>; Wed, 28 Sep 2022 20:45:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1664423103;
         x=1667015104; bh=mis1j5m8KK41I90mx6NFyNQ2Qf7KLgRDmDKqjpmAzZw=; b=
        RtceEihaGmJWHqNeOqNa0fg7lA2KE4JSx9o3d1CWYErJbdtaWvsUquYCElOCCCh4
        R89pbtZP+G0bY8M/Zg/Q74zEMzsXJZcxk7QS9HeP60ymTeneu1LaD21PzsEChXsA
        jYc751j74Sw0IBuVBxgvQWv2OrcSKKes4TmGC7JDUXB10NEi8S5SJdqWwCSqB3UL
        4i7GcrxQPrLZBAnEqJvyk59Vo7rPo8TpBiX5gW68jYtZWJWcyJLHT+4hgpkHmAZE
        xUnHOYhg2cYNfu2XrodgBLB/xn1RVhn52vtSSZWVhBMhPXokBE8NLEM1lp/JOwuO
        4Xc//f7LpK7seuAXrDjbjQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rGHNJ0qdTe_Q for <linux-ide@vger.kernel.org>;
        Wed, 28 Sep 2022 20:45:03 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MdK4Z6wQ3z1RvLy;
        Wed, 28 Sep 2022 20:45:02 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.0-rc7
Date:   Thu, 29 Sep 2022 12:45:01 +0900
Message-Id: <20220929034501.9700-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit a357f7b4583ebf81d19c95aef57497ae81c5f6=
3c:

  ata: libata: Set __ATA_BASE_SHT max_sectors (2022-08-21 01:29:50 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.0-rc7

for you to fetch changes up to 141f3d6256e58103ece1c3dd2835e871f1dde240:

  ata: libata-sata: Fix device queue depth control (2022-09-28 20:47:31 +=
0900)

----------------------------------------------------------------
ATA fixes for 6.0-rc7

Three late patches to fix problems discovered recently.

* Add a horkage to disable link power management by default for the
  Pioneer BDR-207M and BDR-205 DVD drives (from Niklas).

* 2 patches to fix setting the maximum queue depth of libsas owned ATA
  devices (from me).

----------------------------------------------------------------
Damien Le Moal (2):
      ata: libata-scsi: Fix initialization of device queue depth
      ata: libata-sata: Fix device queue depth control

Niklas Cassel (1):
      libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M and BDR-205

 drivers/ata/libata-core.c           |  4 ++++
 drivers/ata/libata-sata.c           | 24 ++++++++++++------------
 drivers/ata/libata-scsi.c           | 10 ++++------
 drivers/scsi/libsas/sas_scsi_host.c |  3 ++-
 include/linux/libata.h              |  4 ++--
 5 files changed, 24 insertions(+), 21 deletions(-)
