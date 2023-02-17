Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A264C636D4
	for <linux-ide@archiver.kernel.org>; Fri, 17 Feb 2023 10:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBQKlo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Feb 2023 05:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBQKln (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2023 05:41:43 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB6D5CF1B
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2023 02:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676630502; x=1708166502;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZtSU9IeEd1lGEJQA5fnbXiMgtNSuXDD25OPONVBMrso=;
  b=Y56pvYH4oAcrmxhWUVLgFYGLZWcM+du71HZiQoZbarSJUAlrmSE5XbQM
   +u8Efy13jh3zIuQOrVI7MRiI/+2GAVNTcW532VrcRak8q9ZKYFVwEV6W6
   bDK+dRHSBVNZFaf6MLHtTOFumxoaFQxwBksYJ44uQOSzHICdgH85ONHqZ
   Xs/g3Jbqc08bpQveK/1ng2AFMCmA+VUno++IP4LjPemJbUkCqy9RhhidO
   sEIJeyPY3qkpmsX/PHITs+tFegeDFcL+yj9S8S8WRZpPfKwPUEpY6J628
   0drN7ZO+BoVpn7bPMfnukPg80wAEuSe7frvBOuE86oexEJz+iY5E71007
   g==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669046400"; 
   d="scan'208";a="335531991"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2023 18:41:41 +0800
IronPort-SDR: YT8WAbIDqCW+Dr8sz36dxRaghlLPAVnw4NVbB/z2NMwyBmh7Xv6FMsJOBIFRYBoqTrJkLkyCvJ
 j6NV3oU3CerG73Q1FW0oZMkwmxc0RVwa7cziZBa/6UyBNg7O7HZD/R5krx4RORsGlqaK9IP1yL
 gONT9ZbwdU5kvzQ1K2kx44jQY60WSZVDxfg7lBxSUN01AGE36WPBin42d99I133G77IAjgZw6j
 vioN/heK8oV9c5SAYIV+knrHWDXqgc8YJoVwYSLxfyivFKgorMk+4yvsF1cQXndbVa3x+LnaEt
 dCc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Feb 2023 01:58:45 -0800
IronPort-SDR: lOQAgAEcsAeKIaEjn9kViddMLbWIfO9lonWB7PbTSYWGTmIgo5fkX2iPRe92VSgQ/FphfimuEL
 6lqFC5oCugqXYmKBeWo9HMmWOkN8UFLNcqiP7S1LGD/nTTr+9NezqNdf6XJ1lyytl2vf6uJ3ZI
 8mZxudydvbNu8+FgkWeONDogqAIA4AOFgYGq0uG8U28Hn/eV2WEQD8WM0TK7f340dWk6QWMWEt
 w6rVg8pFgVal2NCI8iY5w6Qiy2KD00JiNVgP4oiE50lIlt/Rh+/FWIiMs2QYsDRWUEPYE9LtIZ
 vLU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Feb 2023 02:41:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PJ7fF2gQTz1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2023 02:41:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1676630501;
         x=1679222502; bh=ZtSU9IeEd1lGEJQA5fnbXiMgtNSuXDD25OPONVBMrso=; b=
        Af1B0IQU8AeM23uRfJ/aiqLqhp4Q/DdZSEhQj3mzjCeh6rFESaTc928dvmYNWI4B
        H2Cee1W+KpTCHZu2sF5ZmtALF7WAlVsm3OGf37czOWQh89js0A7dYZ8Gg09c0QTn
        2KQzmFyCJmVLYR4pSsZMLeK3ebqIoPPL+u/4sfhzSS8Fmufosl50z9EbxgFONC/X
        4nT++HQ778DE9HKiFe3a1UAavJLnTHjPneVplChIDTX0v8XzR/lckNaFZloD2tjj
        vILqjmw6Fl6GW9b57aLRMNR1WUltsPtJdvCjQbmVLEcRzN4jeUmgYd9TuHGpgc0y
        mst4SezB/+cf1WisX0QHjg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hw1Z-iKajDlA for <linux-ide@vger.kernel.org>;
        Fri, 17 Feb 2023 02:41:41 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PJ7fD4PbJz1RvLy;
        Fri, 17 Feb 2023 02:41:40 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.2-rc8
Date:   Fri, 17 Feb 2023 19:41:39 +0900
Message-Id: <20230217104139.789424-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 69f2c9346313ba3d3dfa4091ff99df26c67c90=
21:

  ata: libata: Fix sata_down_spd_limit() when no link speed is reported (=
2023-02-02 20:26:45 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.2-rc8

for you to fetch changes up to 1aff53b2fd903b300dfd71af0064c21fbca313c6:

  ata: pata_octeon_cf: drop kernel-doc notation (2023-02-14 12:23:37 +090=
0)

----------------------------------------------------------------
ata fixes for 6.2-rc8

Three small fixes for 6.2 final:

  * Disable READ LOG DMA EXT for Samsung MZ7LH drives as these drives
    choke on that command, from Patrick.

  * Add Intel Tiger Lake UP{3,4} to the list of supported AHCI
    controllers (this is not technically a bug fix, but it is trivial
    enough that I add it here), from SImon.

  * Fix code comments in the pata_octeon_cf driver as incorrect
    formatting was causing warnings from kernel-doc, from Randy.

----------------------------------------------------------------
Patrick McLean (1):
      ata: libata-core: Disable READ LOG DMA EXT for Samsung MZ7LH

Randy Dunlap (1):
      ata: pata_octeon_cf: drop kernel-doc notation

Simon Gaiser (1):
      ata: ahci: Add Tiger Lake UP{3,4} AHCI controller

 drivers/ata/ahci.c           |  1 +
 drivers/ata/libata-core.c    |  3 +++
 drivers/ata/pata_octeon_cf.c | 16 ++++++++--------
 3 files changed, 12 insertions(+), 8 deletions(-)
