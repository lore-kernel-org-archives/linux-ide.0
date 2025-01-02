Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C419E999
	for <linux-ide@vger.kernel.org>; Thu,  2 Jan 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735814424; cv=none; b=tmtViG+OyZkkLXJkUy3IeV2Jc/GkAtK//Eaea5ilfOayInpX7LdhYnj4gqNok5Qq4O9EgM18qVym+/+i7xSlXbqj2YrXjwXz4ywf+knb0d7PILIm++wlgZEBnrhwFtAWShkEr0EzsAQni5taLZQZrd8UQeV5YXPKnPAnmrW1KrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735814424; c=relaxed/simple;
	bh=S569Ob53oDUCKWwPMJ37ctYKD7XLFvXc2Bx/pZu5T3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sid3KN2GEUjmY5HVYORIW3RRPeYzWlJCvOBVjyVBt5qfcFZ1k1bzXZw1jWQMU2qE8aHkYu8z3epWeMc8TOfodOG1BEFCUGavzpjOWrn6y9+TGxT7sJCRnxIZ7uewY92kxjGbOqm5YRIQNlR8gLJmDY5FonQBtwiP3gQlt+Nooic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+VWz1m6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+VWz1m6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1886CC4CED0;
	Thu,  2 Jan 2025 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735814424;
	bh=S569Ob53oDUCKWwPMJ37ctYKD7XLFvXc2Bx/pZu5T3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+VWz1m6L0RGlzFOSY+QvH69D96/S1Ur93HrGGdOuegDCECTDzfxdfueEPE9k57qd
	 yG9GFFN1G7p1DSGvRS5eI14JFHWivv4vhvbH6PpC8O41uBkkRfESdTHJOkTHGLa+9o
	 CVHK3+Qr+sHwbM+/zneMVKnFzyUlPnxaRb2NsoULXQc/THZ37iNZVfQfw05yrb0zNk
	 b8Yp3XdxQcex4SBLPXcZCW0RXNA5SHbeOqeBCZPwbj9xj8lUuSPFfFoFajWH26HbVZ
	 vhG0fO2e0/MYGQ2eRBzeYe5eep4GjFMxgnqYLGnXc2NxQBS3N89xC2Y8TvgmfyGEKI
	 Y9Edx8/m96NVA==
Date: Thu, 2 Jan 2025 11:40:20 +0100
From: Niklas Cassel <cassel@kernel.org>
To: reveliofuzzing <reveliofuzzing@gmail.com>
Cc: damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org
Subject: Re: out-of-bounds write in the function ata_pio_sector
Message-ID: <Z3ZtFDgs61oDMMB9@ryzen>
References: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>

Hello reveliofuzzing,

On Wed, Jan 01, 2025 at 09:17:02PM -0500, reveliofuzzing wrote:
> Hi there,
> 
> We found an out-of-bounds write in the function ata_pio_sector, which can cause
> the kernel to crash. We would like to report it for your reference.
> 
> ## Problem in ata_pio_sector
> ata_pio_sector uses the following code to decide which page to use for the I/O:
> page = sg_page(qc->cursg);
> offset = qc->cursg->offset + qc->cursg_ofs;
> 
> /* get the current page and offset */
> page = nth_page(page, (offset >> PAGE_SHIFT));
> offset %= PAGE_SIZE;
> but we found that `offset` could be as high as 0x5000---qc->cursg_ofs==0x5000,
> qc->cursg->offset == 0x0, making `page` point to a higher-position page that
> belongs to other threads.
> 
> ## Example crash
> This out-of-bound write can cause the kernel to crash at arbitrary places,
> depending on when the corrupted page is accessed by the other thread.
> 
> We found this problem can happen in Linux kernel 6.1~6.12. Here is one crash in
> Linux kernel 6.1:

Thank you for reporting!

I assume that you haven't tested kernels earlier than 6.1?

(Looking at the driver, there was no major change between 6.0 and 6.1,
so this bug has probably been there for a long time.)


Could you please share your reproducer and your kernel config as well?


Kind regards,
Niklas
