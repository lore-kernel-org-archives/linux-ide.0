Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4670306D5E
	for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991860; cv=none; b=JVuE85W+gG3GnL2X3y52R5NuzOUI6wKHHs75+oYYBTJyLrDyrajFxCuxyUNpy8tSL6eZXKHOdykzqOMNPyANf69LXWmAAGgzf4cdtLNjE4jINdlfZeyqKWxedbHmQLX07qmaM4GtonaPWYkQp1kCWZlcNxqCVvbxYvLmi/vRydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991860; c=relaxed/simple;
	bh=rai9lz/EjIl2+w9W0WsUsWwpVIvCKeTvObbGECTmuLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UK+N6HqpvC/Se/0CLvALK2UTcwRwoyynB6KHvS7+Z6DigIaDY0n+/cSVCbDWqwPp72EuBQOcBQpuAPgmBveoeetPQNbF/ebxrZvjhaot4qxu59eBezTXdtjk1z4DS4m9WcnH0S4hgcJTnpymdqJfDn9WIMsHhWv0O28pPiVe1XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZDvO8aS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZDvO8aS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A099C4CEF1;
	Mon, 24 Nov 2025 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763991860;
	bh=rai9lz/EjIl2+w9W0WsUsWwpVIvCKeTvObbGECTmuLo=;
	h=From:To:Cc:Subject:Date:From;
	b=cZDvO8aS9+sk2SkZ6/z+EUamdgK78BlhoSu4LQd03bD2IEzEn5gQmpZAfoUZPErSU
	 jN2KI+uTGIT+nxMF35EAMSeRWOSF6YPIgnWoj7uSx2FU9SPV9pg/mMq9vZw3MPEBz/
	 ut+0AhHDEyNujABkvhxV7saFilaYYoipeWgJQA3CDqHyyOHCTxIWfNDXUfDDH4wF1z
	 Z7kqXM3AuY7biv8N21rezTPNrrAlQ2GMPIp/o5ZKDqW/QphDQjjSmHRHWKKRSC6he3
	 hxonhNpS5pW36aFGT+9EdsNWU/pYh2MZ6WrDPwOqMW9ykZyLOaKyOLh2rMbHlBDoS0
	 T7/TZyvemXi5g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/3] ata: libata: Quirk DELLBOSS VD MV.R00-0 max_sectors
Date: Mon, 24 Nov 2025 14:44:15 +0100
Message-ID: <20251124134414.3057512-5-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=cassel@kernel.org; h=from:subject; bh=rai9lz/EjIl2+w9W0WsUsWwpVIvCKeTvObbGECTmuLo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJVEvU+bp37WvuTXEr//8umkzyWbltnUa9+6Nua/oed8 +/9l9T43FHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJrIth+O819U/tkqfLP9TP lNNI8Qx1yfq/wUj32oGOMz2Ly3w5xZcz/LPraWO6xqrX67rR9/6C0LfP5DK+bpvmt/ZfjcrHX8n vkvgB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

a recent change:
9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")

bumped the default max_sectors_kb from 1280 to 4096.

It seems like a lot for SATA controllers are buggy and don't really like
this, see:
https://bugzilla.kernel.org/show_bug.cgi?id=220693

For now, we only add a DELLBOSS VD MV.R00-0 max_sectors quirk, but surely
more quirks are coming, so change libata-core to allow for more quirks,
since after this change, all quirks bits are used.


Niklas Cassel (3):
  ata: libata: Move quirk flags to their own enum
  ata: libata-core: Quirk DELLBOSS VD MV.R00-0 max_sectors
  ata: libata: Allow more quirks

 drivers/ata/libata-core.c | 16 +++++++-
 include/linux/ata.h       |  1 +
 include/linux/libata.h    | 81 +++++++++++++++++++++------------------
 3 files changed, 58 insertions(+), 40 deletions(-)

-- 
2.52.0

