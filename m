Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99651C04A95
	for <linux-ide@archiver.kernel.org>; Sun, 25 Sep 2022 23:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiIYXIX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 25 Sep 2022 19:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYXIW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 25 Sep 2022 19:08:22 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60DA2982C
        for <linux-ide@vger.kernel.org>; Sun, 25 Sep 2022 16:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664147301; x=1695683301;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zGCSgfOMqVnazTIwSJyzepZefBWFgHkJ3WSZBt3xuTg=;
  b=pvNAj4j7MJ4JcomGQANZ8liiC1FgKO9q+hgS/vYvn2FEdLIMY3DSWDbO
   ZfHjs0BUuQoC8nppyslNKsfUMWI4h2fIVp8GkXE2EGCPJjkyqCbkg8dt4
   iKyWHoY1GIGCzooH29l1zHZGoPvRXMNuc7hPwzFcNeTtNkc6rtn/POXLI
   PQYVtNlQpLTJv0Zuv3YDYWvsUijhAUYPIT8tHPTjedHkBZCAtJFURNX1h
   v8qiMBbes6I24q7iMFx376QC8IgbvLD4UXmvTyOobbw7bIQUaTQ/vATQ0
   1OhAJ31KqmOtTzyX0otBuRoIv9A+lqMIN10fnLFIwQZhmiVBSUPXLoOML
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,345,1654531200"; 
   d="scan'208";a="217414819"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2022 07:08:21 +0800
IronPort-SDR: jxon9WZswall+vsAuv8KjX9j+2ldVyPXszDHPs29UdQm8+5o5ejoovZu+ApKO+M611SJwEcfK6
 iM1KTy7l37cJlD9e4jx55xTlJLqBMNIcqEKgjA35r3cXSry6G5bzIaDj43OHnJ5tTId+cbkqR0
 UGS9xeKxY+InxxhrVnzAD7YFJKoirEbOJdsqusVkYZcipv7ffVTcwRFPuFkJHZMLSfU4BktiHd
 ac5oxoJqfeHJ8gEkcW8RjWlh2HqGOVTw3tmFj16oRPL4RsPH1OT6w4U/51Xc5TNaNdbRMusFXm
 75IeWs6DM72G8Zaxy43FDSf/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2022 15:22:49 -0700
IronPort-SDR: DzHfeskcxwLtbGE+po4lghOgq6n4aEkIsrrWI9o5JkDOeq9Ya1QmJHjRzZ4yd7pZ4awHtPA0ft
 H9EMTNBAR3mo+zJHEJD4E4NPfUSTGPHRGBFuQNutnvwMp/x7CzsbXyXWm1XmFndBYj+GfY3tVu
 0VMx9U1S7wMkigEWcIAAaaS+6Y1Af9E4gcHNqc7ZaYqt8YtxTKfrc4YI0XAwCwRauh74D8Onta
 6h/8oPqb+8HFdTTXOd+S7MWJn+zlE9ENVneIeoUKMKpbWROTf+cXvcBbrOoO1C3RhyRo+Js2KN
 PDc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2022 16:08:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MbM4h5dqZz1Rwt8
        for <linux-ide@vger.kernel.org>; Sun, 25 Sep 2022 16:08:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1664147300;
         x=1666739301; bh=zGCSgfOMqVnazTIwSJyzepZefBWFgHkJ3WSZBt3xuTg=; b=
        EdcYkwNpsxYWT2785OxI9ESxEzthUunhrbN/wKSYWHbd/s/rVbJkcKSR34x8DZTj
        XvqH7NtY90SBZA8e395RjaOG2LuPwSeo59U55nHz1JXo27P9Hzt0yzH9Nz3PJ2SR
        U1mabNu7cJCNeoBxdrMMCIKs3WbGL6a7iZdO5Le8rMcw5mcHRVGpSjoifER/eYbT
        JTcXFlESm0lKMCf5AakXEJSSNWVdPu4RlryqjRYlJSbEN+A1R1bn8sr6SQWlQnlg
        MYl2viQgpuHRTOlMMpLEpClSHDvy0ewR/JNim4fi70iRpG6DWZCdD+5RER9tikuW
        +AYksIPQTAnRNnDsEwsoEw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kuwTvkO4tkkf for <linux-ide@vger.kernel.org>;
        Sun, 25 Sep 2022 16:08:20 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MbM4g4G6lz1RvLy;
        Sun, 25 Sep 2022 16:08:19 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/2] Fixes for ATA device queue depth control
Date:   Mon, 26 Sep 2022 08:08:15 +0900
Message-Id: <20220925230817.91542-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

A couple of patches to fix maximum queue depth initialization and
control for ATA devices used through libsas.

Changes from v1:
* Addressed Sergey comments: fixed typos in patch 2 commit message and
  removed a temporary pr_info() debug call.

Damien Le Moal (2):
  ata: libata-scsi: Fix initialization of device queue depth
  ata: libata-sata: Fix device queue depth control

 drivers/ata/libata-sata.c           | 24 ++++++++++++------------
 drivers/ata/libata-scsi.c           | 10 ++++------
 drivers/scsi/libsas/sas_scsi_host.c |  3 ++-
 include/linux/libata.h              |  4 ++--
 4 files changed, 20 insertions(+), 21 deletions(-)

--=20
2.37.3

