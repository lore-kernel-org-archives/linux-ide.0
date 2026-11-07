Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794054438;
	b=mrdCvzQBfWp79hlSgOu8eL8kurSkZ2a7hxnrZAojUHrHwcLvELN7xZ6WIk/XSWHlg3wl
	 N/8uBmfcHM7f51cTmU/GNe8Je3fpI6m1nqCR0bsdLzLtSA9qli46hVtu6hh3+xXdz5PGk
	 XIAjBFXzFihHyZ0IyyVZRATtUfgMRrLXynfL0oC/dy3uBfRciqDrX0Ss8SDw2/1+3E8GZ
	 SYZv9jBYWAXNP1pV9pwyYWv2siMP7JTIjZpJxmerCXhMzweBXJZ4CEaR1WN45Bn4JIvDS
	 4VMy76nrkWWFV3UsXSj3SbMbwtXbpwbJI3XsbSq9ts769Z6nBKZ5bTWhDIrYo5bJmrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054438;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=QQCTKdcd1ecR5j1kfgc1gthhf7pvFfj5JD9U1a0aRxI=;
	b=oVg8K64hhTWMhxEvkRVXUvdLSO33COKGJaubC/Z/meGaLFaw6qFWFauEd3IR3bLRtw/s
	 L4bA5l5UUfKfZQb4bU9dWyrOjF52MK/duYYXVG3SIOwnW3NJc4dxN8hF8fT31LohfSa1/
	 ABY0UUPe1maxv0dLShBMEIT1gG2/kMD/7O2SQu9WXYxuarlj8g6aRo3o/J0/fUYDO2/n7
	 Jxw7NOQSOtn6UJ3KyPJP7L8q+mvcT+5Oyibjrjh6A0d3fNqEy8m8C4DGGMn/fU5+8fbl0
	 LttSpnCevbpv3vDUVI37gtv+nCGSfxLXBa+vINc6/f52I1cEexd576B8ez9YjiSAc0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpIpFrMV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA836606A32C
	for <linux-ide@vger.kernel.org>; Sat,  7 Nov 2026 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpIpFrMV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3952A1F0089F;
	Sat,  7 Nov 2026 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054437;
	bh=QQCTKdcd1ecR5j1kfgc1gthhf7pvFfj5JD9U1a0aRxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mpIpFrMV40Y3RDmB8bPQ8rEBG2bwk2Gl+vNzYpAkh8pVQV440x5ENqdySueK7ZHAp
	 N8gMvRRxQwG5dkgRMXbve9CV0AaV/r30yoFkymXtPgrS5hpUCNVhr8upwOlL1yh1QK
	 Jv4CNKV8MVzpBabtILJVVDR6RizbldFVEL9izo7M2iIiGCx6YPCFy+EZtObbI8FLLr
	 JAYHKRt4b9+fTM/dKa+gA/i6Z1sOXXde/f3CeDWT4jO/5D9x7dHzbG+j4Qr9Z3ypWD
	 tK22Y5+o7N6aJ9qfEW2oYjrec5rXnp5YyEl+yb7SScYKFnRqUi0q3o6kOZz2UMCcLx
	 Wy+Mery4Hcffg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: (subset) [PATCH 0/8] ata: libata-scsi: MODE SELECT fixes and cleanups
Date: Sat,  7 Nov 2026 13:27:10 +0100
Message-ID: <179405431037.928477.10767362848113156987.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103205448.931471-10-cassel@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=654; i=cassel@kernel.org; h=from:subject:message-id; bh=ftXhFsnP9AZvWyzEzDVCc+koVkq9zAYFQLLIoiRtNg0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLeS8rNnyrKpu35xem/nr7qW+M2CYay7k33j0703ftKt mQqj3dXRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbC+5rhr5Doy1WqMYYB1y0C BFe3PHYV0fjLtXvh+e+rj3w35ou+v4WR4cfhR2HFJt0MHe9tqjsb/y1oTeBzdekItP9vXPe2sUS JEwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Tue, 03 Nov 2026 21:54:49 +0100, Niklas Cassel wrote:
> This series fixes several problems in the MODE SELECT translation of
> libata, most of them related to the FIELD POINTER reported in the sense
> data when a MODE SELECT parameter list is rejected, and makes the MODE
> SELECT mode page handlers significantly easier to follow.
> 
> 
> Most of these bugs were caused by the code being more complicated than
> it needs to be.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[8/8] ata: libata-scsi: document the MODE SENSE mode page functions
      https://git.kernel.org/libata/linux/c/8e23563b

Kind regards,
Niklas
