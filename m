Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173312;
	b=BWNNouH5umGCWEUm2ZD7dLZS47giRaKmUFYCAeIFbv2ps8KArqsDsoxUkZRyhS/b4dia
	 N8Qx2wNo2NbSpK56gnNPzHg6D6Ysru3MioQgEB1N6g07aC9Lz7VipND9MjqI0RFNDaCY4
	 57RD/xUPOIaUsc1PKWgmIIecKGnfR1eKYt4LzzUbO63nsshL+EVgly+TVFZTKEJQqCDSV
	 0YA1AMt3LTFgT9Kl/Z+xdcAVkPa+BlhQ1PRIpTXp678Wrhq7DFKPs0smd+7QdjsmsLj79
	 KNweb0NjZtxMLtm36mfUUEnwIrXr32mDv8b6iF+Tu7CySPoY4E+pfGPekIa7zGOa8sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173312;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SLq3wgPkajqtPItPQZltQVAtBVgMeKg/H0P+C3b2xrw=;
	b=zZNKeHiFdALvIUoLS6Czab9Gs0G87lmp0mUAo9RzUjWXb1pbGBp2eixk2PVvyYpsDTPN
	 x439Kx2gFYNGiGEYv7Cx//CqWU775dlf7u/7CtUh8cZ8AIL3uelWnjJ07Q/hWiPX88YL9
	 Fyo9/vK8+UEn2241dsB2oUL7wcqnTQ7CG/9VgW6KdCziWZDsd+xtro4g/cxWCCyQxX/Ls
	 nSH4qnqbplWWA0IOgI2AmxPKko8zWW0FzFRxe9qIu3sIdI14S4L15L1Ci2e+aFwMiQVez
	 n21OWYxIo+uhyR2bDfHA2uOfHiCUOLDjIt4GuLSRK4JUbLYiOL5oa38IsglkapXrsFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0rCTmI3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801D606A325
	for <linux-ide@vger.kernel.org>; Fri, 20 Nov 2026 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0rCTmI3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BAD1F000C4;
	Fri, 20 Nov 2026 11:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173312;
	bh=SLq3wgPkajqtPItPQZltQVAtBVgMeKg/H0P+C3b2xrw=;
	h=From:To:Cc:Subject:Date;
	b=J0rCTmI3oprIUxQPNfn59aPK20WjewGKbuABoRGoLoDIblF7TWhgwWfWI0ZyUm8dZ
	 n61k1uBV7F4tkCqLrvdBv2PkGPeGMC/iRnNxIYiJ51KTCXY1DkACaM/BCqj2/fi8JO
	 2oHB8v0eJvk2ZJ2S868V2DXeoYXGeWZE3lovwRSvMGGaCwWXKjz1hpkncwKby0LzxQ
	 nqsYSP7lLF2hP/Gcva/M8+y1UQbWanvWC1k939SM/Mjk810arkN3K3PhrFFUqDregt
	 4UCOvwL+rP2+FQBLXwBalcDlMJ2uXPC6kDI3aPaMNFc7HH+mZsGOc1NJVTJtmcVjfc
	 scK2xc7KsRLZg==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.4-rc4
Date: Fri, 20 Nov 2026 12:14:54 +0100
Message-ID: <20261120111454.276280-1-cassel@kernel.org>
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

The following changes since commit a4845f077415ef32fe672c841e2fc58ae9e28273:

  ata: libata-scsi: reject data-in commands with a data-out buffer (2026-11-07 14:35:25 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc4

for you to fetch changes up to a12cc63129380a5364e787d92b30a3257f66c250:

  ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8 (2026-11-17 13:56:12 +0100)

----------------------------------------------------------------
ata fixes for 7.4-rc4

 - Fix an off-by-one in the REMOVE ELEMENT AND TRUNCATE translation,
   which asked the device for one block more than requested (Nick)

 - Fix the INC_512 bit test in the SECURITY PROTOCOL IN/OUT
   translation, which treated lengths in 512-byte units as bytes (me)

 - Limit max_sectors to 8191 on the INTEL SSDSCKKB240G8 SSD to avoid
   NCQ command timeouts (Justinien)

----------------------------------------------------------------
Justinien Bouron (1):
      ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8

Nick Spooner (1):
      ata: libata-scsi: fix REQUESTED MAX LBA field for REMOVE ELEMENT AND TRUNCATE

Niklas Cassel (1):
      ata: libata-scsi: fix the INC_512 bit test for SECURITY PROTOCOL IN/OUT

 drivers/ata/libata-core.c | 3 +++
 drivers/ata/libata-scsi.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)
