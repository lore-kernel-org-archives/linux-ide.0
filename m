Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9E43AA8
	for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2025 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835232; cv=none; b=ZXFi9oUnNjjU5/bkHm8C3Wt4aiKxZ74KkmPdYmPqTMtFART9DULhgGQBhmgEE0h8mZNNl8ax06u1cKz8jLhYvTfDr4fPGVpATEMJ1O2rhbTLVYtQLxR1KeL4fXdQAqHKekTto6kfNDgWo/DUOkB36d0sFMAC6XRUiUT7nxBNRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835232; c=relaxed/simple;
	bh=gx3MfZhp6VzVP7WNpCA/W9eOrR6qXKWBOkKd4n8Umps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CsGRGMg65/1aWkqIAV2GxMbNQf61LXf6vt995Jmpz5j2UDX4IKb17U6KRwYA7xYzpiiBAjnMsuDJXe2x7Bl2SW0lOLIkhY3BEiztCyuqthW4gm2nCane2yR2fqI1YAuLQoT5N+OSRZjWxROYpSOVbVgjfyrWemgQSaptlaHcpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmpmf8ua; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmpmf8ua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5175CC4CEEF;
	Wed, 30 Jul 2025 00:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753835232;
	bh=gx3MfZhp6VzVP7WNpCA/W9eOrR6qXKWBOkKd4n8Umps=;
	h=From:To:Cc:Subject:Date:From;
	b=Pmpmf8uaK9OJoeUKwrScXCG/NMZuzrJ+Gu1BCUCz1kGLSwHH7NT7YSzjw+0xW2tYo
	 18kr9d3Bb1Bqe9Xgttn1sQliviCkovDx7dAA5vuoNzsrxyLjT+NkYSV0qEbvoY/7oZ
	 hs6CakbhtrgqfhQCzlSnQ/idmyOWIJ1io09U5MHjxi0HXcpVNLRLV/ZWR+ycMQR6Dm
	 UXRW0VJK3PPCgfnAnCqfr7p6XDljch269sBo909eDxKyJvKMSqMYIA1mZFCchbwG3w
	 5+k/nWeuLBuGiEnTJkfGp4LF0pG+4wnjzLS1dau8RN+2h2ZLk9HU5s3MIErvkwQoAM
	 0o5ZhugEtF6jA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Lorenz Brun <lorenz@brun.one>,
	Brandon Schwartz <Brandon.Schwartz@wdc.com>
Subject: [PATCH 0/2] Fixedup status+error translation to sense key/code
Date: Wed, 30 Jul 2025 09:24:39 +0900
Message-ID: <20250730002441.332816-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of patches to fix issues with the translation of a failed qc
status and error into a sense key and sense code. The first patch fixes
a long standing problem leading to nonsensical sense reports for failed
commands.

Damien Le Moal (2):
  ata: libata-scsi: Fix ata_to_sense_error() status handling
  ata: libata-scsi: Return aborted command when missing sense and result TF

 drivers/ata/libata-scsi.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

-- 
2.50.1

