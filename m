Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C55695
	for <linux-ide@vger.kernel.org>; Wed, 24 Jul 2024 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721799941; cv=none; b=P//jZKpYvyGV88ZTQKF53KW0XpflMeFmWbNaYkVMwjXW6854U8Cv0s61GgzuV3Tc74N7RI667oGnUujWH3Y8xEjlTaUBiE4NPml+ltUlQYU80lgjddihYcwpuyGTeGKaMzojHLtbIqdk6IDQJhJ3szyp1sLVRrFXl2ur++xZyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721799941; c=relaxed/simple;
	bh=O74Q8SC6TiccaNZgfwzNKx2jggEmy1E4nI4Yk4JlKTc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rOSFuhkxR/mAtNfJA1xR5Df4tlDwMV9abkn3ikzlAB/3BqELeayzI1d1jB/JM9wXzVD74X9vG7wG39CCMTLGHCbB7caQi7CTceMJJftfqUji46A6w0iLfr3/xprsXJZM8JOOayD8IXO0XwAZQWnZ+TN0mEWUsKxmLq61uaLR+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIp3kNT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIp3kNT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A56C32782;
	Wed, 24 Jul 2024 05:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721799941;
	bh=O74Q8SC6TiccaNZgfwzNKx2jggEmy1E4nI4Yk4JlKTc=;
	h=From:To:Subject:Date:From;
	b=bIp3kNT+YQuqCM5c+DEDc6UCU2mEnIuW+6Sq+hYXM3q5+1NvFyUdAI/68G4Cr3TXd
	 9hl/NMMcShl2cf0hU+0dX0t4OaLZgtfKw8EhjLvTII3XmxBsHKBk1mfps5gb1kk9du
	 G8yGqYahnv7sZBgluVbp9w4a5ks+woG/mVHzGLSNNAP90RhP0dZAg7a6JlTSsXfHKc
	 dsq3UHRG7j5ZzAW2rSuYng5Dqn3QJDsBNJUyFBp17db3/MkDLgU6OoRCO/SigqI8BZ
	 jvWXrYl8AM+jSvIsKf9rrzl91B56CEKdn3dBNJhLH9XuQ0vb7yYyoLA/QT4YUOtOI4
	 msbb6KGLq2LMg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 0/4] Some cleanup, renaming and horkage improvements
Date: Wed, 24 Jul 2024 14:45:35 +0900
Message-ID: <20240724054539.182655-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first 2 patches removes the use of the term "blacklist" from
libata-core. Patch 3 cleanups the function ata_dev_knobble(). All these
patches do not introduce any functional change.

Patch 4 adds printing on device scan of the horkage flags that will be
applied to the device,  to help with debugging.

Changes from v4:
 - Removed the useless !! in patch 1
 - Added Igor's review tags to patch 1 and 2
 - Added patch 3
 - In patch 4, corrected comment about __ATA_HORKAGE_MAX, added missing
   newline for the horkage warning message and corrected the commit
   message.

Changes from v3:
 - Corrected the BUILD_BUG_ON() call in patch 3
 - Corrected alignment of horkage definition comments in patch 3

Changes from v2:
 - Simplified ata_dev_print_horkage() to always print the device
   revision (patch 3)
 - Simplified ata_dev_horkage() to having 2 different calls to
   ata_dev_print_horkage() and to always print the device revision
   (patch 3)
 - Added a BUILD_BUG_ON() check in patch 3 to ensure that the horkage
   flags all fit within an unsigned int.

Changes from v1:
 - Remove unused macro definition in patch 3
 - Use unsigned int for horkage flags (patch 3)

Damien Le Moal (4):
  ata: libata: Rename ata_dma_blacklisted()
  ata: libata: Rename ata_dev_blacklisted()
  ata: libata: Change ata_dev_knobble() to return a bool
  ata: libata: Print horkages applied to devices

 drivers/ata/libata-core.c | 116 ++++++++++++++++++++++++++++++--------
 include/linux/libata.h    | 112 ++++++++++++++++++++++++------------
 2 files changed, 166 insertions(+), 62 deletions(-)

-- 
2.45.2

