Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174782556E
	for <linux-ide@vger.kernel.org>; Mon,  1 Dec 2025 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592515; cv=none; b=GrxojSOHrkDN4R9Es0v5B17FBOlDpP/iHfN5mRwnyRf1IabKSuyDU8XHv/iCoTnUzkquL6a0DxWNI+4cSI/QKZaeltb1K0oz9r0fJVn6XTIRyDO4PCc0Z8Yra8hV8L+AI6WcX3QMW3hjAa6/6o/X7nmquWomQORzV5xq5ca9NAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592515; c=relaxed/simple;
	bh=0c8tPk0051BgIFUqRZiaaT+FpZalOutsdG5M2yw+sT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t0CT54RuzOr38IJPCL0D/Mf+2sJ3ixoOxqUEUzR32+FYC48tBAV80tLQbKjVX+udJhaxMO43Ss6bQ54jan2ps8ttOfej8g8KUNtPq6ENZeAkBPRG1Ce48dH48B7dVNt3LAC3+WE2AVAeZcQzgFsdzO3HfkgEvnQCoJ0jDxfLtgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdTTfoMW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdTTfoMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8CCC4CEF1;
	Mon,  1 Dec 2025 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764592514;
	bh=0c8tPk0051BgIFUqRZiaaT+FpZalOutsdG5M2yw+sT4=;
	h=From:To:Cc:Subject:Date:From;
	b=XdTTfoMWwK3Wl5IXE49t2RV8GOntFdmACaFkg/soDB6JtyOZHQMea2fu4r0rkD3ac
	 6VwSA/errOPAGQkdELKbZZkkl7ZUsTdcFdeM6Cod3Rfb7U6NvZmeFa4Qp8Xf1ySr7y
	 tj4CMts9agKAbw06EwHNi7lqcFzWIDXp9jg+K1Ip+iN9Bowl/5RnxFS3Dx5ACPgYef
	 pOTCMOT6HbPjrTerVmVWUyi/8vG0dmaKiOqN9g/t65irGQCerz3cy4sMVQyQOOT0t6
	 Gdjtl1w+C4kc0Pmq3MGkH8wt2IObI2XXGIrom5G2UkuifS2KRFqcX6jWCefy6a3D7+
	 pyNXH28dTentw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 0/8] ata: libata: Quirk DELLBOSS VD max_sectors
Date: Mon,  1 Dec 2025 13:35:02 +0100
Message-ID: <20251201123501.246282-10-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=cassel@kernel.org; h=from:subject; bh=0c8tPk0051BgIFUqRZiaaT+FpZalOutsdG5M2yw+sT4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ1u0ur+pd1PeFyD+h5ldPwNmHfpjymdc1NjtO+a35iy hI+w+zUUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIk8CWJkmLDj+xUtnnXnG80Z ZJuf3O/2mbOqIVrqtKTHVanY52s+rGVk+KymqbBTsUBcQer9syWL7Ew5sw//vic2hfPkuxrOZT+ T+AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

a recent change:
commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")

bumped the default max_sectors_kb from 1280 to 4096.

It seems like a lot for SATA controllers are buggy and don't really like
this, see:
https://bugzilla.kernel.org/show_bug.cgi?id=220693

For now, we only add a DELLBOSS VD max_sectors quirk, but surely we will
need to quirk additional controllers.

The intention is to queue patches 1-2 for v6.19, and patches 3-8 for v7.0
or (v6.20 if depending on which name Linus chooses).


Changes since v2:
-Move patch that quirks DELLBOSS VD earlier in the series, even if it adds
 slightly more churn.
-Pick up tags from Martin.
-Fix minor typo in commit message for patch "ata: libata-core: Quirk
 DELLBOSS VD max_sectors".


Niklas Cassel (8):
  ata: libata: Move quirk flags to their own enum
  ata: libata-core: Quirk DELLBOSS VD max_sectors
  ata: libata: Add ATA_QUIRK_MAX_SEC and convert all device quirks
  ata: libata: Add ata_force_get_fe_for_dev() helper
  ata: libata: Change libata.force to use the generic ATA_QUIRK_MAX_SEC
    quirk
  ata: libata: Add support to parse equal sign in libata.force
  ata: libata: Add libata.force parameter max_sec
  ata: libata: Allow more quirks

 .../admin-guide/kernel-parameters.txt         |   4 +
 drivers/ata/libata-core.c                     | 203 ++++++++++++++----
 include/linux/ata.h                           |   2 -
 include/linux/libata.h                        |  80 +++----
 4 files changed, 202 insertions(+), 87 deletions(-)

-- 
2.52.0

