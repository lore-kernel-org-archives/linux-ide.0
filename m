Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061AB19D89E
	for <linux-ide@vger.kernel.org>; Thu, 25 Jul 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925926; cv=none; b=CzAW+seNTT7DgRsO9kCVCNaq0TqX4pF5Gt538u4ubB5kEUdYXmDK1j7yE+MhoiFgiF2MeUe2CFcDEpdlBvPnZ6nrKnSrZVjYM/4dr3oSxkvxxjtsDHkBtzyyr6uIgu8sGogORu4Yyo0Vcby1ipWLddsJ3WEp/jfX6LwlvfPFOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925926; c=relaxed/simple;
	bh=odXyBvmE+Q+JFNQvkU5CEWcgm0FlBnAGfX86PGVsY9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnzlUnCBdrmKrak2sSj/sz3dPmiu3lZcXHr7xnOf5b9dQNgpseIKd2g02NOyNdNfYwrcvLziZgL1yHX8pwGIYu/VReHlpTFWUwkIIrH5ylnkKHprthi8gQ+zLRJigZsFLfT1GlmeDA3qXDTPmNpcHoXhxW16Yu1zRKorH2XO/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckl7wWSK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckl7wWSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC972C116B1;
	Thu, 25 Jul 2024 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721925925;
	bh=odXyBvmE+Q+JFNQvkU5CEWcgm0FlBnAGfX86PGVsY9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckl7wWSKoUYg+Isn+Y6341dR/U77x13tOBGr5ZJ3amjaELdnHB4rsQ5ZIBORvh1e+
	 NnrQ8SUyXnBUEJvYQAL71i6t5v/yzGN5A5gXJFg0YTtmP++CSVqvOyck7O3Y0dzQ3K
	 lZ1aJhfd3qaObLF5gqbmiNPDeEDzcZ5iDgysPGv67kp/n3AQUkNCTJLRgOcaWV1Kdj
	 0p1c6hLlPW4k04RhM4mg6CnHbCr2z78cphLizHrwjaOoy3y/UrjxNN1hsrly6HQEhB
	 dgjZNLOtbcE+ZdBtHwr5AJMVQh7CBS8HFKaaVWTKkBdvjLiQMALZnRmr2/fiUzJoQa
	 z03wNsbAbtmtA==
Date: Thu, 25 Jul 2024 18:45:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 4/4] ata: libata: Print horkages applied to devices
Message-ID: <ZqKBITAo8vioghtt@ryzen.lan>
References: <20240724054539.182655-1-dlemoal@kernel.org>
 <20240724054539.182655-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724054539.182655-5-dlemoal@kernel.org>

On Wed, Jul 24, 2024 at 02:45:39PM +0900, Damien Le Moal wrote:
> Introduce the function ata_dev_print_horkage() to print the horkage
> flags that will be used for a device. This new function is called from
> ata_dev_horkage() when a match on a device model or device model and
> revision is found for a device in the ata_dev_horkages array.
> 
> To implement this function, the ATA_HORKAGE_ flags are redefined using
> the new enum ata_horkage which defines the bit shift for each horkage
> flag. The array of strings ata_horkage_names is used to define the name
> of each flag, which are printed by ata_dev_print_horkage().
> 
> Example output for a device listed in the ata_dev_horkages array and
> which has the ATA_HORKAGE_DISABLE flag applied:
> 
> [10193.461270] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [10193.469190] ata1.00: Model 'ASMT109x- Config', rev '2143 5', applying horkages: disable

And again we are going to introduce a word in dmesg that:
1) No one except libata developers know what it means. Simply using the
   established term "quirk" will be easier to understand for most users.
2) We are probably making up our own word here, since I'm not sure if
   "horkages" is the correct plural term here...

TL;DR: let's just use the term that everyone else is using in the kernel,
it will be easier for developers, easier for users, we will be certain that
we are not making up our own words, and the (possibly long) line that will
be printed to dmesg will be two characters shorter :)


Kind regards,
Niklas


> [10193.469195] ata1.00: unsupported device, disabling
> [10193.481564] ata1.00: disable device
> 
> And while at it, make sure to use the unsigned int type for horkage
> flags as struct ata_device->horkage is an unsigned int.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
