Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFC3C3432;
	Mon, 31 Aug 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164816; cv=none; b=ByP+x5tuQZU16Rb8Im6J8aKnOIJC0buusYU7TLLGU0lucqD6AV6VEE/1PrtBy7QGQ4ANivlK/Cne8bjlhhjvfvNBE4vLlI3EPZVi6+DK0LZv9J8P+n7U8FGS0MiyhncaB73ovUsN/1C1fGqeCj6PiM/D36y81CL+QpKJ21q56uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164816; c=relaxed/simple;
	bh=r63418fjg5paAi6CPRWrWlilFH5ULPa/3W9L28N7NR4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=feEQcMAKa5F9tCh2bI6lebnoifybocazI6OQEarRGWo/P5gLMsX/ihaoq+KNX6uDbg9ULcDtaKFwmsWIeLGkq+1qCwDl1iVndJ2bXbdWNDalcXAtY5QwwpDzSqAEg6iPLD1Rqak7Y+2zg3FgZyDq6V9T6jjWGEZg5rBwsE6kTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeqKaB99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeqKaB99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626151F000E9;
	Mon, 31 Aug 2026 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164814;
	bh=X8qXd3VlWOw9TROiStyhM5F3ZzxPSb0crLegggnRooU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HeqKaB99u5u0v7OHTWRCXA2n/XTC8tnVkt1A0uxUl8trHEC91+guwgVOHYXmwOvok
	 EXKkxSSmm7DAFX1LlSfcPwNGsJGeIRRHG1ElZYFmesedu1vNyIuz5Sb2LRrV+2J4yc
	 GJBLjBRab1ofK6KshEh4ZvyXvJ+I2lxUcowL2tG49Cm7d4MWQBuUARKcvm5ynk82GK
	 rqkofHz7ErqisWfXEOHyTs6JUsmo8oldB1viWLi8slUq/IOMLF8VMQy1QdcKkez3tP
	 aO+xZYgV3W5XuNoPHrbKyA5J3mX+fUNayLt+4mUxEWPyfXIZxd2vlAa/LlJimVeSix
	 Z/X3zvyy90oIw==
From: Niklas Cassel <cassel@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Paolo Pisati <p.pisati@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260826160911.460165-1-p.pisati@gmail.com>
References: <20260826160911.460165-1-p.pisati@gmail.com>
Subject: Re: (subset) [PATCH v6 0/2] m68k: pata_cswarp: Add Amiga cslab ata
 support
Message-Id: <178816481311.176595.9203985388658028352.b4-ty@kernel.org>
Date: Mon, 31 Aug 2026 10:26:53 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Wed, 26 Aug 2026 18:09:09 +0200, Paolo Pisati wrote:
> Here is a driver (and the subsequent defconfig change) for the pata/CF socket in
> the CS-Lab Warp series of Amiga boards.
> 
> This is a respin of v5 addressing Geert's and sashiko-bot's review.
> 
> Tested on real Warp hardware.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/2] ata: pata_cswarp: Add Amiga cslab ata support
      https://git.kernel.org/libata/linux/c/d388f965

Kind regards,
Niklas

