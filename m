Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6834779A9;
	Tue, 22 Sep 2026 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082291; cv=none; b=GGXT+lc1sMKBPK8pD7lBlUH45RPGCgB2WOesF3xY1ar7vy3ZodYXENWo78rfE5HLFl1GJA/EvwhAEyK8YkQyDc+qZzCWO03dmYeoOc5lGjq2N5YAO+8QXDdoF/3GzwKUcTbcIbPSTU5WnsmlYOixAcEtZ+IVe2mZdSrfN9mrd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082291; c=relaxed/simple;
	bh=7+937kplrwaxShVkI+uzrILVA3S+f5DSYWARpji+ipU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EjUxuSN2AsYjrR06fQ6sFTkGnhXjUYH9dUFmY0IZUWUvmG/I+M5rupbbef+EJlLyaE/I34KQSqmyMNRBVf24dkS3slADSE3fDqUTWDMuF54+NUe1GmkYJ5RstSymWN6MGIuUOumfIKOml0rzZ0Th0SASz36wL1pd8xg7lAwFLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTcKzMae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTcKzMae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E99F1F000FF;
	Tue, 22 Sep 2026 13:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082290;
	bh=K4SN5UPpXKeeW6dzYdaaKEGAs0u4U8faNrZytlxuZWE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VTcKzMaey0G3mU9sZQCDq66631LpqLRugtMICWObqHzGnZRbWGwa72OIwpigCD/Gm
	 nML8BxOqJ8T60feKXp4BPE7QBPyRy2iwsbClaBaqGc1sRdRAVom1E++CdFP5uVLpwR
	 gYNwErySxNE6CMqRVv8aVwfdChJws8d5xOZhNwzL7xNWW/AH8dzXgTIcPxRGrNhaIY
	 KlFtKdvSArLEXtAafL9lcsMjx+xkz/RF5E1MPhTbEMhsKVHD+idWvzi2MjkP/d2cU8
	 P6mHtyXNvwKoLUUoJqUzZDP6IkV0dSllBp/M8ALu5hqEpg4HVaU9hKgi/BFjKzBHYI
	 1Z0LPC1T0wAxA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Danish Khateeb <danishkhateeb03@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260921182448.194307-1-danishkhateeb03@gmail.com>
References: <20260921182448.194307-1-danishkhateeb03@gmail.com>
Subject: Re: [PATCH] ata: libata-sff: replace kmap_atomic() with
 kmap_local_page()
Message-Id: <179008228909.3109057.4237905377631066887.b4-ty@kernel.org>
Date: Tue, 22 Sep 2026 15:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 21 Sep 2026 13:24:48 -0500, Danish Khateeb wrote:
> kmap_atomic() is deprecated in favour of kmap_local_page(), as described
> in Documentation/mm/highmem.rst.
> 
> ata_pio_xfer() and __atapi_pio_bytes() each map a single page, pass the
> address to ->sff_data_xfer() for one transfer and unmap it again, so the
> mapping never leaves the function that created it.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: libata-sff: replace kmap_atomic() with kmap_local_page()
      https://git.kernel.org/libata/linux/c/02178d4b

Kind regards,
Niklas

