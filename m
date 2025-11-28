Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B552D23A4
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319714; cv=none; b=sgmp52lFPn2xACGGDLQvSK05oaBJ/LmjBt9THenUmYjzA8ZhQvizLb8zA+KIvtU+IINvv0zbLXukxcySeNtixQQ1VSvV+DzbJbhBOhzfVBnF4hc83PSAxOd/wZbmEbthOHR1+zd2RRlN4TmVrjY2XLZXqr1e4Ki5Ua4l6jBxocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319714; c=relaxed/simple;
	bh=Xz/+Xe5EAzt3o9GTVKFOKaaE5cmBH+WatMT/0k68ANI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ERDbVHn6gvx8Rzu5siS8/COqR+P86baiakFJWgXJCasC/hriXRxX6jRoWh3VapNaNJX+Jydgu688VTBBrhvQMPtcOPWYYKEDz2AK4TjE5C7pOzVJVgXqKngoqf2Vi6/R4jQJVCQHgQ9H5SLYrOvG7ZxIu/nUqDZ1rqO8UW/5/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM8cJqpg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM8cJqpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D096BC2BCB1;
	Fri, 28 Nov 2025 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764319713;
	bh=Xz/+Xe5EAzt3o9GTVKFOKaaE5cmBH+WatMT/0k68ANI=;
	h=From:To:Cc:Subject:Date:From;
	b=nM8cJqpgQFPY8k4AQd9JdbyMRxBlQeikmn1arQvlvx6Vpdv1QddIuRHZBdKIkor5s
	 WTMtZjeAnmZ4m7Ks2JWI1UGMWpMe80a8tknJw/+Kdtyh0sZA4QBKBU6D6VVs07+9cI
	 o0ytlmOwCwsb0v+nwUJcBPrXb8IgtbkrYPoBnCmBN1jX1bK9AjkRWg82JCNByc9Oh2
	 mJlYejsCZGTykVavWVS8SVGEg4jDldZX0+XvoWvLOB1cHTReWjVqxmO0mKTcJnY3jr
	 I8dvZ+Zie0a/zyb8vcm2L3yLoKhkM52zHWjcHiHoywn+TPQ3a4hZEhQkhwJai1mymd
	 36F+n2nyk+XpQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/8] ata: libata: Quirk DELLBOSS VD max_sectors
Date: Fri, 28 Nov 2025 09:48:15 +0100
Message-ID: <20251128084814.3798425-10-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=cassel@kernel.org; h=from:subject; bh=Xz/+Xe5EAzt3o9GTVKFOKaaE5cmBH+WatMT/0k68ANI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI1E88JNUdsPaR9NEauK9/jWuKfxzXvLsjp2C5a2dq8z MWy18K/o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABP5coLhr9yeF/cmOkYcqfl6 YxEHb3Olx6PInT6nOuxbyx/JTeC+z8fwv3h39Hz3ptbPvXu2m5643X6VWeVKqfSLkALrs0Hn5bZ /5gAA
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


Changes since v1:
-Introduced a generic quirk (ATA_QUIRK_MAX_SEC) that also has a value.
-Added libata.force parameter max_sec=<sectors>.
-Use the correct model string for DELLBOSS VD.


Niklas Cassel (8):
  ata: libata: Move quirk flags to their own enum
  ata: libata: Add ATA_QUIRK_MAX_SEC and convert all device quirks
  ata: libata: Add ata_force_get_fe_for_dev() helper
  ata: libata: Change libata.force to use the generic ATA_QUIRK_MAX_SEC
    quirk
  ata: libata-core: Quirk DELLBOSS VD max_sectors
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

