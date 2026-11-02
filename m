Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616321;
	b=Uh8nZsADiwQaZoQqMYzz4YxEyCFH58w5ruZocvCjfo6OIZzaDTbEBKWEmaSb4pktJtte
	 smIepolPa8/Sg+FYul+FMP74LQU0leYXMOsSfe0Hff8O0wqCMgC2CfW3q0ywEeC3uagCk
	 voyZS+PdqMXoyREnWZkExF9NeaIfD/Z0UZB4OicX0t7B67b1NzsUTGjcnIdXWY42vubBB
	 aayTKqgBmiTTJi5HV6VrArn1MxYKMWydP8WONyA9KhKFi6yNkDMCc4N28lm2VAa92Z+VA
	 PTOWV0VObRDcS3rrBDx14gCRB6xGc9X2uyxHU257LFa0YP4BhdKH1UAZFUYPmsaR9Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616321;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=ZlCyMa6JAU9Vu9BXnlawguWEl6N+I/RuxYplOZA2T6I=;
	b=tXgCgPcczH2rW2DQ72GJ5Ck/X1p2Ss9tRZBgZlSODeB05zZCD0xfS+GD6xlr/dftikVW
	 Ml4D7qr9zY6qwew3dLjeC/VVzwZbjAT7HGFML2qQYLb/8MgQ7NnrDdYJoks+16Ch1EgjM
	 A9CUjxFYuYMmQ0N7SSPdj9IEDlsvsEXHxd5iUA9fkChuY8MIL0XTztKNftRu0XNHcwjml
	 BBBR+ywmhS0cHCJACex91artURIRqpRP8nIuM6o+Yjndh6yHTpW4ij9eKSfxQgbEX9QC/
	 XYa7xc/gL9+IVO9d3od+olI9yQ+55hLT3uYgmIK/Yp9ilce0iFZo3xJ8fFqWaHzbcyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNLN6WJu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2E606A324;
	Mon,  2 Nov 2026 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNLN6WJu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7647A1F000C1;
	Mon,  2 Nov 2026 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616320;
	bh=ZlCyMa6JAU9Vu9BXnlawguWEl6N+I/RuxYplOZA2T6I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aNLN6WJuB9LtzLLkvmk3SPNO6j+fEPLNKkmZ/paf0THAUes/9IAb72MeG4bTzdwaM
	 qcpxNa6dQD9XQVYCTm1/kzBiRrMSw/rf+KlvZJ/ctrppCdHabyVSyya7KAXWPcE0PO
	 f0nl946j3MH3BSahK0Y/8v4cVm5W/+uhPBw2ZPWa3/3n2ACD/WnZoZ2/rnHfINMe6v
	 73lroyoLkbijz8sxlpzfxXiRip0HM9Qjvf4jCiaxYP/tmovy+bOsYz2Be69UpLv5XG
	 9ufwHTVJluN/PVG8WhoKufdC7zONbnS0sm2mhih5SxTHAy+i3D4/bFAIvYFgiwe7rX
	 PzkAPamgZ8J/Q==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Giuseppe Piscitelli <ooonea@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261026202513.669084-1-ooonea@gmail.com>
References: <20261026202513.669084-1-ooonea@gmail.com>
Subject: Re: [PATCH] ata: libata-core: Check device support before querying
 power state
Message-Id: <179361631918.1220507.6104864454564624979.b4-ty@kernel.org>
Date: Mon, 02 Nov 2026 11:45:19 +0100
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 26 Oct 2026 21:25:11 +0100, Giuseppe Piscitelli wrote:
> The standby path queries the power state before checking whether the
> device accepts ATA power-management commands. This sends CHECK POWER MODE
> to ATAPI devices, including the QEMU DVD-ROM, which rejects it.
> 
> Run the existing taskfile initialization and device-class check first,
> as the active-power path already does.
> 
> [...]

Applied to libata/linux.git (for-7.4-fixes), thanks!

[1/1] ata: libata-core: Check device support before querying power state
      https://git.kernel.org/libata/linux/c/ec585ac7

Kind regards,
Niklas

