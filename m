Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76218285CB3
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482507; cv=none; b=TMuCn+XMQVUAmseSNiwfFYIEwVMm+Q4fUU+OBSKHXYpWmddThlTTenlYpyBculOiRdySrgckS6sbxe2EMdOMVJh9+CCCpY7T73EPK32OpVkZfdf7AC/+yGk4spqnUY3wDG4Q56y9bAyVEjTvyeaFP5/MfAXObtIi+ShHTW7Lfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482507; c=relaxed/simple;
	bh=UOt/xsIU7no0Z3xyZuKh8fiefakNSOeYaK77XSC+r4E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KjIcpSCzvjOyUw8jBbNSKA7Jq1tIQ9efKcta7DAfN48lkYKKD8n21COwPTUcq+KsTc0cnBd2nPx8zb68ookLh3BI2D4uw8Y+24hYqNBdSTXc3SMSa8KeALgjwrtQdKrFhrpcN0o0Ahb66rnFuXfISdnzWGX3cS5UdEAE9F5mkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlZlM8Zi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlZlM8Zi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D675C4CEF7;
	Thu, 19 Feb 2026 06:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771482507;
	bh=UOt/xsIU7no0Z3xyZuKh8fiefakNSOeYaK77XSC+r4E=;
	h=From:To:Subject:Date:From;
	b=jlZlM8Zi5skr8RzNR7OgernbLACRU7ofjMY5rUwfmJ/3J5hDQA4tNLgowCCKTIcTq
	 mJX03imXrSmRiXTfxC1NfQt0jgDpEzaszLmiv1VLJWcHs3nDtlyUkjRTmpYqX1hhCZ
	 POezr2kHdW9s4gM66NHEDRSzJMnnVHJle+2vVSlfxTUcpFzLAZ72pUC/kUxoDFyTBU
	 B0Ok4VPXACTMWhcsFzeO4ez3fcZbE3xx1a0kzAV68kCCRBs1FhuGTufDmkL2kY8EDb
	 ZzwFy9/zu8hWQ8jYYy8pEwf8EJd9dezTIx72xRMeHk1FRMGo+0yQbG3JQYrH84Q/43
	 4T9Y4G1b6cAwg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/5] libata cleanups
Date: Thu, 19 Feb 2026 15:23:07 +0900
Message-ID: <20260219062312.1030867-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a set of patches to cleanup a little libata code. Except for
patch 1, there are no functional changes.

Damien Le Moal (5):
  ata: libata-core: improve tag checks in ata_qc_issue()
  ata: libata-sata: simplify ata_sas_queuecmd()
  ata: libata-scsi: simplify ata_scsi_schedule_deferred_qc()
  ata: libata-scsi: make ata_scsi_simulate() static
  ata: libata-scsi: rename and improve ata_qc_done()

 drivers/ata/libata-core.c |   9 +-
 drivers/ata/libata-sata.c |  14 ++-
 drivers/ata/libata-scsi.c | 174 +++++++++++++++++++-------------------
 include/linux/libata.h    |   1 -
 4 files changed, 98 insertions(+), 100 deletions(-)

-- 
2.53.0

