Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395131FC7FB;
	Fri,  6 Mar 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787936; cv=none; b=KaUviraZn8ViJYuy82ft0ZzwYfToDlOLZbFBkvfLoQCBAn35u8BoGE3UwwyvcOBxv9SEV1vhBHjAS99s38EKDlRzC5CTjCNfZm+iUHR2ThsxTf040sekW2tKQPwiCL4BKju19yocT41WqeblPWNus6yl1gO4GGW2rm5A3sSi9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787936; c=relaxed/simple;
	bh=jd5cRhP+RgoiNThgAXBcxuSP6bmYfHKN99umagx6RW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0KlxOOcp67Gl6csKmtc0TkVWfgGZhDqZMaeu9+Oh+++FMS+P/rdjUQaML9gBQYIxPyBZmnb3ds7XG2aaT/SK3jdZ4/AI1wcy+6tt8gKap+oQjQM6sNyGySJfHRDdRISrfq/vuuvlxA6ns6vxZvHPC++Vn5GkJ933BNcd5BE+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOuUveOn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOuUveOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81ACC4CEF7;
	Fri,  6 Mar 2026 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787935;
	bh=jd5cRhP+RgoiNThgAXBcxuSP6bmYfHKN99umagx6RW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOuUveOn9fDmP2HkjcpEOQwdeClNfrYobImmkpakRcIl2U1fBqPB3B+B6jOYpCoZR
	 XIou3e4YyHwI+HqEFoqeKjORRNiy/wzwuqjwIqwfxBR8a5WJ3aSANu5Mf+HwuExrWU
	 OAe3/hX3Z2jOzYd5qPedvUs4ioUSN3LQuDCfNn+DLXISfANFllJsYfi/gJlQCOd/SX
	 mZ7G3P9EEtM9fWIsaRZ+zrtChoxTq8Yn1thMWyk6kALMFKsErC2xEX/leS5QcAyWHK
	 OKVMwgF5pqYwuKayUaHttIiwVnolIjGRqcmHzdJh3VM+fP8PiNwTFVaL5dps9zWOS3
	 LyGXtK6G+AaHg==
Date: Fri, 6 Mar 2026 10:05:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Fix detection of deferred qc timeouts
Message-ID: <aaqY24cG5ezFlEE6@ryzen>
References: <20260306024805.2877513-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306024805.2877513-1-linux@roeck-us.net>

On Thu, Mar 05, 2026 at 06:48:05PM -0800, Guenter Roeck wrote:
> If the `ata_qc_for_each_raw()` loop finishes without finding a matching
> `scmd`, `qc` will hold a pointer to the last element examined, which is
> accociated with `i == ATA_MAX_QUEUE - 1`. This element can match
> `ap->deferred_qc`. If that happens, the condition `qc == ap->deferred_qc`
> evaluates to true despite the loop not breaking on a scmd match.
> In that case, the error handler mistakenly intercepts a command that
> completed normally after an unrelated SCSI timeout, returning a timeout
> error instead of success.
>
> [...]

Applied commit log changes from Damien and myself.


Applied to libata/linux.git (libata-for-7.0-fixes), thanks!

[1/1] ata: libata-eh: Fix detection of deferred qc timeouts
      https://git.kernel.org/libata/linux/c/ee0e6e69

Kind regards,
Niklas
