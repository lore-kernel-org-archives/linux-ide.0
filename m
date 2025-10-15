Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5132548A
	for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553142; cv=none; b=mYxNhcISP0v6DIMInx1x2X2YaW4XOBhUnYBDmmzNpfV+XdMh5juzNZne8hw1+mo4ue06nm8psOWYnKN6WsEXadhcsYWkOJ72PPjwjKKfMzD7kY2JzUfo3Q/m9sxDlaK+7/mm8G8GUFakJC32DrpDFHfMsr+29AEpqS5CdLiZ32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553142; c=relaxed/simple;
	bh=Xg0kfOaVmKQb5vXp/R3N7GDXiKmaJE32n4XlgLJuvl8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Cc:Subject; b=lBADTH5JScbai55U7iC+uCd77xV3jFUTPaATBGfkhWZ0G0q/q92yxqK5LnAAF/tB8IVUO7nvqNLMpcxt3bQ/b/UxY2/BvBXBvobJNoWq3McyaPiGe906HwJ9QfLXfoSkAS3n5A16JDyXVfft7z0ID3MbIdMT/+m6rv8X1V3p56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=b/enlOv2; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="b/enlOv2"
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1760550993; x=1761850993;
	bh=RvEBzMd7zweWM2+y9IOBEai6jh+ElBzYuwvTQCqwKRI=; h=From;
	b=b/enlOv2EpXxw0VySP1du2ef5DfBEYuJPvuAFChdy2B24IzxeMc86BKxGfdWwBkFI
	 Jo1PBzTs1maar+kVLgISnrX2R7ErT3yMtrHlba5FOTUiUcJkkoc3sUFeb6Zh76NVKz
	 PcGYPYpSDtzfIZiJdc9k9vDA0xl3vqYKgLc4cEt0A51WhmyZ3qay70VJzkXY+Tam2/
	 p36jg/aYsj1VQUxN3/tzqkEnKV+W3aIIDk9PqAWHhasrsmFTdIN9r6R5Ci/WJzWs8m
	 v+NHcsGhhCum23qkX/UeXWYiC2vALK9H17Ca3OY6TduLs5lc3XGlYcw8C1mREkpdMY
	 sRByckz2NoZhg==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 59FHuV2d052702
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 19:56:32 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:56:31 +0200
Message-Id: <DDJ38NYG2CVM.1DZTADYTDITT8@matfyz.cz>
To: <dlemoal@kernel.org>, <cassel@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: <linux-ide@vger.kernel.org>
Subject: invalid log directory version error

Hello,

ever since updating to kernel v6.17, I have been getting

	ata2.00: Invalid log directory version 0x0000

errors (one upon every boot).

I have not bisected the issue but it seems that the guilty ata_dev_err()
call was introduced in 6d4405b16d37 and by the looks of that it is more
likely just an uncovering of an existing issue rather than a new
problem.

I have not been seeing any functional regressions (which along with the
above is why I'm not marking this as a regression) but error is an error
so I'm wondering whether there is anything to fix (or maybe just tone
down the log level?).

Please let me know, I can also test patches and if necessary, try to
perform the bisect.

The disk referred to as ata2.00 above should be Samsung SSD 840, here
are all related dmesg messages:

	[    1.406544] ata2.00: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
	[    1.411861] ata2.00: Model 'Samsung SSD 840 Series', rev 'DXT07B0Q', ap=
plying quirks: noncqtrim zeroaftertrim
	[    1.412014] ata2.00: ATA-9: Samsung SSD 840 Series, DXT07B0Q, max UDMA/=
133
	[    1.412019] ata2.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 0/32=
)
	[    1.413802] ata2.00: Features: Dev-Sleep DIPM
	[    1.417160] ata2.00: Invalid log directory version 0x0000
	[    1.417218] ata2.00: configured for UDMA/133
	[    1.449749] ata2.00: Enabling discard_zeroes_data
	[    1.457968] ata2.00: Enabling discard_zeroes_data

Thank you and best regards,
K. B.
