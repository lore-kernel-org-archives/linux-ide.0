Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795775596;
	b=yDW7XaJJYRTtwJmmeyqNqfh8nm+0wlVFKGbD9YG5R1i0d6EEVtsSbK19eDI5u4RwkltC
	 qQqeLL69E8VUW9/efxlakDl4jhxR3s3DjACbxCUaoLDIsHwwQNnkTLhU+QFWKTudUrSOs
	 7zfzNJ28nT0wryHda2RrJE1QJ/oRP097JU2I1Mww2lt49tFNf40pQ9Qne3Rh5Jo0JkMuS
	 q6+Q0ZS0muKX2E7qwK0BWc6KmzC7OYpB3jjOy8rv1RRXuFZ7rDvD23Lvf9JYhgkluBBdj
	 u5LNoZsqdc8AsaEAgtBUjG/ThXydl0jcNV2QkCHujOitxlmYZKvCDi6Y9FGAyvPVK7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=J03SBzZ1N6VZdFq1xbRh0Z/SeO+Jv70Flx+cKdGB2zw=;
	b=g/X3XqNZUNXvIvZJsZMij5IG/o0jEGNLV4naCIPe1wW9tYPBEhTpOUmUTlwkbzmjMtnx
	 r5gs6jbga39DAWsATWw6da0R7y9r5pAT7nAXC7hSeaHLnbt911hPGZtNajvCC5DpnofL2
	 GOSTu0cuGTF7SxzxVAnRZMKzzU9Ag2gfshP80gxBQzy8fyMyhpvusU+ck+fbCmnB/HxOb
	 c5llinUnHbcZedwS/nTK1mPRqpMQyHIaRasNwFEiAGa0l3N+Xo7N1dm32XP6x1+6eB+BB
	 vpDen/pTmgRvFiePPvI8f9oI4UFC24NhDvW7wYq5V6XYIsjr+aeR05X+vcV/ohJLdIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kU8ZPBob;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841D606A31C
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kU8ZPBob
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DCB1F00893;
	Fri, 27 Nov 2026 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775596;
	bh=J03SBzZ1N6VZdFq1xbRh0Z/SeO+Jv70Flx+cKdGB2zw=;
	h=From:To:Cc:Subject:Date;
	b=kU8ZPBob0BRRuLPwaafqCyvKRJj6nzofCVkZWsGQcc0zAjzwyBbhZU+YlW7jevDb0
	 ve7C0QEDdUaRn9u6/Xu8m0chf/S/X7Pp75u1nC6g6q50HSgOAsCl/TmT/4oZYowm1l
	 /XFB7qop87uvTJFnx/AIRLlzacb/NJIiS+KQ4CYwqeTZnES9TMsdjWpMf2Mtz4mQFS
	 raaR/9ZxugSFBRpHNedkVjiKtzs+D6Adyh9sujGpcRF2vmRzF1v7DIHQoUOCMN4nVy
	 h9tCr4tEaJYSTHYJe5gRR6ySrVk9RPmEebOx243zgjuf6hIVSa/HhIqFZGXFyR9TxU
	 ZQW5L2Q4kfDug==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fix for 7.4-rc5
Date: Fri, 27 Nov 2026 11:33:10 +0100
Message-ID: <20261127103310.3005442-1-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit a12cc63129380a5364e787d92b30a3257f66c250:

  ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8 (2026-11-17 13:56:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc5

for you to fetch changes up to eca06bf5923526338291ef62501b359596d2ac9d:

  ata: libata-core: Disable LPM on ADATA SU650 with firmware XD0R3C0F (2026-11-27 09:22:00 +0100)

----------------------------------------------------------------
ata fix for 7.4-rc5

 - Quirk the ADATA SU650 SSD with NOLPM due to its defective link
   power management (me)

----------------------------------------------------------------
Niklas Cassel (1):
      ata: libata-core: Disable LPM on ADATA SU650 with firmware XD0R3C0F

 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)
