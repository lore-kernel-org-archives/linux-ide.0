Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF13C6379F
	for <linux-ide@archiver.kernel.org>; Fri, 13 Jan 2023 23:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjAMXXA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjAMXW7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jan 2023 18:22:59 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAB46084B
        for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2023 15:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673652178; x=1705188178;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BYFgUWeHBbIzi4d7XmJZC5BC0da4p8olD6Bi7qiu5pE=;
  b=N2xgBIzvGcZcwwZR26t3BofG6mG5XzzgTAIKE3QUPKL3C55tqXYINQ45
   NPi2B6DJXEwcsQM5ngfXhpLK4nHDBep/8mS0k69ja8+y/dblzCdzWSnyR
   VGcerHkRzyC8Iqc+VqV9vmXXOvvt+rbBMaO2BsLKUukzxnNAQNH8rHaTe
   7bv1Cmy66xzseN2ce+uUDHEFL8bSxeyLI8vzlt/E8BBi9bJfM1in0RZG+
   zXgSjO7u8KUkJPf00GpNlo6ZufnIV/thS8TXixZr840kvXZ29C4ArkdW/
   mBD+TT8XaylY4qB95yLJB5YraW2UULikAQN4B5fpQjGAhdeZii4e1yVGA
   w==;
X-IronPort-AV: E=Sophos;i="5.97,215,1669046400"; 
   d="scan'208";a="332773742"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2023 07:22:58 +0800
IronPort-SDR: 5ZvGu3YNcIJciUmS39PjlSP9GZKezzTNPW31wgi0Gcnjdhr3WKjAfwHg5Cmx7WEzsvU1mMheBk
 2nuW+RVqD8RFkfNnjRKPRuX8DBuEzUo5/hNnT9Qu369APcoiSgERMkMDbitlQmiAZAo4PToFqS
 b0PSaBBOsqV4k7gAIKrA8Oxn96YBR+aMvemvUL9Jf91FionJFG+l1QlJkfGqB6FieMkCLcQsZA
 NF3rwiSNlRibrHdDeCOFctWfBncBGL5NEXzbtv00P76ujJPvEQLlPk9i7sA+Tb4UcjVodvrugS
 xwI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2023 14:40:43 -0800
IronPort-SDR: hvsPiVB7joDiiSTbsDcL7lvIpgvM3Cmt71ky2cfMELKDp+wl8+mvaF9A79+NdqhRYmoUngHgAd
 OGt0K+iIkq4sLyP9BT0jV49YVWvauBpKRwcf3y4Xoh93zArP9vNOoDcoA4L7fsqs9Tld2xnMG3
 WNm7W6zFjI4/ivZ6XEnmrPBslOvJcp8L7B+cus8HAG1PzIPZlN33F9TG/HHAFo6oHKUgNmrv6C
 cL0/p/ipR6XvNdrLPevP1HnBhvFfp2rASsjQW6UkTfgH5OTZijccgLba2vPPnOrLRBmMIFV6Mg
 4Sk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2023 15:22:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NtyBp02qnz1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2023 15:22:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1673652177;
         x=1676244178; bh=BYFgUWeHBbIzi4d7XmJZC5BC0da4p8olD6Bi7qiu5pE=; b=
        LvYe+/pfqlF6PyD1Xf1Pn3O9wjGggcU4BouM2+StNqVl0d+y0LqYFglxXYy+1A5w
        AxpIx+C0UM+3O0w34TPx5GIFk5BwhZff9CE1oQFcoXTyDkjDC2GQ6hJZGU6olpLU
        htah0o/LLOpZysKHytMk+6yTur6gnlufJTuTX6bzE44FXyBxThKxDDZ6H4np4iwP
        IEwRCDWhw47u1nprtg/vMY9jogHEFBiY1+N0czFecjj/Uh5yucNYHgwOFE32dfKF
        LIBoyu9Xbcuitamctb8dvWrRsXIQVti3Dy8vPswU8o/xW45WGflRfvFhOB5/M+uG
        YrPlREYOUN35O8zHj71BpA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OjLDt_toTKVn for <linux-ide@vger.kernel.org>;
        Fri, 13 Jan 2023 15:22:57 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NtyBn1Zp7z1RvLy;
        Fri, 13 Jan 2023 15:22:56 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.2-rc4
Date:   Sat, 14 Jan 2023 08:22:55 +0900
Message-Id: <20230113232255.487691-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 37e14e4f3715428b809e4df9a9958baa64c77d=
51:

  ata: ahci: Fix PCS quirk application for suspend (2022-12-27 11:06:57 +=
0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.2-rc4

for you to fetch changes up to 22eebaa631c40f3dac169ba781e0de471b83bf45:

  ata: pata_cs5535: Don't build on UML (2023-01-14 07:38:48 +0900)

----------------------------------------------------------------
ATA fixes for 6.2-rc4

A single fix for rc4 to prevent building the pata_cs5535 driver with
user mode linux as it uses msr operations that are not defined with UML.

----------------------------------------------------------------
Peter Foley (1):
      ata: pata_cs5535: Don't build on UML

 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)
