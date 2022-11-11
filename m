Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93A0C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 11 Nov 2022 11:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiKKLJ1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 06:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiKKLJ0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 06:09:26 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E106584D
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 03:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668164965; x=1699700965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jKz+qs9LVmGLX2N8AUFObismJsVtuwPvp+aNl3dRnU8=;
  b=cxz2qu83onv5kKfJVNPaZd7mW4yiFXAB+zoYqRMmf/0zXG3F74fYRNky
   e9avo5u3KrXoCCGcBuu1HLnhiHZ7CUqk9pGeNCJLnkuNS+lKdcaHwpyIt
   KOUBLv5HGmxx7u25R20qTdRH6X2pM0ZilOPHtBiy7dBbdxSCvlzpV6bA6
   KXwJqB1qeLPQNsP6ceOCcjqq2ccMCKZePQK8T5r+WHpFfRTqjUua+8lMD
   /r08n53w4IGu+OQvC+Fqu/6FiCcErdcxmBr77Cz25AKs1lCp64oEmHf4Y
   WCN6mqNJV08EaorEwgcs4PYhzyvENkoBnBsG4kpzN3BAQkKzJiPReeUnI
   g==;
X-IronPort-AV: E=Sophos;i="5.96,156,1665417600"; 
   d="scan'208";a="320384063"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2022 19:09:24 +0800
IronPort-SDR: adqXKOf3ER+QsfPebfOn036iIGDzAcvcs9proOK4PD5keMRryoBJEPDwKEFaWnt+0ik5CuBOEp
 xTy6oRg9Q4UsSj+snmeIXoZKZzZp4fJTaYYZxdSbpZxvkXIw8pRTQWiU2ytf2HAK5m+EpOnR5j
 h98VNkppYiVeHEMCiRCrAFDrh8vvVQje4t9sP5cr9GNkZ/pAjtvR6Q9vTo1cVjkGrneBut0E4g
 ngjRpWYbzFWx7eUy67rcAG9cwmX348MkHweySg4Da2yxw/UgfBBIkz8drZvLjA9G8sv6Ue4/2u
 JFw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 02:22:42 -0800
IronPort-SDR: NztHViRWxWXnhKf9gJKKGTsNettlB8eUg//4TenhFo/zbe1AkXFgpCXP5TS+Qcf/mmG/78Al4o
 CEv0XpoZnHlNbnkM34/XT+diU/ZvAzLQ86QWO8IG69JgSnv3X02EKRNTMVhXYSEKPszxtNpZ0Y
 7oWJYsDbmDOcKFGp+LZooEHzQDvtXrqeSQJgoQQef1/nK3QDDh1GDB2bVqJKjrY+d4EiEXEKKf
 x9HvWz/aD+/2/pzk6ULb6gjyVmnJjySSBqvMakJLAGOSxXRAmAAYaDhQw4BaDB89/XnRToNrtJ
 0iY=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.31])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2022 03:09:24 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH 0/2] libata NCQ error handling fix and improvement
Date:   Fri, 11 Nov 2022 12:09:18 +0100
Message-Id: <20221111110921.1273193-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello there,

The first patch fixes an error where non-offending commands during an
NCQ error might not get retried.

The second patch skips the error analysis for non-offending commands
during an NCQ error completely. The command that caused the NCQ command
will still get further analysis, so this single QC will still inherit
link level errors, if e.g. SError signaled a BUS error at the same time
as the IRQ signaled a NCQ error.


Kind regards,
Niklas

Niklas Cassel (2):
  ata: libata: only mark a single command as error during a NCQ error
  ata: libata: skip error analysis for commands that are not errors

 drivers/ata/libata-eh.c   |  1 +
 drivers/ata/libata-sata.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

-- 
2.38.1

