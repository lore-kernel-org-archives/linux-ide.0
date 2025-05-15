Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FEF1C5D72
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317394; cv=none; b=FtqiCrZMq82EA+gY5VnHLm+HwLvLpB5ON2QirVsh/N2tJJfoELf9ZLQXEGnmwPmsh5c44OMvGTEAxMfig6XWd6AH6hxhxbt6TDVxA53AsLGp2WMTkSOYd4tSbNOzZ+EdYa0gGFJr3c8b5tUJHMiSFIcZL4cdD6IE8yh5f/QXWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317394; c=relaxed/simple;
	bh=BS3r/z2hdzDQOTUGL7TPOp15tTILSrrx+JfYNVV7tdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVVme0DbbwwypInPKz2oWmQo7q1/Mz8OJp90vRGz8o1vcpat2YVPRht3yzPocNCW4UaKPeIPnNreaK4C/LggGgRhZ+TKqmqFo0EOSBtrYIehOM5KRGw9x5P86Xp133wqlnFOVPijuT2K2Uejzhb0ASGeaiwo5ja5w0Qt8N8lv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsSmrEaD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsSmrEaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FD2C4CEEB;
	Thu, 15 May 2025 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317394;
	bh=BS3r/z2hdzDQOTUGL7TPOp15tTILSrrx+JfYNVV7tdc=;
	h=From:To:Cc:Subject:Date:From;
	b=VsSmrEaDOUE07TzwNmLEf/QpDRqXhuip+ko+VN7EehZ2ddN2cygFxg8y3LOJvF5zv
	 AoG6T//BNXn/NEGDiiR9wpojqvipJt8m13z+1I71TwHZDctjNtWoLMlvbiRjbOuJ0X
	 qxMD6EKqYb6+OIh8jYNmTZfU5awGv4+5YMhN0x6tWyK+vpU805jAvYmYBv4J+9qwk/
	 ZSCewqiLonbfNOc43NcHd9mrnEylsfJ6zd23rGo9A+2jXGJzN/3zVA1KPU9vKMG0we
	 Hfry50bsr/FN3CMGkoA7oHl3CtAyxB9hz/UmWLfrF55+bx69epOASZ71ZvCW7eDsbE
	 ZX6mdsk1DWpQQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 0/5] ata_eh_set_lpm() cleanups
Date: Thu, 15 May 2025 15:56:22 +0200
Message-ID: <20250515135622.720623-7-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=862; i=cassel@kernel.org; h=from:subject; bh=BS3r/z2hdzDQOTUGL7TPOp15tTILSrrx+JfYNVV7tdc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUP7WxNzV67kxW+sM4/aGblWzD9SmnG7mcv7h3BaU+5 QhW1pzZUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIlYajP8D86YcjN4ktrP/1yt sd9FswTtPFlnFkyTlvFqNfYUsn7/lZHh2IuH4b+DfJfImf1/ILThs8BUrj0L6urSLxxLnZ/Cml/ EDAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

I was trying to understand ata_eh_set_lpm(), and decided that
it needed some cleanups to make the code more understandable.

Please have a look.


Changes since v1:
-Squashed patches 3 and 4 as requested by Damien.
-Squashed patches 6 and 7 as requested by Damien.
-Changed WARN_ON to WARN_ON_ONCE.
-Changed patch 1 to remove parts of a comment that is no longer true.


Niklas Cassel (5):
  ata: libata-eh: Update DIPM comments to reflect reality
  ata: libata-eh: Add ata_eh_set_lpm() WARN_ON_ONCE
  ata: libata-eh: Rename hipm and dipm variables
  ata: libata-eh: Rename no_dipm variable to be more clear
  ata: libata-eh: Keep DIPM disabled while modifying the allowed LPM
    states

 drivers/ata/libata-eh.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

-- 
2.49.0

