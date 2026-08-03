Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC05233704;
	Mon,  3 Aug 2026 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787101; cv=none; b=EdXXrqGMiHVKTgGSpzmEaQ9M5ABywie+hCyjuUQLhpMO4yCo+gDI0MhG78PUHObiCzjdloo5L0iQKAHHPc+Z5m/eNEr67aGGj5m8Z6IkiLa8KBpq4jGweqHDFYYeSxldrIZ4E5EzFCkpwgyggr7mZoEoIaO4TyZ55oSBperHuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787101; c=relaxed/simple;
	bh=QbwUwhnsIgxmsmNdpk5/9abwo7/XC3XbUAmQm1d8eGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adxcj3qkLP/I2gWXKzdJCbYe5nzGPkGPThm2eZ0KZ2QJoOmW0ZkL1IFxUmV2ySVDSQxwjHLzcd0kwkfGt8rY+n6kUs49CAIBS50HLLHPJTIjMW4C+0c8zphAooKOl3tPvBZFtmhBLDE1cpumBnAnC9cEeVVMk9ZXlO5dHxc8Rkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7ZSnoNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7ZSnoNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C381F000E9;
	Mon,  3 Aug 2026 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785787099;
	bh=rW7rifIy36GIk01fVdhRzNHF9YGpflc/2EN9qlhfYH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k7ZSnoNStshshOZLlT7ZCqOqtixzclQRcayEluJPRQ09hF4p4HW2KxVVgXPmr/ZHz
	 9GsVZ54LBquC6srTcxkGCAzdWt/GZTtZk8Yh4nxtLCvQyUkIhfZcfB0ToUSgWdqxW9
	 IkMCEj4TbHaQtAaPlwVPSp7czouJclfmPlQLzeoi+1kCA3oQWVvSk8MKWz5+7+1SDB
	 mc5Y8yBAxe+82A2ERJvYG91/bVYEf7/S2z97PX+hlTrtDlY9F2Zwx0+9HijNV+ZPSs
	 alMxEeR8QUCqflFAcPp0zu185MahDftDYU5CQKrOwImnqAGBTeoapPM1MfveYsIXGF
	 26JIo4f8FaCpQ==
Date: Mon, 3 Aug 2026 21:58:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>,
	linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH 1/2] ata: use named initializers for acpi_device_id
Message-ID: <anDy13qZ6rr1tFqO@ryzen>
References: <20260803-ata-acpi-v1-0-f606afaacad1@thegoodpenguin.co.uk>
 <20260803-ata-acpi-v1-1-f606afaacad1@thegoodpenguin.co.uk>
 <20260803151417.3DB001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803151417.3DB001F000E9@smtp.kernel.org>

On Mon, Aug 03, 2026 at 03:14:16PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Incomplete refactoring: ahci_seattle.c was missed when unifying acpi_device_id initialization.
> --
> 
> --- Patch [1]: [PATCH 1/2] ata: use named initializers for acpi_device_id ---
> commit f6b3d365ff5924969c9b77b57308411fcb82b7e1
> Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
> 
> ata: use named initializers for acpi_device_id
> 
> This commit updates acpi_device_id initializers in the ATA subsystem
> to use named fields. It also unifies the list terminators across these
> files to have a single space between the brackets.
> 
> > ata: use named initializers for acpi_device_id
> > 
> > Use a named initializer for the acpi_device_id fields which
> > makes the code more readable and consistent with how lists
> > are initialized in the rest of the kernel code base.
> > 
> > While we are at it - unify the list terminator to have
> > a single space between the brackets and no trailing
> > comma.
> 
> [Severity: Low]
> Was ahci_seattle.c missed during this refactoring? 
> 
> It appears drivers/ata/ahci_seattle.c still contains an old style
> initializer and a list terminator without a space:
> 
> drivers/ata/ahci_seattle.c:ahci_acpi_match() {
> static const struct acpi_device_id ahci_acpi_match[] = {
> 	{ "AMDI0600", 0 },
> 	{}


The series looks good to me.

I do kind of agree with Sashiko that ahci_seattle.c could have been fixed
in patch 1/2 (rather than fixing ahci_seattle.c in patch 2/2).

drivers/ata/ahci_seattle.c:ahci_acpi_match() {
static const struct acpi_device_id ahci_acpi_match[] = {
	{ "AMDI0600", 0 },
	{}

Having a .driver_data of 0 is redundant, regardless if the driver uses it
or not, since the struct is defined as static, and is thus guaranteed to
be zero-initialized.


Kind regards,
Niklas
