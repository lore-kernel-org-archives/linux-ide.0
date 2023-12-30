Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F09BA34
	for <linux-ide@vger.kernel.org>; Sat, 30 Dec 2023 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 98A6514FB39; Sat, 30 Dec 2023 13:21:46 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH 0/1 v2] Only activate drive once during system resume
Date: Sat, 30 Dec 2023 13:21:27 -0500
Message-Id: <20231230182128.296675-1-phill@thesusis.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225151915.258816-1-phill@thesusis.net>
References: <20231225151915.258816-1-phill@thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version also works and may be a bit cleaner

Phillip Susi (1):
  libata: only wake a drive once on system resume

 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.30.2
