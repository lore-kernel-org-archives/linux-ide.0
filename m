Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9A15A48D
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784685; cv=none; b=coIFR1DA7mzFlIAAM0YYKtevtr0tgiHvXIh/D34tvIxblm7SYkA56B0CZhxgly34C5F02KYsmSfH9dFy7oQeY/SfvyjNcdQg9UphidWg1NbyMIc32Y/UWyT3vNXonFadDVKxAz5z23M40c6iVJZ75+tZtrRDldNebYzKrYrQSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784685; c=relaxed/simple;
	bh=KDxbFsRHIkwfqyNoUhpWc5qjFdmgOJxLW8QXzdEK/pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9n49QmZWIhqU8+fWJ4xkDVjU/jyfxWn+X2y6UoGPAK89N1qXH/+AmkE+z9lgIbJx89KRz62psbdz8WD/+oAfSJop3Z3LzF9SwKc1UeOylDbONAAfAfoWlhyJK8/+7fjGtHmt3NkAC9v3Qlk0mA1/J8w7IJOtERdRtqDxSIQv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5clNBGJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5clNBGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A25EC433C7;
	Thu,  1 Feb 2024 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706784684;
	bh=KDxbFsRHIkwfqyNoUhpWc5qjFdmgOJxLW8QXzdEK/pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5clNBGJZyBil0po04fr/kWQeBNVJ+cDYp95L4smbC4ZuHu5KN6kIwJzKdESVJOP5
	 VjmHEo+k4Qb972kEFwC5zRlERu7oc93nExaKjcc1OmtvQVPymbtAzMBhP/A7amj5fU
	 +YYNP1N87XKzLXnIvIiqsQyCwEBTlJYRdR0gOoqPztXVlOo3Mi36r53pVX/OmVr9O0
	 Fc/VCrEPA1+Csz7P7+xQdYCAGm9Ss1Dr+j9jofl0op5KYy7NV97tfoV51tKejawyBg
	 Itprj3LrZSwI7jXmaIOJ8TTri5T2UDgNVpMzjhlU+frRvuJaycDGKaQPS0MUADvQcO
	 GcTAIswVjzJ9Q==
Date: Thu, 1 Feb 2024 11:51:20 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dieter Mummenschanz <dmummenschanz@web.de>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: Re:  Re: Re: [PATCH 0/2] Power management fixes
Message-ID: <Zbt3qD8dMSqGYl8Q@x1-carbon>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
 <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
 <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
 <ZboztvrqKKdLQ1mt@x1-carbon>
 <trinity-61f604a0-1db3-4b6e-a316-fc7e609f38f4-1706771411065@3c-app-webde-bs18>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-61f604a0-1db3-4b6e-a316-fc7e609f38f4-1706771411065@3c-app-webde-bs18>

On Thu, Feb 01, 2024 at 08:10:11AM +0100, Dieter Mummenschanz wrote:
> > It should be needed until we add (or modify the existing entry, if any)
> > your PCI vendor and device id to use "board_ahci_low_power" instead of
> > "board_ahci", see e.g.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata/ahci.c?> id=b8b8b4e0c052b2c06e1c4820a8001f4e0f77900f
> 
> Not sure I understand. So this CAN be fined inside the Kernel?

Yes, this part of the problem can be avoided by adding an explicit entry
that uses "board_ahci_low_power", as I explained in:
https://lore.kernel.org/linux-ide/ZaATdGDOo5jiBqCR@x1-carbon/T/#u

We seem to have a problem with Tiger Lake, but that problem seems to be
related to Intel VMD.

From looking at your logs, you don't seem to have Intel VMD, however
I'm guessing that some other motherboards that uses Cannon Lake might
have Intel VMD, so I guess the safest thing is to wait until that issue
has been resolved before adding a "board_ahci_low_power" entry for
Cannon Lake.



However, we are still confused why the revert in this series did not
enable your system to enter deeper power states, as you have previously
confirmed that reverting this change:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/ata/libata-core.c?id=d035e4eb38b3ea5ae9ead342f888fd3c394b0fe0
allowed you to enter deeper power states once again.

I see now that Damien's revert (patch 2/2 in this series) is not a simple
$ git revert fd3a6837d8e18cb7be80dcca1283276290336a7a
it seems to have some other small changes in the same patch as well.

Sorry for asking you to test something once more...
But could you please test with:
v6.6-rc2 + git revert fd3a6837d8e18cb7be80dcca1283276290336a7a


Kind regards,
Niklas
