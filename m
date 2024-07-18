Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B484DE4
	for <linux-ide@vger.kernel.org>; Thu, 18 Jul 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296392; cv=none; b=dNGVFQEs9PwiE0J7AeKVNt0ZcQcFOodHH4Lp8fBNTbORWMmWNRDjnnzgV0Y+4nvpgMhLMsZuQ5Ul4ttiZxtpgoMEE0N8b84uB/58cXjs79ISvW15wz0F7RniGULioG/4ua24f1OY7t/JqRum3o4s5vW5xGWxQwqHMLFLda8KVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296392; c=relaxed/simple;
	bh=R4Md4kPFItH0Tl4QBtrjbH6eZcIh6DqR2RdLEFqdqc8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uIO0jtfTqQde/IpZrWRw6Tuj4cS7pu0kgyKIzFyDn9VFtWIuKp1nSEfw9XslOt6jXb3VwIeAvrO02xyEDwJhOUriMrKX8vJ4qBJcQwQeLxVhDaTp+yF/FHfhKe3hofxV/bAcseE2U9ERY/zWkKSjjK/9CKqQhxmzba1tsr05nLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXC45svj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXC45svj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518B5C116B1;
	Thu, 18 Jul 2024 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721296391;
	bh=R4Md4kPFItH0Tl4QBtrjbH6eZcIh6DqR2RdLEFqdqc8=;
	h=From:To:Subject:Date:From;
	b=ZXC45svjjpuHSdfp5asu+CZF893eNZB6i8a2aBGQFCLkxWXvwNZ7zRCx/zZEzl18w
	 faZC5U2/2rCTQz9h6rn4PVE/uWIEKzMEtzEXJ4H92b0vMcUJEPggnOe5Y41WxYe63I
	 JzK+/OPV3MrtGx9JaV56v/DJj6/ZKfsd+BCjXTOSKoHtQABID8Qnd8sZw2B8+hlgIH
	 S8DK3ZrY9P2MtyFCxgXuCQuVGXgN37SHii9C3v9xRUu26eO53UMLsd1WK4oIBhelX3
	 8itrPFghgoAnK8s7tZsEaBfUPncnph5cchqIUD58+eqTT4/4DXVQtMr4DwtjDteaV9
	 V+NROS7oMvSvg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/3] Some renaming and horkage improvements
Date: Thu, 18 Jul 2024 18:53:07 +0900
Message-ID: <20240718095310.152254-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first 2 patches removes the use of the term "blacklist" from
libata-core.

The third patch adds printing on device scan of the horkage flags that
will be applied to the device to help with debugging.

Damien Le Moal (3):
  ata: libata: Rename ata_dma_blacklisted()
  ata: libata: Rename ata_dev_blacklisted()
  ata: libata: Print horkages applied to devices

 drivers/ata/libata-core.c | 111 +++++++++++++++++++++++++++++++-------
 include/linux/libata.h    | 108 ++++++++++++++++++++++++-------------
 2 files changed, 163 insertions(+), 56 deletions(-)

-- 
2.45.2

