Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086C2DF144
	for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2025 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340677; cv=none; b=nQ1nGh/OLReMBldbBb6R3qt6AU29zTJ9mc0czIk6eRlmTKyeDmS9XzqtByVdvU5aHxkwgeJJ3jNfkxgstC8jOvjuC0Kc1AL6YwsVCKwJwJ7/fQVYqxXOX09UdBZaJ4C4O8KUtKQhnN9c+fIRBdhRPrsZAhEwambsk3ynGvR/Rlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340677; c=relaxed/simple;
	bh=49S2kKNVyjxcOF0wERkgnPdBis7Q/RNkEybdp8j1Qis=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NM8ih7Gax2VGfP1Q1LNWWonFN3cBLWBGNUqmxtZ+bsCXxGpLctB/4PXdSc74n8cKO54MJmtJ1m+TmCcZ77Jz/yyuoFTWmor9jnt5F91rcN3VwaPBIBZ4LNAapSA7Q0cq5zTLxjoOqS9mPZeCn+QHu56dOpCoGxjvkY9j7HVF29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzTqnIen; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzTqnIen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3638AC4CEE7;
	Mon, 13 Oct 2025 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760340676;
	bh=49S2kKNVyjxcOF0wERkgnPdBis7Q/RNkEybdp8j1Qis=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=KzTqnIen1tQbRRiUIj2E1pjarw0OdO/0djDuZ0hqdpQloG1pYY2UckTo0IBzyhTxT
	 3Nlv6iqQU+Jma1bsC88iu4SEUbMgSzys9XqwXAiLmdrTqjajCE31Vpw4gi8EizahR2
	 tCUjbwCveIjFXizjJ9jDHmjEuhUpcb3b9HUkB6woEI4XB+daIksMR4EdMUs3c+gK+l
	 GhHto3wcysFIjeXFEFGbJPrAd9lnZ37vDUZ6qcPZodP/N7/xwFUaT3Te/DD/SGdbyl
	 iVAm/IFDEuGOkht+IhtUgBiblcrIR0DhvDOYx0JK7HtbGXggMo2xPSD9ESBXch+zgY
	 OEVHRZzlFSq0w==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20251009104600.523444-1-dlemoal@kernel.org>
References: <20251009104600.523444-1-dlemoal@kernel.org>
Subject: Re: [PATCH] ata: libata-core: relax checks in
 ata_read_log_directory()
Message-Id: <176034067595.2888304.13564712358410882491.b4-ty@kernel.org>
Date: Mon, 13 Oct 2025 09:31:15 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 09 Oct 2025 19:46:00 +0900, Damien Le Moal wrote:
> Commit 6d4405b16d37 ("ata: libata-core: Cache the general purpose log
> directory") introduced caching of a device general purpose log directory
> to avoid repeated access to this log page during device scan. This
> change also added a check on this log page to verify that the log page
> version is 0x0001 as mandated by the ACS specifications.
> 
> And it turns out that some devices do not bother reporting this version,
> instead reporting a version 0, resulting in error messages such as:
> 
> [...]

Applied to libata/linux.git (for-6.18-fixes), thanks!

[1/1] ata: libata-core: relax checks in ata_read_log_directory()
      https://git.kernel.org/libata/linux/c/12d724f2

Kind regards,
Niklas

