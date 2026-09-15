Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A13A4F51
	for <linux-ide@vger.kernel.org>; Tue, 15 Sep 2026 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789466355; cv=none; b=W1EzaF3yYVaFfvpQbBgWk5mWYYbU/olgz99brsFpeQvnpkxqhkx2htrOJ/4A66OG+4xqrrPcTvRNAXTH0UpIyS1k7sYVv4cjexFeYJ1CU/Loifwu7aLEbCr6Omu9T/ViRQ5p85YKKVB+DEY9Apwc6J65cI3RNNViq9witfO940g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789466355; c=relaxed/simple;
	bh=od9GhuX9XDh70gNd4qvbWE+jAaCyAXlo03Vtr9G9B84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pH2RAdxlJ7tn3CcnSYFkD9pYpRqVj++0K/RPGiNXn6cuno5FUHwxsFFy+t3Bpl4Q1aAchi4RALYSv+3taJiuP3oaVqEoI+lQmht1ZK23epZbxIRqvgD1z4hwYKNPyZ7HrR0lT7lySsqbDRe9PhT8lXw2t80EcIxS9ilBdZ0DNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOPu7nAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOPu7nAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915CD1F000FF;
	Tue, 15 Sep 2026 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789466353;
	bh=j92jfO4LoHBrBVcgVWjyDzmS4B6ISUjTP4JNI211h4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gOPu7nAvhsCyIbszi5xZpf7QmIji7ToUQRY3z9kPbY4F3w9R405IyXG//Hw1FEdDt
	 QAUrKF4dte0ZbhlTaiURlll04j3CsAvRTWZ8F8xOYWpDcjPYjAnUSUiETJ6270CBdx
	 rP1770tauIGZkrv2oNKLfQX+UmP4nrQMw4FWnLQ93HgKY2x7W3I+XGQPnuSKPn2khP
	 sh61GUuZF3hqyaWYTaatJnVGnKxSoErr+yFO9wOEZdeH0cuSN7GUENrCBDlvxPjycW
	 xP3+zuWMU49+9pe/l9PzqmfSHzOxTnRbm2I0uDsWkK5HoaYtAk5ar3DEpjuD9WOQTw
	 C621nKFrUAPQw==
From: Niklas Cassel <cassel@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Lee Jones <lee@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Baokun Li <libaokun1@huawei.com>,
	Dan Williams <djbw@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 0/6] ata: Do not release the host resources twice on probe() failure
Date: Tue, 15 Sep 2026 11:58:57 +0200
Message-ID: <178946628793.756083.10484116126177085687.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915084127.692494-8-cassel@kernel.org>
References: <20260915084127.692494-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=cassel@kernel.org; h=from:subject:message-id; bh=od9GhuX9XDh70gNd4qvbWE+jAaCyAXlo03Vtr9G9B84=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJWij2ytuLrtd182pCj4Hl0ILd5EHfN/nRZIYYPjydOv HpM+MCpjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExk7R9Ghg2rznPudVqUvTPr etCaX0d2cr3kLmbaPdlU3nLmoZyP6yIZGTb5HgrclVeorlk6f87rf1vO/F2vc8PgdvWRDEOrTT7 zCtkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 10:41:26 +0200, Niklas Cassel wrote:
> ata_host_start() registers ata_host_stop() as a devres action as soon as
> it has succeeded:
> 
> 	if (have_stop) {
> 		start_dr = devres_alloc(ata_host_stop, 0, GFP_KERNEL);
> 	...
> 	if (start_dr)
> 		devres_add(host->dev, start_dr);
> 	host->flags |= ATA_HOST_STARTED;
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/6] ata: ahci_st: Do not ignore errors when getting the reset controls
      https://git.kernel.org/libata/linux/c/c74ee923
[2/6] ata: ahci_st: Assert the power down reset in the probe() error path
      https://git.kernel.org/libata/linux/c/91e0a745
[3/6] ata: sata_fsl: Fix use-after-free of host_priv on probe() failure
      https://git.kernel.org/libata/linux/c/70b11967
[4/6] ata: libahci: Free the IRQs when activating a multi-IRQ host fails
      https://git.kernel.org/libata/linux/c/34a4a344
[5/6] ata: libata: Do not leave ata_host_stop() registered when activation fails
      https://git.kernel.org/libata/linux/c/d2f97700
[6/6] ata: libata-core: Fix the ata_host_register() kdoc
      https://git.kernel.org/libata/linux/c/52d19459

Kind regards,
Niklas
