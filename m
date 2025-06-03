Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D54AD23
	for <linux-ide@vger.kernel.org>; Tue,  3 Jun 2025 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748930915; cv=none; b=GvxiZHjPFGwwhMcTlagcqFnJrWZxoCXeqXnHh/j0a9juOQsbJ6ngdCigu/c2+FE1QcJLYDufepTuIiGxiaE2qHsHg3adVC/3Nte3UB96kLuYFHqkQfQN9MsaTpoIuR89E3l1x+uhiIPlY6ULbgMeyZ5oQHrUfuJ0ei9OMeNV8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748930915; c=relaxed/simple;
	bh=BTrp92hnli8BrUuqdP/heT0B7UWZQ/ABxxrcwJgCSIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hXzkfeXcYmekD110vFJzLpZc/NMbKsHuCrzSUjQ2QS6ZWoK67avJtyv4Ue1XZCESp6Sbn1UIK2qGJAqmmoxyY/SPKf9puYQabOGSLfa3uZyCqvfi04tkYqZqUwY8ECPXLM4lBcnZxI+RU+YtnNnNogGBDeEb283aqbN7m2MgEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQOfA76V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQOfA76V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37383C4CEED;
	Tue,  3 Jun 2025 06:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748930914;
	bh=BTrp92hnli8BrUuqdP/heT0B7UWZQ/ABxxrcwJgCSIE=;
	h=From:To:Cc:Subject:Date:From;
	b=MQOfA76V0z5+ThHxSqlpM0HTW3eg2SBIhoUpE2HwMRLQz7nn1m66HTfwlRDf/nVc/
	 xpMIf6Kq5NbKUmaYdoZMRQhfUEcX9qAM0YzWWCCARG28yrnmrYraI984xvpj0+ZfAm
	 aukrHqa5LZfu/bHD0sdjMN35WvI7BKAQpsDj4J7y2a+2EkWU5ECOTg73pEORIL8ghe
	 ErwlnlCNoxpmDvwwR0za4i9mfJn0Trh7HDDX6siCDIlvnRLvCdkTwASaapOM+qOTsT
	 mvNC4PkYcF6jfuZtluJ/nwU8mWtYVkvhgImxPm5MyyQLKTLUkz/8VCy3ynEVa4RD10
	 hDZIn/DdiXWFQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.16-rc1
Date: Tue,  3 Jun 2025 15:06:58 +0900
Message-ID: <20250603060658.171254-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 9d7a0577c9db35c4cc52db90bc415ea248446472:

  gcc-15: disable '-Wunterminated-string-initialization' entirely for now (2025-04-20 15:30:53 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.16-rc1

for you to fetch changes up to a374cfbf609017f77a985357656be07a2da22c5f:

  ata: libata-eh: Keep DIPM disabled while modifying the allowed LPM states (2025-05-20 18:20:51 +0900)

----------------------------------------------------------------
ata changes for 6.16-rc1

 - Simplify ata_print_version_once() using dev_dbg_once() (From Heiner)

 - Some cleanups of libata-sata code to simplify the sense data fetching
   code and use BIT() macro for tag bit handling (From Niklas)

 - Fix variable name spelling in the sata_sx4 driver (From Colin)

 - Improve sense data information field handling for passthrough
   commands (from Igor)

 - Add Rockchip RK3576 SoC compatible to the Designware AHCI DT bindings
   (from Nicolas)

 - Add a message to indicate if a port is marked as external or not, to
   help with debugging potential issues with LPM (From Niklas)

 - Convert DT bindings for "ti,dm816-ahci", "apm,xgene-ahci",
   "cavium,ebt3000-compact-flash", "marvell,orion-sata", and
   "arasan,cf-spear1340" to DT schema (from Rob)

 - Cleanup and improve the code and related comments for HIPM and DIPM
   (host initiated and device initiated power managent) handling. In
   particular, keep DIPM disabled while modifying the allowed LPM states
   to avoid races with the device initiating power state changes (from
   Niklas)

----------------------------------------------------------------
Colin Ian King (1):
      ata: sata_sx4: Fix spelling mistake "parttern" -> "pattern"

Heiner Kallweit (1):
      ata: libata-core: Simplify ata_print_version_once

Igor Pylypiv (1):
      ata: libata-scsi: Do not set the INFORMATION field twice for ATA PT

Nicolas Frattaroli (1):
      dt-bindings: ata: rockchip-dwc-ahci: add RK3576 compatible

Niklas Cassel (8):
      ata: libata-sata: Simplify sense_valid fetching
      ata: libata-sata: Use BIT() macro to convert tag to bit field
      ata: libata: Print if port is external on boot
      ata: libata-eh: Update DIPM comments to reflect reality
      ata: libata-eh: Add ata_eh_set_lpm() WARN_ON_ONCE
      ata: libata-eh: Rename hipm and dipm variables
      ata: libata-eh: Rename no_dipm variable to be more clear
      ata: libata-eh: Keep DIPM disabled while modifying the allowed LPM states

Rob Herring (Arm) (6):
      dt-bindings: ata: Convert ti,dm816-ahci to DT schema
      dt-bindings: ata: Convert st,ahci to DT schema
      dt-bindings: ata: Convert apm,xgene-ahci to DT schema
      dt-bindings: ata: Convert cavium,ebt3000-compact-flash to DT schema
      dt-bindings: ata: Convert marvell,orion-sata to DT schema
      dt-bindings: ata: Convert arasan,cf-spear1340 to DT schema

 .../devicetree/bindings/ata/ahci-dm816.txt         | 21 ------
 Documentation/devicetree/bindings/ata/ahci-st.txt  | 35 ---------
 .../devicetree/bindings/ata/apm,xgene-ahci.yaml    | 58 +++++++++++++++
 .../devicetree/bindings/ata/apm-xgene.txt          | 77 --------------------
 .../bindings/ata/arasan,cf-spear1340.yaml          | 70 ++++++++++++++++++
 .../bindings/ata/cavium,ebt3000-compact-flash.yaml | 59 +++++++++++++++
 .../bindings/ata/cavium-compact-flash.txt          | 30 --------
 .../bindings/ata/marvell,orion-sata.yaml           | 83 ++++++++++++++++++++++
 Documentation/devicetree/bindings/ata/marvell.txt  | 22 ------
 .../devicetree/bindings/ata/pata-arasan.txt        | 37 ----------
 .../devicetree/bindings/ata/rockchip,dwc-ahci.yaml |  3 +
 Documentation/devicetree/bindings/ata/st,ahci.yaml | 72 +++++++++++++++++++
 .../devicetree/bindings/ata/ti,dm816-ahci.yaml     | 43 +++++++++++
 drivers/ata/libata-core.c                          |  6 --
 drivers/ata/libata-eh.c                            | 39 ++++++----
 drivers/ata/libata-sata.c                          | 12 ++--
 drivers/ata/libata-scsi.c                          | 31 ++++----
 drivers/ata/libata.h                               |  3 -
 drivers/ata/sata_sx4.c                             | 30 ++++----
 include/linux/libata.h                             | 19 ++---
 20 files changed, 455 insertions(+), 295 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-st.txt
 create mode 100644 Documentation/devicetree/bindings/ata/apm,xgene-ahci.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/apm-xgene.txt
 create mode 100644 Documentation/devicetree/bindings/ata/arasan,cf-spear1340.yaml
 create mode 100644 Documentation/devicetree/bindings/ata/cavium,ebt3000-compact-flash.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/cavium-compact-flash.txt
 create mode 100644 Documentation/devicetree/bindings/ata/marvell,orion-sata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/marvell.txt
 delete mode 100644 Documentation/devicetree/bindings/ata/pata-arasan.txt
 create mode 100644 Documentation/devicetree/bindings/ata/st,ahci.yaml
 create mode 100644 Documentation/devicetree/bindings/ata/ti,dm816-ahci.yaml
