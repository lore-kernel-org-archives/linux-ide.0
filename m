Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E298531F9A4
	for <linux-ide@vger.kernel.org>; Mon, 31 Aug 2026 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154191; cv=none; b=XcPvq20d8Q7ALDgT0M7seXW39++0GaEpSyfW+83Q7IV7bHPGsHtLQ15PTwuP85VprSvl4nLPM3+I3+omRw8NHWUbZQkCxQ81rmojI6T/g51du50b87vbmysSJrzlbYzoaSm2h3lOt+fcXreHfJfr/jspAsEeoIdzHH0M4ispc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154191; c=relaxed/simple;
	bh=NR2xhHsnWfhj+7nxMFgQ71POAHT7HtYBW3gM0byn+78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tcLGpZD8QZlUpa7aFLOZOw8lWGkbp0cgVF4nddTmqm//duLCQH0ZIfUxZxSyVxpUD4i8VhNfODNKENovv6yadYQ4qbJjwzWwwcNUT7KXDvVybnmJxeDv2W2cUt99Ysw3LBdcOsaj3Rl4nqiR9qC/pKERDo9nA/ocsop3Yjd70nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwrPcNjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwrPcNjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2811F000E9;
	Mon, 31 Aug 2026 05:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788154190;
	bh=9AhYiuBq+iESAW2rGDkSKScbZ6UNn9U0olE9VZXlvyw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nwrPcNjL/epHn8y+vafdBR4gQhH6k3/u1WFqhx6y8jpjANxhfRpaxqMTUVI0LObZb
	 RLjkcsREsVLE1GzkrYTanb4HJ0Gl6yI4NQOlRuqQy5ZatYzKqHbWzyGL2hrIgVI3xD
	 H2fz3MqScZzSoj9PHDWs05NogJFcvM4sbgUCe0jq7LidOOLGmGtWNQW7dccI+iJ+oT
	 uUgdgCJasBRxKONY5wGQ3wejljSwe93+B+xu95fnf8TsUUJzzzfpUu/YK3pDaFguZ+
	 luxiT2ymkiXj69TUptWzPLiyGUZco1Hq3ZwX5hkb4s0wGGy1upMZCo59wSLisVLTm5
	 wp66L0TeFWxoA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com, 
 linux-ide@vger.kernel.org
In-Reply-To: <20260818094205.2672967-2-cassel@kernel.org>
References: <20260818094205.2672967-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: ata_generic: Do not bind to devices that are not
 IDE controllers
Message-Id: <178815418923.91533.5133431753834931424.b4-ty@kernel.org>
Date: Mon, 31 Aug 2026 07:29:49 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 18 Aug 2026 11:42:05 +0200, Niklas Cassel wrote:
> syzbot force-bound ata_generic to 0000:00:03.0 on a QEMU arm64 virt
> machine. That device is a virtio-blk-pci device holding the root file
> system, and it reports PCI class 0x010000, i.e. PCI_CLASS_STORAGE_SCSI.
> 
> QEMU gives the virtio-blk-pci device a legacy virtio I/O BAR0 and a 4 KiB
> MSI-X BAR1, so both resources are non-empty, the port is not discarded,
> and the device control register ends up in the middle of the MSI-X table.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: ata_generic: Do not bind to devices that are not IDE controllers
      https://git.kernel.org/libata/linux/c/29b86026

Kind regards,
Niklas

