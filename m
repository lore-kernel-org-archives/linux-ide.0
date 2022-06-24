Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06361C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 24 Jun 2022 02:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiFXCN0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Jun 2022 22:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFXCN0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jun 2022 22:13:26 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8871B7BC
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 19:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656036804; x=1687572804;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ArN5SHTjWklwRKiNX3x7aY2cC4LdkQz2mF6n3A/gq0g=;
  b=r3bI7/cLodGjoNzpZg6IsIlhAqXZC4bMsFPuYpK5/XY84PrjLWBO6epw
   3dblUKubzbK23jPD6+65BeXNLna/zbWJW7PahYNCYpKI8fCAs8QnAIOc/
   pSfPQ4Zm5GeFtPd7XDvfSvpF5g1IHI8R3YcMahALiqhdlIW4o249Jz62T
   k7Dv83nhxW28ElaAq9YyrRKBC7x2t04Y+Snt4+t6jWWrOYTW+CoVdEbEB
   cJqXsDlNJdeazA9lQuCPH3AwowuJVm5R/7IHOzx7QIgy/zGc7EjIIaWTJ
   LzD5nKYRMlLBBsrqE8PdPBSJpwgYQYQ7mc2S3MlFtUAG4kToN2MvBc7St
   w==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="316080298"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 10:13:24 +0800
IronPort-SDR: ZvrYywWV870b3dbOBF0Ns2TdPDE7kt9zkqgDW/xzwKtB/yzK2PpUW9ZMyV30kWlC8qS4/K+hwt
 dLPWsnvk/OYoqj3w/DrS0TjWsyKn2z2jmcSawuYDEvb+9df4DSYZzw/RwUS1OIkQZdf4Q/oJ5A
 kKbfsOwR0eRHnNoN0O0jg1ptIxlHCSoLTeWQiCja2pMrSVzWjIveuRgGNc5wpsx+S49YACDBET
 mle4CnNaZRGyHydGkVMHKTAO9eAGjeMFyXqBXYPNBdM583JW7gk8i6rSAItNtY6SZAsKuK1sHc
 MrSESlFBD1EFWktQn3hbz7Jr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 18:31:09 -0700
IronPort-SDR: nIfxXf/MAhfYCTqR4nVY0Zq0ZxeuEIO4OShOH8OBGj19ySpgoC+ZlEBgfvzYqDSGA96PVCUeX7
 InQX3IZAX6uGhNdNu4jQIvskYuo3NHVGwhl6UNSBbgnpGAbeTjnNkfVzrMHJ6daLKOfuLxDYOD
 iCbcEPuQVigDbBRx2HgXnrx9OeU6G9OFKChtkGnTJWyWjH5IgpHqCZ3YWLycI9OS2SuyNIQbr/
 X+hNY6kddqv2ZvZnCRoPxtp5YPca9h+uSp/anpgXSp+Tsjp4M+7yakHUo4nGo7Tjl8HJjBCzUr
 vhw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 19:13:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTgdb4FThz1Rwnl
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 19:13:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1656036803;
         x=1658628804; bh=ArN5SHTjWklwRKiNX3x7aY2cC4LdkQz2mF6n3A/gq0g=; b=
        jFCRxjZLRcaeHHXK1cbNcn1qeIhhgKV0sQthUlWoUtEtxWy2DnNwgTzUWJKR1W+O
        BRpF+apc3zOmyrG1mgVNG7HC8dcAAZgoYtEjJIxHekX/DcJWF0ETzM/av2m6RYVq
        SSMmiSH2tBJ2Tz1yv0cCpkZVMSAR7IVHUr7ewhIAMdtKvAN2e4mHCCH4kjXva5Cv
        pnKMim8ELlgq5Os5vvDq4MShzy1IQolQaA1B3Wn0DDPcz9WW7Qu1H7rPwdZa2Nqu
        tWdJi/vC4a+AkZl/YH2bn/oBMcndJkYx2XnCTZD5Qdgx4yAhO+LaTigUKW4wsvKz
        S5aAF2DCdJLUQnoOtqT5qQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sg5wnYQny58S for <linux-ide@vger.kernel.org>;
        Thu, 23 Jun 2022 19:13:23 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTgdZ3lmYz1RtVk;
        Thu, 23 Jun 2022 19:13:22 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 5.19-rc4
Date:   Fri, 24 Jun 2022 11:13:20 +0900
Message-Id: <20220624021320.3081-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 481f7017c37a8c722a0b09985db1a35f15749d=
5d:

  MAINTAINERS: add ATA sysfs file documentation to libata entry (2022-06-=
09 09:25:38 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.19-rc4

for you to fetch changes up to 540a92bfe6dab7310b9df2e488ba247d784d0163:

  ata: libata: add qc->flags in ata_qc_complete_template tracepoint (2022=
-06-17 16:30:03 +0900)

----------------------------------------------------------------
ATA fixes for 5.19-rc4

Only a single patch in this pull request, to fix tracing of command
completion. From Edward.

----------------------------------------------------------------
Edward Wu (1):
      ata: libata: add qc->flags in ata_qc_complete_template tracepoint

 include/trace/events/libata.h | 1 +
 1 file changed, 1 insertion(+)
