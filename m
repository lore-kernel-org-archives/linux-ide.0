Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725837756D;
	Wed,  4 Mar 2026 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612282; cv=none; b=DLdFuo8yywYlNvAXdCLY7jAcBEcDX3UrDb2w13tHjGVeGCxgrgwoFUxrrUWJ8zpPF3P1pl7vnGA1gCQ+Sw7u6F1xKe4qsHtLV2H13tRcQ5phet9f61CxcsPvirp16x+BVkZFFHMZyZdsIDWugYsYjAS9ORbgyCQnYikWrOWUiDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612282; c=relaxed/simple;
	bh=jB6EG8zM9cClcjGbR/URlXpWtJ5n5nW97udxvK0TUi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QAAXV1CFhgErjoTeoYv4u5gfY8lt+XdaSQr+IMxq1z5c65yNx1K4UFUqH4bBonNYvRvD3Dah/+FehccpvnuiBBIo9T52fWdeTZoYl3jnaXnri2EUbgtp1V4fhASiQOFKSFzqLPHQCIZhFfnRYoqr7H12iC5NoxltshCx1+LBzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ3SWGWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ3SWGWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9FCC19423;
	Wed,  4 Mar 2026 08:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772612281;
	bh=jB6EG8zM9cClcjGbR/URlXpWtJ5n5nW97udxvK0TUi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sZ3SWGWscMsCLMqxEtN9wwElS3E7VpfqUviMgcLrXwQ16f4qa6hChU44rSYpIMOk/
	 PruxYkIi7uO2g2Rs+EdKYcf1XTzRQkaI3B1fZSBR0Cl8TCVrPZR0Nq49WmlCZOXCYp
	 s0Gm5ATT5njADB8ZU2Idn44uTZnwU8AgmOqzhGDvxsGkJH4um+5xXZqytaacyB3RRd
	 UJYCiB2/pnzodo2dpKiPd/B5y8KMXLTZfbpU5RmmkHGlnECyYn3uRdMBIbZ6mtp4yf
	 iYT3xSE1L2VEDBwbiNoj/Cfj+miPLW+PqSNprH2KcbcdE4Z4DjQAabuqYuk1TQa7il
	 fMWk62TxaxUyg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>
In-Reply-To: <20260304-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-v2-1-607f8e157ad2@gmail.com>
References: <20260304-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-v2-1-607f8e157ad2@gmail.com>
Subject: Re: [PATCH v2] ata: libata-core: Disable LPM on ST1000DM010-2EP102
Message-Id: <177261228062.505612.16390130154277571188.b4-ty@kernel.org>
Date: Wed, 04 Mar 2026 09:18:00 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 04 Mar 2026 08:22:59 +0100, Maximilian Pezzullo wrote:
> According to a user report, the ST1000DM010-2EP102 has problems with LPM,
> causing random system freezes since kernel 6.15. The drive belongs to the
> same BarraCuda family as the ST2000DM008-2FR102 which has the same issue.
> 
> 

Applied to local tree (libata-for-7.0-fixes), thanks!

[1/1] ata: libata-core: Disable LPM on ST1000DM010-2EP102
      commit: b3b1d3ae1d87bc9398fb715c945968bf4c75a09a

Kind regards,
Niklas

