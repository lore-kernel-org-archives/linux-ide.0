Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD237EA
	for <linux-ide@vger.kernel.org>; Sun, 24 Dec 2023 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eijdud67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42523C433C7;
	Sun, 24 Dec 2023 00:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703379333;
	bh=QY8rtlOhkjyuU/Yozkt/39xMLtOpih1iyL8WLjzmXTo=;
	h=From:To:Cc:Subject:Date:From;
	b=Eijdud67NoENCP0NruzXDKQvsQeJyPITjfru7UPy/DWuul4OsMYcMNB0T6kHRUTih
	 HRxrdyHd97n4r24q6Q31PTiMbTxgeDgk/kimwJ6EzZkMHD/PEiEAdEh9TiEv7A/E8d
	 BSfHNHLJT3DiQgyJMstdM4f63S+SYiYowylmjA2iR+nO/7UhVUm7hudkeiB/jHU1CI
	 ec2meTDjP2zRz83M+vdFuwStwhmLqIisK8JorPxlYFcXZo+NFDvGUoHvPDMCk4m8c+
	 YEH5uLfyDjEz0swYSEYzNe9Xmht9wIi32SPsw5fYox5ohkWxX6qEdbDNyTWc0joD9d
	 mfKVFgDjwaqjg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] MAINTAINERS: Add Niklas Cassel as libata maintainer
Date: Sun, 24 Dec 2023 09:55:31 +0900
Message-ID: <20231224005531.33788-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Niklas as co-maintainer of the ata subsystem (aka libata). The new
shared tree for libata will now "pub/scm/linux/kernel/git/libata/linux"
on kernel.org GIT.

Niklas and I will alternate maintainership every release.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af79..28f407afd9cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12154,9 +12154,10 @@ F:	drivers/ata/sata_promise.*
 
 LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
 M:	Damien Le Moal <dlemoal@kernel.org>
+M:	Niklas Cassel <cassel@kernel.org>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git
 F:	Documentation/ABI/testing/sysfs-ata
 F:	Documentation/devicetree/bindings/ata/
 F:	drivers/ata/
-- 
2.43.0

