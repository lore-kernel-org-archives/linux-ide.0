Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDE14E2CF
	for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721730848; cv=none; b=pVDdWk6zkjbNJYxKzqNhHNLyGBTRy7pWQ5f08jxAEaib/MRtPosBye48KD9yn4illDHkAj33kAz7tnmcHYVzDZgoiqgECf7jQJuOtv3D6dGSAZIGpQtt5kQ189Ms8nqK9z4qxZrHMVB7r7TT9DdTEo8Jy2bQPkR8hYnpNPr7BR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721730848; c=relaxed/simple;
	bh=+lRFPK+Fn1oUj9kL5OHH52myvclJaOXVcptvxpAFzYw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Mda0cdzqWgayHX2ixpqI30Q8g6FwWYwPnqfw1/yY+zTrkyRNn2LR3O1PtRT1dUpvGWhCXSQPmCiRDC/EhODtHkIUbvs4pWtqnsJf8+rNs6jVFoNm4VNWOZOXtCzNL9JLoOkP5Cfj1SYKP3OnD5aq2CUhK1pifcAimvhfQZ99RcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPZdpfao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPZdpfao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54D1C4AF09;
	Tue, 23 Jul 2024 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721730848;
	bh=+lRFPK+Fn1oUj9kL5OHH52myvclJaOXVcptvxpAFzYw=;
	h=From:To:Subject:Date:From;
	b=nPZdpfaoh0Eoe3pb4FIzRkpal/4IAN+2YOypjNic0Td4wQji8Y0ffwxo/VZUplEWF
	 oKRm53koua4qGLINg3RIx9QTeRvDK/LJ7Bvlzb7qbyWqduQ62tB0hyCxODgyHYqtHI
	 7jueorQ3hFEI/diWxRZpHf+zsI5hZfWGKY1F/p5IZ7+IgzASmiY1sxzcfB+22Df35n
	 AvG6uHNs+BNubPMmUugDUDi38gk/QMKbXt3AAvp+bk21dxH8OMCOQu38HgExf8x4rE
	 gEyN7d9h5ibwUbnzMnetf2xv/rlewEQ8qvKtpV6OtOwMYu7H655GS0+tu2guwvggjD
	 i6+p+sZuvoa2A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 0/3] Some renaming and horkage improvements
Date: Tue, 23 Jul 2024 19:34:03 +0900
Message-ID: <20240723103406.294462-1-dlemoal@kernel.org>
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

Changes from v3:
 - Corrected the BUILD_BUG_ON() call in patch 3
 - Corrected alignment of horkage definition comments in patch 3

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

