Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90972E173D
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990009; cv=none; b=I4xjgRWF+aT1mfNAH2jlUwyniYj/91HelWprPStj5WVq0MVio4pQYLowD7VWft2cBJD6SqbGihoRCgRnEPjhL6YD0F6zUAP28TmieffZCXDTBH9i43gEkhRQ7RgVmf8yLOn8xd9eoxbkEyudd1iyh1IZ5kWExPDLwjLRN/Fs5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990009; c=relaxed/simple;
	bh=tL6jvz0706CtS1ALC8RqJ7vkHadWCNZCMcXMraSdp0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5D7f/36Xvo3KUO0A7YUlP1e9OqXoTB7w65KWqS/jCRfpkLk5nWw6DbKQIzoNciGrbmsVuZRqaEbDwZY/oZVJq5WiqnH596zTMT68uqjkXuf1rHfc7N+qnfekJO5/sav2gXGzBfgMad5OHVoBHb1IzE//7wUJTIIAyTkBe/l6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHMIuXfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHMIuXfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F42C1F000E9;
	Thu,  2 Jul 2026 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782990008;
	bh=U2Ky8hw166/7doQSfe10ctGWGbmNVASGP9Exo2I7DjU=;
	h=From:To:Cc:Subject:Date;
	b=fHMIuXfHWgnMI6PMkvwOFpw+lJTyNRxNkKid03uIvF+3R8OsllaTx5zDr1lQMDmyG
	 aRFGcsycSI0Hcv4QcG69+R1TzDj8QzuuDBw3Y2h6qqPiaDWPBk3FJW2pY3wgb+UIqH
	 txkQa/ZmeXCe3/mCopWYHo3AE/a4niaHT/022yqigmDCSvfJeGTdGWvIj1x8UNrOjE
	 nCrHmGkyEY9fEAd39VT+E/Uvwi7XMTKsyfxvLjNJKr7IDUkmhGi2YPmyOyivjg8a+Q
	 O/7rrrGkAa95vEywBE84S3cFDkh5hPhT8+T25+jUrN9Q+EvMfTXlihcx7Pi2t+ZnYq
	 QF9Ji2js4kO9A==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Shaun Tancheff <shaun@tancheff.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 0/2] ata: DSM TRIM fix and improvements
Date: Thu,  2 Jul 2026 12:59:57 +0200
Message-ID: <20260702105956.2058733-4-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=cassel@kernel.org; h=from:subject; bh=tL6jvz0706CtS1ALC8RqJ7vkHadWCNZCMcXMraSdp0E=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLcXNbkWb+8vv9I5+r3biv6On6ccr3y6sY1yRMPdggGn X22lGWeSUcpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAm8tmEkeGO/vMA1jlcNkVJ L3i2lpmU5J+rLdWdevzbVT2bhwV6RqyMDEe/fS/YyLrqwku7eWZnjA8v11VdLeq3cIu/xD/Xrvs Tw7kB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

This fixes DSM TRIM for 4Kn devices, which has ironically been broken
since commit ef2d7392c4ec ("libata: SCT Write Same / DSM Trim"), which
claimed to correct the DSM TRIM handling for 4Kn devices.


The first commit is a small fix that can be backported, which limits
the DSM TRIM to what we currently report in the Block Limits VPD page.
We currently report a single 512 byte page of entries, i.e. 64 Entries,
where each entry has a maximum of U16_MAX logical blocks.

The second commit:
-Improves the support by reading the MAX PAGES PER DSM COMMAND limit and
 populates the Block Limits VPD page accordingly.
-Modifies ata_scsi_write_same_xlat() to properly support up to this amount
 of pages.
-Removed the intermediate copying to ata_scsi_rbuf, writes to the scsi
 buffer directly.

Practically, sd still caps n_block at SD_MAX_WS16_BLOCKS
(~3 pages actually used on 4Kn), so while removing the limit on
ATA_SCSI_RBUF_SIZE (2048) - i.e. 4 pages), we will still be limited
by SD_MAX_WS16_BLOCKS. The main improvement is not longer taking the
ata_scsi_rbuf_lock and doing and extra copy from ata_scsi_rbuf.


Changes since v2:
-Use min_not_zero() instead of min() to guard against a device reporting
 an invalid sector size.


Niklas Cassel (2):
  ata: libata-scsi: fix DSM TRIM for sector sizes larger than 2048 bytes
  ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND

 drivers/ata/libata-scsi.c | 137 ++++++++++++++++++++++++++------------
 include/linux/ata.h       |  13 ++++
 2 files changed, 108 insertions(+), 42 deletions(-)

-- 
2.55.0

