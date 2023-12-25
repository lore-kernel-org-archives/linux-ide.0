Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96479524D8
	for <linux-ide@vger.kernel.org>; Mon, 25 Dec 2023 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 3393F14F2D8; Mon, 25 Dec 2023 10:20:26 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH 0/1] Only activate drive once during system resume
Date: Mon, 25 Dec 2023 10:19:14 -0500
Message-Id: <20231225151915.258816-1-phill@thesusis.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have been wondering why I kept seeing drives activated twice
during system resume since this got added.  It seems that the EH
process can run up to 5 times as long as there is still pending
EH.  I am not sure why, but it look like my Intel AHCI controller
issues an error interrupt during the first round of EH, even
though there does not appear to be any error.  This causes
the EH_PENDING flag to be set again, and so a second round of
EH happens, which then tries to activate the disk a second time.

I propose the following patch to only set the ACTIVE flag once.

Phillip Susi (1):
  libata: only wake a drive once on system resume

 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.30.2

