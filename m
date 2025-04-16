Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84034140E5F
	for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2025 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795898; cv=none; b=cb8GP3H5ScMYtiXhyejMwfqJhxJuTdjYc/C2Z38P0861BVhW3aPOdM0daJEhyyHyJvnseYZqaJN1yxdPAoNjh+z+sDXJtJPM2RFA5tEy1iV+VCYmsj15ZNeYRka2J9vdoSI7erP4ojj1CaJDgqgWqD5jP60cC9/j97fIH//9Hps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795898; c=relaxed/simple;
	bh=11v9NynH1LJvmAmyEiep8J73rSYY0C1+/ICLAP69W8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqAl15nd6lNghxXPwoXt38dAKh/fpWew0ZTWSM2aXyTAITp0ks5HSB62Z0Xcu6WHhFZ36FAZUtJvjslTVBAok3M8ypSKL3Nk1AKahi7F+JTYPFpbcLjegSBzzNisVeuLBL3s9Ngu7xWs6Nh4XNgPMN5YFE4FB18rCb8qArCvSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4nXcplL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4nXcplL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29E5C4CEE2;
	Wed, 16 Apr 2025 09:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744795897;
	bh=11v9NynH1LJvmAmyEiep8J73rSYY0C1+/ICLAP69W8Y=;
	h=From:To:Cc:Subject:Date:From;
	b=h4nXcplLF7Pejwmj4QMj2XoW4MWaRs2EwohYFr+OVeLWB0DuFAlBRpXdqApUmCusC
	 iJrelRmQq3LXurPeqKFjYJ8lHiOjC8uujC2+ho2JkgaijJXaDUi461my//eMJkQfwq
	 6H2ZVvrqFw9CR/OdxyQNvGiQyNijyGBS6o/QBuPibp+Fu0RfQ8Ec+nxzlFlMAxOH+8
	 mpPr8NflnFo4iZeLRnr3c2QYZkWDnPFMT5jp+qxrBIdMyvjahixbFGLlgwdo3TbIdO
	 U8U/MS+HzRustWZ6g9E3rtFlZyZMcdhtbXYjRPrTcy8xD6fKTo+hHs8aV0YL32NieB
	 ZP255nDIUlpFA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 0/3] Successful NCQ commands sense_valid cleanups/fixes
Date: Wed, 16 Apr 2025 11:31:28 +0200
Message-ID: <20250416093127.63666-5-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=615; i=cassel@kernel.org; h=from:subject; bh=11v9NynH1LJvmAmyEiep8J73rSYY0C1+/ICLAP69W8Y=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/V7w/9X916Lb/slFh4QtPOi7ZIKMQd0Zj4u1z+rbi6 36368vd7yhlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBETs9hZHht9Kg8QPjtzd9X OD85xLaeSfhZw+Hhe1V+0YWUAOlfZQ6MDO1Pr7zdemXTid8pe6yOmYatmSly52b99gUTgmLrP73 aGcsOAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

Here comes some minor cleanups/fixes related to the sense_valid field in
the Successful NCQ commands log.


Kind regards,
Niklas


Changes since v2:
-Picked up tags.
-Changed "1ULL << tag" to "1 << tag" in patch 2/3 (Damien).
-Improved subject in patch 3/3.


Niklas Cassel (3):
  ata: libata-sata: Save all fields from sense data descriptor
  ata: libata-sata: Simplify sense_valid fetching
  ata: libata-sata: Use BIT() macro to convert tag to bit field

 drivers/ata/libata-sata.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
2.49.0

