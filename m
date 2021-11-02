Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7BFC433EF
	for <linux-ide@archiver.kernel.org>; Tue,  2 Nov 2021 06:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C3860F56
	for <linux-ide@archiver.kernel.org>; Tue,  2 Nov 2021 06:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhKBGLH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Nov 2021 02:11:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41865 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBGLH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2021 02:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635833312; x=1667369312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qJpJF/TxyG0V2ISxu1gyz0aihYXY7N2evDEfs9DNiko=;
  b=N5o7VO0VqtLGaBIu5XGXlGeSWVZzeAI0PO3n8iT/ZOA7R5aSw1GFPPWP
   Xx/mWU4Xp6S3opcfUZuNi/ABlTPjEyLDdKSYbiwK1+DM/pFeVY7b4sJk8
   cBbLv8qX0Wwj/6g/wECNPO+fJolzwI0TxGAXe8F7UEAs4vPCDWP8mT4xs
   neAdQOiIHXY9b5eafNztR86Cj3u79KppFR9V9c0SMLMsY0+7mMhqebSK5
   gqi9pr57hDmzyBA96fceQ6hC5XgZABoKZAHiEHIbIwI72vaEOw7mbWBqP
   3JurH9GRcrOENx40j43X+5RlQtyApQyz8ra8zmnaJGbtllpuIjMFvrUaZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,201,1631548800"; 
   d="scan'208";a="189249732"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2021 14:08:32 +0800
IronPort-SDR: 0eKgS39kDf58P5mRiP4u9t0aqLlei6Y4pHedgLmwLWkTFEluenpyuS1jgB8dSJ6VD1b/7n1KKh
 MJ+MqxZ9KunpetuZGXwtN2loVcxsDC0LIRgTS/ePAsiRE+MePPrY+aotwwUHc5bIB8PXNEjEs3
 akMQFerhpptPw6cnGU8BWoZl/pzy5lWOd7w4rCD+YOQyTSL6zl5/eFyfAC30NEq5IhHkIBgSHR
 ZtZuXj8Ez91rNqL6r8K+nipKIFPMQPN3bDpn5qSt5QISDm6hyi0moAOe5cpieSsKcSlgio9wGW
 56CZlStQhVHq2G98ki2l6BcS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 22:43:54 -0700
IronPort-SDR: fcILeXKDmaQ2t4eR4F6FnQwvoY6bDYKCjsDj06lw1h4i1diV6Fee2LwfIrWtJIVeCXzmWiqlJJ
 Dt39VDtjqASthaPe9DxEclShNNCmu4cxuCPIwejOgjt2V9dXveYfe9RqFwN6wnneoWZnA7l2qm
 qBHCIIsE59UK6UlR9DuRftMpEaBAcwGVJqfjLW11lStDL+lN2fLFX5iXDmXc+EkMwDRnwMyNiP
 FpPxa+nnrgQrsX8w3mwETtmTBFq8T0ZDSxsCheuIGZKBv3pBQ4bu+hbQPcQG7soVoNbw6J71Di
 msA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 23:08:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hjzww386cz1RtVm
        for <linux-ide@vger.kernel.org>; Mon,  1 Nov 2021 23:08:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :mime-version:x-mailer:message-id:date:subject:to:from; s=dkim;
         t=1635833312; x=1638425313; bh=qJpJF/TxyG0V2ISxu1gyz0aihYXY7N2e
        vDEfs9DNiko=; b=SXrYfgJaPSHwykoKaySPmH9kp61YIRPdKjHdvg5H9VLyhlEP
        c1m+Bw/bUpXMCLgk8zKrjQSIPwqKzlW6rWKjmTCdo1BhlGiyIL2PFbEBUinA4Lsg
        atV56P5HPffQSaGYYmdDPqwrKp9EVbY5Ev1KrmmJ/RqX7UMkURa+Ki02v/S4LTUR
        dZIqPCLgsWm8QQBG3PCGKS/TT/iy+2Ux6NCEkfpbA2QA5lqL9uKuGz8drT+PCZVM
        iM1V2ZkQWOvy0e8Pi9znuKQEMnT8/wWeIe3ggXyvHeG8w9agD4yi2iUjznh/QeLQ
        P5vqYnMH5ROT1StfE3IozsHqO0lcUcvxL52JyA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qcibOuFO23Ht for <linux-ide@vger.kernel.org>;
        Mon,  1 Nov 2021 23:08:32 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hjzwv495qz1RtVl;
        Mon,  1 Nov 2021 23:08:31 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ide@vger.kernel.org
Subject: [GIT PULL] libata changes for 5.16-rc1
Date:   Tue,  2 Nov 2021 15:08:29 +0900
Message-Id: <20211102060829.78453-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da=
82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/libata-5.16-rc1

for you to fetch changes up to 1af5f7af2484004e71d384d8b88c221fc62cd6b5:

  pata_radisys: fix checking of DMA state (2021-10-12 17:47:02 +0900)

----------------------------------------------------------------
libata changes for 5.16

Changes in libata for 5.16 include the following:
* Remove duplicated AHCI adapter PCI device IDs (from Krzysztof)
* Cleanup of device DMA state checking to consistantly use
  ata_dma_enabled() (from Reimar)

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

----------------------------------------------------------------
Istv=C3=A1n Pongr=C3=A1cz (1):
      Add AHCI support for ASM1062+JBM575 cards

Krzysztof Kozlowski (1):
      ahci: remove duplicated PCI device IDs

Reimar D=C3=B6ffinger (6):
      libata: fix checking of DMA state
      libata-scsi: fix checking of DMA state
      pata_ali: fix checking of DMA state
      pata_amd: fix checking of DMA state
      pata_optidma: fix checking of DMA state
      pata_radisys: fix checking of DMA state

 drivers/ata/ahci.c         | 13 +++++--------
 drivers/ata/libata-core.c  |  2 +-
 drivers/ata/libata-scsi.c  |  4 ++--
 drivers/ata/pata_ali.c     |  4 ++--
 drivers/ata/pata_amd.c     |  2 +-
 drivers/ata/pata_optidma.c |  4 ++--
 drivers/ata/pata_radisys.c |  4 ++--
 7 files changed, 15 insertions(+), 18 deletions(-)
