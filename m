Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325623D7DF;
	Fri, 12 Jun 2026 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262065; cv=none; b=X/bnN7HGhYBdTQ1XTxb5oY3Xfx8cIQrMn4VjzaAYGEesxIsLU9FibIX+O0cvpqjregX9LY2w2cEP0IMiqifFC735qtVqGdZsnwq1PK38pmn3OkmwH70Hvisr9obwJiOhltA+YvmJv4+koiJI7opZep8GhirPDrdTbPEdxbWOlmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262065; c=relaxed/simple;
	bh=raR304hmglZkksX1aOwDyV8KUIccbnPWZQLgYkylhNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jIwR9QoiOy96Y6y7WwyC9Tf4xmFXJrzAUJlpVoTCtxODRuikR00VDyzrP16AqbdGVbTw+H0G9pO+NLXSwhMGsFaFazZOB7qAzf3ctsW4b00+Fi/UaWFSZLr/5iuyOVpB9N+2H8OGJt49vBIaOJ0wJL0X1a4i0BfFaOuZd5lXhdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jco1lxEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jco1lxEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6320C1F000E9;
	Fri, 12 Jun 2026 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781262064;
	bh=YgsdkeVc5onbSSOKjYEyVG+xaZltQM6AeoxBVY/klJ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Jco1lxEWnodehyRVKRpRESQHdz+3+bligYbryoKZn4aPUBItRWXqtLoCpLWsI1aBp
	 7XlMRieTVKTk0pWPER1wyfP4sXiwS/1H1LefBtTy6e9NJJ786QITda1e4OB0kUMsE9
	 z0QtgSRO3+PXcf1R2726rE55mL684qkZOVUvOjotnF6B/V0TWGjDtt1Eu1qyAqycuL
	 MnVO2ewfkoBv6DVrpRRj37S34nvbzHoAfHQvth0i68/ATeaBsrn7C/d60MUda2nApg
	 UFw47ztSCdZbYaR4V42e/dUiWppsgx9No9tjZWE6Qw30EulQaRlBUePfFvmjBkBPiw
	 HoOFnxzchU94g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Mikael Pettersson <mikpelinux@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1781252167.git.ukleinek@kernel.org>
References: <cover.1781252167.git.ukleinek@kernel.org>
Subject: Re: [PATCH v3 0/2] ata: Consistently define pci_device_ids using
 named initializers
Message-Id: <178126206312.1297311.8630238593041061835.b4-ty@b4>
Date: Fri, 12 Jun 2026 13:01:03 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2

On Fri, 12 Jun 2026 10:21:46 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> changes since v2 from earlier today
> (https://lore.kernel.org/linux-ide/cover.1781248922.git.ukleinek@kernel.org)
> is only rewrapping the pci_device_id in drivers/ata/pata_pdc2027x.c,
> drivers/ata/pata_serverworks.c, drivers/ata/sata_nv.c,
> drivers/ata/sata_sis.c and drivers/ata/sata_via.c to keep below 81 chars
> per line. This only affects patch #2. So I added Damien's Reviewed-by:
> tag for the unchanged patch #1.
> 
> [...]

Applied to libata/linux.git (for-7.2), thanks!

[1/2] ata: Drop unused assignments of pci_device_id driver data
      https://git.kernel.org/libata/linux/c/3b5b35f2
[2/2] ata: Use named initializers for pci_device_id arrays
      https://git.kernel.org/libata/linux/c/21e7b971

Kind regards,
Niklas

