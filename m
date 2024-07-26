Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532022B9C4
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989681; cv=none; b=EFtnzZr3XhIJeHqwamVi+vX16T8XRiyqkXSw7hqGmgpiZvvRwZpi1kkraXrC67TUaDUT2zQHmGtl3HgD0koniSdcvKw8mOQkyaJVg6nt3LojZw5+hIaEkXg1hMQ1bYLhJ5anKmRZlAqHFjsQPun7FR6UlIj1Pz59XFYNKqySIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989681; c=relaxed/simple;
	bh=flnHQRXbmvGiqxUQj/n9lKDXuzVqutdFvOGS9FfaDtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVE3q/Ed+qJ0uN9wWF2AyuF84SYhIT6Y4ST4er2o2D4h9gK7T1iCHVCAaleDXYHPdvEPfiNI4mao5al0ivT0j64InBffyKqR6FrQ6RgPxOkrtJ31/7nCXQTG8f32GJNCNrq6RlyNQwTT7ibNMzTFYmZs7K+M1uQaWmC5pmPVkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptHfIvUT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptHfIvUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23192C32782;
	Fri, 26 Jul 2024 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721989680;
	bh=flnHQRXbmvGiqxUQj/n9lKDXuzVqutdFvOGS9FfaDtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptHfIvUTGMIuucb77aM7MPR4/FomIXEu5Qvjp2j7ZV35H30TcxUq+O9C0WgnVG0IW
	 gRcYbUf8JipyX1NggRDvJBPIwaIymx9G/p7/uMviah9mTU9DdiLyRwduBxl0sHTDRb
	 KdhbyyXkbSsdXO+EQoXnfaKjwv65mZMl8tHe1XTjqYmIu/u5LNUg5WZ1Wi/KQ8GiSf
	 dzzRVRDCJy2VUcOWvuzinqxM2h+7jdbNzVRzC2zpzmLG9VTLPk8G7hiDL5H+6HcsQ2
	 f9dXkNeBtyY+5pqMZ36vAWJNQOYaKhQody0LfCg6gF3plgwEgnzdCfOh3LdG0z1xQw
	 CNPTUKc9VpQLA==
Date: Fri, 26 Jul 2024 12:27:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v6 03/11] ata: libata: Use QUIRK instead of HORKAGE
Message-ID: <ZqN6LVQd5-FIuIZk@ryzen.lan>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-4-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:46PM +0900, Damien Le Moal wrote:
> According to Wiktionary, the verb "hork" is computing slang defined as
> "To foul up; to be occupied with difficulty, tangle, or unpleasantness;
> to be broken" (https://en.wiktionary.org/wiki/hork#Verb). libata uses
> this with the term "horkage" to refer to broken device features. Given
> that this term is not widely used and its meaning unknown to many,
> rename it to the more commonly used term "quirk", similar to many other
> places in the kernel.
> 
> The renaming done is:
> 1) Rename all ATA_HORKAGE_XXX flags to ATA_QUIRK_XXX
> 2) Rename struct ata_device horkage field to quirks
> 3) Rename struct ata_blacklist_entry to struct ata_dev_quirks_entry. The
>    array of these structures defining quirks for known devices is
>    renamed __ata_dev_quirks.
> 4) The functions ata_dev_blacklisted() and ata_force_horkage() are
>    renamed to ata_dev_quirks() and ata_force_quirks() respectively.
> 5) All the force_horkage_xxx() macros are renamed to force_quirk_xxx()
> 
> And while at it, make sure that the type "unsigned int" is used
> consistantly for quirk flags variables and data structure fields.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

(It might have been easier to review if there was one patch that just renamed
the ATA_HORKAGE_ flags to ATA_QUIRK_, and then one patch that renamed
everything else, even if that means that the same line would be touched twice
in about half the changed lines.)

Legacy aside, I really like the fact that libata now aligns with the rest of
the kernel code base:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
