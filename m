Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3890E1FA4
	for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2024 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721612054; cv=none; b=BfEYy9DSspENG9Q/do4ijGnLN3bNmGgPa0aVh6fW8HnOM5DRntPAy9dbVNlg+WL5Sj55BQtvQf9Rehr3/REoBuHoxMjJ+cLPxp38Dj34t5WkWmPwEl2mMryAXUs9wxlO0L7I8X03Ohr39YsCfotNo08RVIizB1pAral55HHeDq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721612054; c=relaxed/simple;
	bh=iY/+iXkElAIbsjDJdA6+2rgax0JEskN9sCqaNObtncc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XpxEWTNldrnB7gKnEomc4EgxrfViRnO5Hv5JxskwjymkT4CjC8WD4uTPtMfzkfNRzWFshDIPa+eN0JMJ7HmEHo1gIl+zdiZTfLfYcg1sIFSF/gkBMU6eNBjAYzO+EyL3LyfNak/T+9sL9YooNmhkYE52gtb08iYKWongGVjlfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J22Gir3K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J22Gir3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E505C116B1;
	Mon, 22 Jul 2024 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721612053;
	bh=iY/+iXkElAIbsjDJdA6+2rgax0JEskN9sCqaNObtncc=;
	h=From:To:Subject:Date:From;
	b=J22Gir3KoTsDbiitBAs6zIioeC5tqk7cpnNDMFHEaXLaoXLLT8KrYynImGKwPED2V
	 MIQBXLGI3aMjqH0TOku+Pvip77qk+LWbXCbD135jJaibnHz/VreAESUZMXantLjhnv
	 MqxV/XwzDePuVMZbECGmGaMO7QD6XMZNgOwpreJU5CmP0SeTqyvrPpfqdNlWhaPmZQ
	 tiHHscuZjLplFkPUSRI8puUwoLZpT1UVZuHFyKjVy57ldOm3weK2X5DZdkYTgpElVe
	 I2G/HjYpj5EncMnvT2ifUini8OsJyGAnggdo9EY0KwSRUK0CJR3AorZawDqaJq9oTD
	 RlwlO0WSgyqNQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 0/3] Some renaming and horkage improvements
Date: Mon, 22 Jul 2024 10:34:09 +0900
Message-ID: <20240722013412.274267-1-dlemoal@kernel.org>
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

Damien Le Moal (3):
  ata: libata: Rename ata_dma_blacklisted()
  ata: libata: Rename ata_dev_blacklisted()
  ata: libata: Print horkages applied to devices

 drivers/ata/libata-core.c | 112 ++++++++++++++++++++++++++++++--------
 include/linux/libata.h    | 112 +++++++++++++++++++++++++-------------
 2 files changed, 164 insertions(+), 60 deletions(-)

-- 
2.45.2

