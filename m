Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B6EC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 08:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbiCWIUy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiCWIUx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 04:20:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684AE5E766
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648023561; x=1679559561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AJOu2ZAwgFYNeqqJ4JySfEEq1KcnDaKxJ0/Ya3qP1To=;
  b=HIXKXl7KTd3NaudCBiHJrh4m3LOHokKzpr5vovHaAlZcO0d3xmXdXN2g
   sboVVqcomEJEVlKlpnUgYLWCE4jh3Y1zU1szGVdjZdZm5gUFlJKnUZ2eT
   vcxTs82LaTRVv+IOKU3NFPWloUUPUeywFppXwM6SpSVDCdnvkbD1Ykrlj
   dDqZb4brJCZfwoCC6dDIvnHf0la1DZkEg/A0tb4xjD9B2Qd4pUPYlhGfH
   Us3ccoQl/ZAQtKDoB+pgMvf1X8b/ANh3Ztocu/PFRQLwIiccxkrAXidaP
   J5k1W3lXoeeJHfu3711hxJWjj026lFufzTwrSKXd4+KUZRZoUBA99pygY
   w==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="196047604"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 16:19:21 +0800
IronPort-SDR: 7iOAC3UTinxAiBSM73gPhgRWDJdFA3OJOc7PkY7uelQVwbvTIlz3kXQ5Dl9d5hHcgAq1Qp+fYB
 cgcAxtYTSQM9llLBVlwjupDixX2KAuc7DyfCr/MG+8+KQU/enAaZx+LuYbpgss4ezag2gbL/M5
 qmiqksgJ9qiPDLkAT/DUXHCPTBvtCpZt3U/CzASPFxz7VMcwbwgx/y1Ag215uMowoby8G6nGYZ
 pZt8p4zx4vKvENOLVZgFStmooWl9ELhz+D9+Al52zeL98AM57wRFAhotQOuWqRPzpMTekRbiR7
 RRFQV70PnAlfEbttkdznJBqK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:51:16 -0700
IronPort-SDR: Iojw27lIdsXkqDpA/yiiHw/hhuoaBNUt2WRZii992iNm24HJWXrpkXdUs7VVlwm/Fo58nDqWAS
 EcHa3PvF7tZY44JzE2qdTdmZYKAIj4G4CwWEbSreNIm4tvxn2mbdJIKNPVW8WXjk84Apg1tBfU
 wavKUPV1PTYwej97T8bEt5BjXlzY2vS5PFb6Rwk1KsaD0gphxLCLeKPxOf3LFrMr5ulziAG6vm
 KEVcaxV7MvGVZi29Wbcc5dLxbLFGB4uKwEhatxRDpv+xO12X3cU5QLw2pdURGk1bPQTmwULBXN
 3bk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:19:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNh8p3yRCz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:19:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1648023562;
         x=1650615563; bh=AJOu2ZAwgFYNeqqJ4JySfEEq1KcnDaKxJ0/Ya3qP1To=; b=
        JqE+/GTJTIcsE9Lppsb2m1sf+1ewQCwilOoO767LgHOZUj6TwpACAuYTL5tBULZU
        unt4MZvqm10czZEzVyWSSEwhjKTj3OI2tXrsllk2m2wo2DmnaLHxp5hEKIDN+T6+
        p0YPGA1TIGyV2EuSK4vV+kl90iYr+llTanDNfpTJyvT5RZO+FusBf7nzZY/WPrmk
        /AttGeUfFqyfEb5Lz95FaFxAxCXMBEdFlLyL1zWGgaMsnJccc0Rvqimu3sDr20uG
        iEZIOeiIc/Tc6hVIjW+aufoS502l+ESjiiz2Kty6jLZkv9xkPNjbD9xCeeeNQQ+g
        3tSvRKHvpGgXxw0aVPqc8w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sRQl3D13eDxI for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 01:19:22 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNh8n5VSPz1Rvlx;
        Wed, 23 Mar 2022 01:19:21 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 0/4] Remove link debounce delays by default
Date:   Wed, 23 Mar 2022 17:17:36 +0900
Message-Id: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This series removes the long link debounce delays by default for all
adapters, except for those known to require these delays
(e.g. ata_piix).

The first 2 patches are code cleanup improving the interface of several
functions handling delays.

Patch 3 removes the long delay in sata_link_resume() and reverses the
link flag ATA_LFLAG_NO_DEBOUNCE_DELAY to ATA_LFLAG_DEBOUNCE_DELAY for
adapters to request the delay if needed.

Patch 4 improves sata_link_debounce() by shortening the link stability
test, unless the link has the ATA_LFLAG_DEBOUNCE_DELAY flag set.

This series was tested on a machine with 2 AHCI adapters (Intel and
Marvell) with a port-multiplier box attached to cover that case too.

Comments and lots of testing are welcome !

Damien Le Moal (4):
  ata: libata-sata: Simplify sata_link_resume() interface
  ata: libata-sata: Introduce struct sata_deb_timing
  ata: libata-sata: Remove debounce delay by default
  ata: libata-sata: Improve sata_link_debounce()

 drivers/ata/ahci.c          |  19 ++----
 drivers/ata/ahci_brcm.c     |   1 -
 drivers/ata/ahci_qoriq.c    |   5 +-
 drivers/ata/ahci_xgene.c    |   3 +-
 drivers/ata/ata_generic.c   |   1 +
 drivers/ata/ata_piix.c      |  17 +++++
 drivers/ata/libahci.c       |   5 +-
 drivers/ata/libata-core.c   |   8 +--
 drivers/ata/libata-pmp.c    |   2 +-
 drivers/ata/libata-sata.c   | 129 +++++++++++++++++++++++++-----------
 drivers/ata/libata-sff.c    |   6 +-
 drivers/ata/sata_highbank.c |   4 +-
 drivers/ata/sata_inic162x.c |   3 +-
 drivers/ata/sata_mv.c       |   8 +--
 drivers/ata/sata_nv.c       |   5 +-
 drivers/ata/sata_sil24.c    |   2 +-
 include/linux/libata.h      |  44 +++++++-----
 17 files changed, 161 insertions(+), 101 deletions(-)

--=20
2.35.1

