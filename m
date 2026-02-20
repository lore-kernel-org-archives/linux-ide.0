Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C023A99E
	for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771563971; cv=none; b=KpQMaUJAZ0hFNAE4aPAUdTijW0B2XcYBIkOXLbujBK8yO46iEDESRbJ4vXhuTQfYe6o3gT9HkWL88cf4npMHTTY/zgjfqjKWujLNlKWzc/vvnqMCDnUD4qsdTtR62UvBFBittpgrsE9ezRCNjviqWuN4sW86w+JRiLHn8rXXYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771563971; c=relaxed/simple;
	bh=a1Pw1YRJjhqOi0hv6QbmRp+y1UeYJv4XW6ztmzvQ878=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=neVBQTYErpQOUVNSchpC88qA8QUPmP+tjp2jdpi35j8sV9KEAvVHaAdw4ZwT3AVA7hd5ehQDDCVmTHi/ihSfiuEmdpOxsbzixLmEr2gePL2pO//WO21rmkc4SfOB1WnyyqlCkP8rFbusWzffEQSNh0fkRK3stNUt35WC2sSmAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsAQXCuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsAQXCuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7E6C116D0;
	Fri, 20 Feb 2026 05:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771563970;
	bh=a1Pw1YRJjhqOi0hv6QbmRp+y1UeYJv4XW6ztmzvQ878=;
	h=From:To:Subject:Date:From;
	b=tsAQXCukOjf9Cmk/QCjtoEncXOdDIxTHODykwlIFrVrXaji9+Ml/mjXp1ONGMq+nt
	 pPa7/w8PilLwwxYOlsOYds7kychogdvHNa4BOvJY1LSolJ94G/Ni9aN48He26wS7J4
	 uzY1w7fRURVcrCh/grCFShtDZbXQGsjb4nq1G5TzSK0uhwhMrNJf4ql02wdZn6eRKq
	 m7mAeBwvp8Xup8hyXSSGZU9WOU1QKQt48MgiSQTf0OQe3AP/LfAq2LbsO0Th0RiL1e
	 kqdGaHYoIMqryAuniUYzutInxLngGFrQVBbLfG3VvApM9YbbPpDAy3uxWZ/L0TwwGe
	 H7Kv02Kkjoayg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/2] ATA port deferred qc fixes
Date: Fri, 20 Feb 2026 14:00:51 +0900
Message-ID: <20260220050053.390135-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch addresses a use-after-free issue when a deferred qc
times out. The second patch avoids a call to a potentially sleeping
function while a port spinlock is held.

Damien Le Moal (2):
  ata: libata-eh: correctly handle deferred qc timeouts
  ata: libata-core: fix cancellation of a port deferred qc work

 drivers/ata/libata-core.c | 13 +++++++++----
 drivers/ata/libata-eh.c   | 20 +++++++++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.53.0

