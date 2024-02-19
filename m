Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9B28DC3
	for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339709; cv=none; b=Ke8kMzCjVvVnpVDfRhoqi2qSCoNQHLzthPHdTWbUszkQ7tFOoJUwI40bVbwHxirdZDBBNAVrvEcMt2xWUR0tsEEzAzyA4alHZiS9BZL7+r4yH4n6b8dbfDjVsJ8xrqvcY+ePncilxDAm075BbGRF7q2+pV2o7vBfZ85FHsHuFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339709; c=relaxed/simple;
	bh=tYnkBQCmHFYwhC4f1QIN4f9ELSnnZ40rpTsXXNcjgzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJzZLSmng7H6HHhGaqzXFjstd7zse+zp5FXzqka3NDm4lFACmCQHAK17QIoOQtWnCxRhbKFASa1Ql0WRutJowQeSiW6uR68zaJpnUG9Ht4/bgR+iG0nun9/XdJSGcXi0FewHnSqI5LkezZ/AbN9U7Nd64uQRCaKC83zyOzvE52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyVT45IS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyVT45IS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C38AC433F1;
	Mon, 19 Feb 2024 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708339708;
	bh=tYnkBQCmHFYwhC4f1QIN4f9ELSnnZ40rpTsXXNcjgzE=;
	h=From:To:Cc:Subject:Date:From;
	b=uyVT45IS9TjKbdA/HWQgFmTARIz3Wnknsgd5ixWw77rNPmUuanxxO+jDc0eG7/OhM
	 aVp5x9dISO5G3EDC/ieyRGeOOqxNRFLzzDbL1c1Mod62akskO3xY7LffnlTA9W4DOX
	 Jwm3ifNDH7cA96WmhhM9kUoDUlo1fXBfquSKXWVVo5DrO9kROEBqlfLwd0TuMC9MFT
	 MA0DQmdpBsk+7G/NnUwNnD+jJlRBSjyuCOZUyZKpEy/dEbqt0oI7SNIDRZYTdUYA0g
	 DdoudwezArD3na0aL81l5VHJYbTlG9P7FXh/qB0xpnyRhF1eudIpXPmsRTkU/gFkUG
	 d0yXDyoR4+HUw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Andrey Melnikov <temnota.am@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ahci: print the number of implemented ports
Date: Mon, 19 Feb 2024 11:48:17 +0100
Message-ID: <20240219104818.1265138-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are currently printing the CAP.NP field.
CAP.NP is a 0's based value indicating the maximum number of ports
supported by the HBA silicon. Note that the number of ports indicated
in this field may be more than the number of ports indicated in the
PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
Offset 00h: CAP – HBA Capabilities.)

Print the port_map instead, which is the value read by the PI (ports
implemented) register (after fixups).

PI (ports implemented) register is a field that has a bit set to '1'
if that specific port is implemented. This register is allowed to have
zeroes mixed with ones, i.e. a port in the middle is allowed to be
unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI – Ports
Implemented.)

Fix the libata print to only print the number of implemented ports,
instead of the theoretical number of ports supported by the HBA.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since V1:
-Use hweight32(). Thank you Sergei.

 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index fca376f03c9e..ef31d234e7b6 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2630,7 +2630,7 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
 		vers & 0xff,
 
 		((cap >> 8) & 0x1f) + 1,
-		(cap & 0x1f) + 1,
+		hweight32(impl),
 		speed_s,
 		impl,
 		scc_s);
-- 
2.43.2

