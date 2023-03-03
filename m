Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90ADC7EE2F
	for <linux-ide@archiver.kernel.org>; Fri,  3 Mar 2023 09:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCCJqX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Mar 2023 04:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCCJqW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2023 04:46:22 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FDDB770
        for <linux-ide@vger.kernel.org>; Fri,  3 Mar 2023 01:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677836781; x=1709372781;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eDESkMJgWAkm9u1GcMPdFL1e/0jAJx9QPHSNHFenXfo=;
  b=IjPG4YCHwrxOMLzaEKnGM2wsIPUl3wP9uMbcM67KEPkLVU8Hvu+L1cTz
   oZyGv4/m2EKhk9ivKMOyqN5ZVQojH0MwK29GemHo6SzhPczI9lx1+H7fX
   hEZA4auZ9jDlsRkbxKUCd92UrMHBAkYoAaQJnLBFANdKTpEOtbiiHKKD5
   AopWo2JFIlwZB+nGxOkdFLzeYBPn9v2SW0p4RVit64YmnA6cKaXTM2ZS0
   XSwPQaWwwbmwZq/jU6gS8/kEcTew5/20/EgWnRmDSj69GSsulNmd3Imui
   uxCg26qtuwL71AIx6gBOaUI+6pQYKZWHG9uzUxQ1/U4ObpyQCKJZ9lBFq
   w==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673884800"; 
   d="scan'208";a="336699153"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2023 17:46:21 +0800
IronPort-SDR: WNbHWVPKUH++vzb+pJ4MD3KlIunRUahVyy3fGWR/XImlNAxf7ZGasT7iK0bj5BY2J0PG3hjkGn
 6ALfMt6jI1iFP9EaZEF0vWN3tOQ5Uj7f7ae0Y7xZKQ6h2YIhdOgtnGS3xC1soEPyeFiHqvHAcW
 MCiriBgQrt4l5wGVQncijrnK/xVta96ENI0FAT6c71kVRA4CelZnzDW+Xhc8+iXhwPZpBeR3O/
 m2Dy/9w4Ny0hQnFyEaywBhncjsjtXRDpNVv4OPv5zTPl+76bmB1f4rRAnQBuu7INbn7JQV185m
 VUw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2023 00:57:23 -0800
IronPort-SDR: bnXLWo7qL2m4p0r1s1paXXZJA1lqfqZZ8L4vYNLyWgPUSyu4WEhbrENtTfKUYpdc6Ah4xSZQbo
 0QaqoXS6D2w6AUsaFjqKrb0gKE2Tx4pSLui2YZFqOEU8lqUMfxbuKzLUDZV71Yb2WjFLUUMgCm
 Za1aKXlSyXfSgVNTkQgzm9yEiuyDLqHvMs0SExhIG02xGjnP1ju2m5AowfNep9ML/Fbcm6mtWT
 5S5iOUQdHrYExuw78+kWmxsmwzGysI+99xpHPInFzzicayspaOSeNejpf0Ll4qgB6dGbAHPNeS
 kGM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2023 01:46:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PSjlw658gz1RvTr
        for <linux-ide@vger.kernel.org>; Fri,  3 Mar 2023 01:46:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1677836780;
         x=1680428781; bh=eDESkMJgWAkm9u1GcMPdFL1e/0jAJx9QPHSNHFenXfo=; b=
        Uea/w/YJGPLFdMBjmArid99K7d8awMCctQ+Kg84N92I1TfG/cL4WJlihie8mtUV/
        yp3PSZL1ua82a4Vs43jJamYiBLqRwOszGCBXdkjvWnbKcI2shdvwpajTQw408f7K
        Y2+40APMpTgbIDbVNGvg0QxfD/rw3ka6cufkZIIMceFlkFh6uk+Z5kzYZEzHu7LS
        zYqrI150tsv+dkVEopnHjd+YoBgcqMA0vJeglr7nKfkVhZ5BAHTCGSfVjHvOlwJ6
        s9y0zwlv1WowZUGzQ8PbVOZKJWMLcA+0GFG/2yeb9PUDiLtXi+XFdpdn9GofEQxq
        9zpk7DFKv/ViX4B5YwkiXg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RXw6BY52tlw2 for <linux-ide@vger.kernel.org>;
        Fri,  3 Mar 2023 01:46:20 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PSjlv6nnrz1RvLy;
        Fri,  3 Mar 2023 01:46:19 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.3-fix
Date:   Fri,  3 Mar 2023 18:46:18 +0900
Message-Id: <20230303094618.396676-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

An urgent fix to revert a patch added in 6.2-rc8 and causing regressions.

The following changes since commit 2eb29d59ddf02e39774abfb60b2030b0b7e27c=
1f:

  Merge tag 'drm-next-2023-03-03-1' of git://anongit.freedesktop.org/drm/=
drm (2023-03-02 15:08:54 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.3-fix

for you to fetch changes up to 6210038aeaf49c395c2da57572246d93ec67f6d4:

  ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller" (=
2023-03-03 18:43:02 +0900)

----------------------------------------------------------------
ATA fix for 6.3-rc1

 * Revert commit 104ff59af73a ("ata: ahci: Add Tiger Lake UP{3,4} AHCI
   controller") as it is causing serious regressions (failure to boot)
   on some laptops.

----------------------------------------------------------------
Damien Le Moal (1):
      ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI controlle=
r"

 drivers/ata/ahci.c | 1 -
 1 file changed, 1 deletion(-)
