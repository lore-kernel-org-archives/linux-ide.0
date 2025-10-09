Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530CBA3F
	for <linux-ide@vger.kernel.org>; Thu,  9 Oct 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012167; cv=none; b=c3zIUXHIZnff+BJBC6FmXwUTquFV8nXyLfXYeC7t9fCvJr6ZPrRkwJIJyU1qTKxEpfn3TS0x1cqZbKAnhWllR3yqZfkNU9QwhLlu3VTh19L7BFgMsnIuMKJ09G1GjCOi2QFeKYZDvQeJMUWIJspWf/wA+FGFYS+IY6ea/YDE3y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012167; c=relaxed/simple;
	bh=WNQ6UazxKnaSGP36KFfbAOF6OTpfyUJQyXiJZXEmoM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoCII79qejQWWBlJi4G7HYt6kFrtKL2c19UFFF2PoJdAQQt+oQ5Hf0LRNUcUGdXDwLuHem1jwpZ31ncMoQVaJWh1hkPdYMBTZn74sFBbNynCDaZSqe7cY9dy1D3DoXYLrs4IynAuFYGl1pI9VPY52t1PDixTYprYA0Yt2QBHkXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=froRuoV0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="froRuoV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC74C4CEE7;
	Thu,  9 Oct 2025 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760012166;
	bh=WNQ6UazxKnaSGP36KFfbAOF6OTpfyUJQyXiJZXEmoM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=froRuoV0tPc/bZKzpTSONeQ6e/IFJfK7aXu2tr9DBB+wgX6gF/VLQlfYZPKp1kOzl
	 Tn98o5vhhth8UZbErHe7kOEEoXH4bCH9E6d+UP2+KVpSqhgL28vGz9/z5oSWpqqQus
	 KYivdwg+WxHlC4H0/9pJTFG4rGtQU6Kwygi7lxz5zlkoCpAu6rpnsGnmx3H4X6MX/U
	 0Dy26lsNkMf5W/zXzgtxvSkUG+CgnSRyRyLoFFv8MNRVRJoK5T1wKX0rf/nM4JtH1i
	 Kq0np+y6/4fgv/LsYuT/DA1xzScMOjVYxwTAEngsMJhckP9H1WB7ALUiGqBDbt9SoG
	 nakmmUx3CVw8A==
Date: Thu, 9 Oct 2025 14:16:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: relax checks in
 ata_read_log_directory()
Message-ID: <aOenggZ92Af3tvBc@ryzen>
References: <20251009104600.523444-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009104600.523444-1-dlemoal@kernel.org>

On Thu, Oct 09, 2025 at 07:46:00PM +0900, Damien Le Moal wrote:
> Commit 6d4405b16d37 ("ata: libata-core: Cache the general purpose log
> directory") introduced caching of a device general purpose log directory
> to avoid repeated access to this log page during device scan. This
> change also added a check on this log page to verify that the log page
> version is 0x0001 as mandated by the ACS specifications.
> 
> And it turns out that some devices do not bother reporting this version,
> instead reporting a version 0, resulting in error messages such as:
> 
> ata6.00: Invalid log directory version 0x0000
> 
> and to the device being marked as not supporting the general purpose log
> directory log page.
> 
> Since before commit 6d4405b16d37 the log page version check did not
> exist and things were still working correctly for these devices, relax
> ata_read_log_directory() version check and only warn about the invalid
> log page version number without disabling access to the log directory
> page.
> 
> Fixes: 6d4405b16d37 ("ata: libata-core: Cache the general purpose log directory")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220635
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Looks good, will queue up after -rc1.


Kind regards,
Niklas
