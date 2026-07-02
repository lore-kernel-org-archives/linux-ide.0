Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A9381E9E;
	Thu,  2 Jul 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004037; cv=none; b=T0KFzCuHFFz4VejgoKddIDQJ2e5/aDpVgGDBF22+BhcIb4YgN5uyqCXyL8rZNSAJgU794v7JixVkH/pYqucax5NGg4KPHm2ooYqbdlFg6b5UM87mydYJJDa0knaD/cjFpXpAy7N4NQEKFQfUfKiRT1T23VSp3mU3Fo88FaTmCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004037; c=relaxed/simple;
	bh=W0FsYO2MmhuI365Yl1nDAt2N2+RUPahN/oCWeJ/JNUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5jh2LXFKfAHqw5k7kWymMEUw6wDh4qVUtNZIPSZRNYNP1nKKDyrnPHXpR6fZwrtDCrp1qJf9eL2ePapgWJX32AHb7DGhts8h+KARoUI7UQmgOcLzrilu0Up9UkzSTrnubT9kfJbvTN255oexwjt195+UlGo3nHRe1yUbwwwk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7kZwZNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7kZwZNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD3C1F000E9;
	Thu,  2 Jul 2026 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783004036;
	bh=A/DbaIrbCPNIwgx4mqYaTLpUHtEn1UX/46H0Iotl1BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e7kZwZNtL9j/cQtQ0vmWvucNiieUPQSSsB2dn+RSgeW7iw71XmlwKQlPDp28xV3qg
	 bVDM1Zht/7ff1JAbO0L7ydQRhzB1HWYMhTHQ9ftKyD6Fhlb5LkiS8DhnAJBL5KhFYe
	 VB/Kt7KC34x7mVjTDMTbvHr7vMs10RerwGYw5NhUu43aEruNc1ibcaFS6X3W2XegMI
	 NkDinwskKDmgtupLzigiqtoJBk5b/Yb62eEcTBNkkiLb5Ir4ePudrbKaxm9mmP5Sbl
	 mCMytu6KoR6SH79hAQlJcdTcFY5GwjBv7IS71kIY5KDCv6A/1dVqDmCOGc4WSvKIZN
	 1QHIld2FL+ecg==
Date: Thu, 2 Jul 2026 16:53:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sashiko-reviews@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
Message-ID: <akZ7getxFWS7dYpe@ryzen>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-3-dlemoal@kernel.org>
 <20260702065321.07EB51F000E9@smtp.kernel.org>
 <akZmx5L1HLsb7-wk@ryzen>
 <akZ3gQq8w57IWCIC@ryzen>
 <20260702144816.GA25399@lst.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702144816.GA25399@lst.de>

On Thu, Jul 02, 2026 at 04:48:16PM +0200, Christoph Hellwig wrote:
> Who still cares about TRIM on ATA these days to bother with any
> of this?
> 

Have you not heard, ATA SSDs are coming back:
https://www.tomshardware.com/pc-components/ssds/sandisk-brings-back-affordable-storage-to-rescue-buyers-from-the-ssd-crisis-new-320-and-520-sata-ssds-are-ready-to-launch

:)


Seriously though, was mostly interested to hear you opinion
wrt. if WRITE SAME (16) should be exposed in REPORT SUPPORTED OPERATION CODES.

But with all the information I have, I still think it is better to just
continue to using WRITE SAME (16) internally as an intermediate command
for REQ_OP_DISCARD, and not expose support in REPORT SUPPORTED OPERATION CODES.


Kind regards,
Niklas

