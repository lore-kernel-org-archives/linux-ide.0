Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF53FC54EE9
	for <linux-ide@archiver.kernel.org>; Fri, 16 Sep 2022 12:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiIPM2x (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiIPM2s (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2022 08:28:48 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F08B1BBE
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663331323; x=1694867323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F+3yEhq0e6iXUsaf3DMA4YehJnt6KnSiSERKk0FRxmU=;
  b=eb74B+loUIvKfwVhON32Nh0a1c6z+dNQEfg0RKtUvkFHk0jD7sWdaNfd
   s3WoMXmXWLc6vH6Finmfd709Wn4QglQs2slH5WLKFhd9+0q9B8tu7B+Co
   rk9oyQ19T/1OzwcHOaWY4NEOu/AveJEjaHNbgVN1LRoursklUjVqWHjVc
   u0a6bqJbk9lVjF5cm4Y5WG3o4iwIS1A6jgrnMaCKGFHdSByxwwbR5M+Gh
   N0ZIoHR3rcGGIr6Tu997T+cVh+dGUq2CpSJ0Sk5CmM/CzfIiI31vrWpgh
   3EKzzfUmexYgMdb81yI1LgnvhL/lkl245fhBdOxPM9YZPvf7vRiWEHrME
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216701263"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 20:28:42 +0800
IronPort-SDR: qaS9rbD4WAH1/yXBIGWS3AkRvKtIa20oNSYaQrs5pT4YTgkliQcrhvIj38ie7MT1V0MFWlhf2b
 zpzD2IUKioufNLowB9Jl190wy4a/8Lug5ChPV9SQYZk9FfA49Wq+V6UCBmxlayCALXnYTfFLpk
 OgkMPF6TsmbG9HgocEg/CY+CE5ELoDGAmhhhbx9R3/XdpGbcqM5eScCYf757Gi6oBMWDhXbwDp
 SNXHnEn9g7285/2jBM4+wPv3skV4IqArvxNL4Br+z3sykpILbwGpvf9NbYnWBuNZBWAVI/1LhW
 C/kRH+7Prj3yDPH4o5eol7YO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 04:48:53 -0700
IronPort-SDR: jRmMt0dGYg067IeA34IUF69N0QRUW4MJURjAGiiNT7ewKXHxVF35Uf3E8jMB6PscZums60U3Tf
 rpsp0bM8j8kQwB5WYZVDCU6b0b8EhaCLPYbi0FBuMp6bjt5O/Pd21JUAKTeN+U+eDyGS1x7fm/
 SBux5S3m6+y6R7FY0aO74BIYxpHLenW80A7LvjMI3f4xd9B9wj0R190iYh72Y5ekWTDYc0QWfM
 LBPOJKJ4fGfzr0jg2AsojiAYV1pPbOhxMKbIPvuCI8VGeWq3HT2x7vHa2b7hk5pjoWrPZfKUl3
 hf0=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO x1-carbon.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2022 05:28:40 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Shane Huang <shane.huang@amd.com>,
        Jeff Garzik <jgarzik@redhat.com>,
        Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 0/6] IDENTIFY DEVICE supported bit fixes
Date:   Fri, 16 Sep 2022 14:28:31 +0200
Message-Id: <20220916122838.1190628-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello,

This series fixes some incorrect handling of the supported bits
in IDENTIFY DEVICE data.

As a bonus, there are two small cleanups which removes superfluous
parameters in libata-eh.c.


Kind regards,
Niklas

Niklas Cassel (6):
  ata: fix ata_id_sense_reporting_enabled() and
    ata_id_has_sense_reporting()
  ata: fix ata_id_has_devslp()
  ata: fix ata_id_has_ncq_autosense()
  ata: fix ata_id_has_dipm()
  ata: libata: drop superfluous ata_eh_request_sense() parameter
  ata: libata: drop superfluous ata_eh_analyze_tf() parameter

 drivers/ata/libata-eh.c | 14 ++++++--------
 include/linux/ata.h     | 39 +++++++++++++++++++++------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

-- 
2.37.3

