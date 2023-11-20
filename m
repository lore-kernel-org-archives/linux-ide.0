Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD704374D5
	for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2023 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEolKGlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4392C433C8;
	Mon, 20 Nov 2023 22:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700520994;
	bh=XxKriClw7kJNhV8djvf+9DEMraeQlomplnQwhouqjt4=;
	h=From:To:Cc:Subject:Date:From;
	b=EEolKGlxkhOlX3zBpSPbvgUusVNBriD3sVV4gigg+0a9huZsfHg8SEr4EVeK13cho
	 4qQiR8h9qSnXsmN1NGcA437xcyZQB4a2Bf5qbZPfWKviDol6wYLIvllUzOA+1MyPo2
	 AEiIAbublEG6xOamKc6tMxjRyl3to/QVIlmC0r8nDdNUg8ozdTDwX/X10wbFgUmQyn
	 OQnlVYf7Sm7YLHUKZIeSO1QBL6hRagGpbSnIcolorguDsIVuFjNh4oHDR+wphGIFoL
	 dxT3phxH/p7cNSaGlTAXMIioAuOFtSNqKacdt+Xecrhv5phLiF034UQ7R4an+WcOTl
	 gDDgQH0mYKPoQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH v2 0/2] Fix runtime suspended device resume
Date: Tue, 21 Nov 2023 07:56:29 +0900
Message-ID: <20231120225631.37938-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch changes the use of the bool type back to the regular
unsigned:1 for the manage_xxx scsi device flags. This is marked as a fix
and CC-stable to avoid issues with later eventual fixes in this area.

The second patch addresses an issue with system resume with devices that
were runtime suspended. For ATA devices, this leads to a disk still
being reported as suspended while it is in fact spun up due to how ATA
resume is done (port reset).

Changes from v1:
 - Fixed typos in patch 2 commit message.

Damien Le Moal (2):
  scsi: Change scsi device boolean fields to single bit flags
  scsi: sd: fix system start for ATA devices

 drivers/ata/libata-scsi.c  |  9 +++++++--
 drivers/firewire/sbp2.c    |  6 +++---
 drivers/scsi/sd.c          |  9 ++++++++-
 include/scsi/scsi_device.h | 12 +++++++++---
 4 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.42.0

