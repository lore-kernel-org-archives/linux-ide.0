Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83014B5A6
	for <linux-ide@vger.kernel.org>; Mon,  5 Feb 2024 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159665; cv=none; b=b3536lSg9dgmQlAPoPAZ34ByQi+0cAuBUwAb/bVVVJ5QVGlzSzoLsJdVOrMXlCItjlK/C62w5rB0SPyPkwlvW4xjr8rDzX7etsVjjcZ6T3NuJinf11RSGWYxc30vuHmfwaSR3bCJVRJBejJcXUfnrHGBEDeZWncszkgF1wK27fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159665; c=relaxed/simple;
	bh=h/WWyjuGEfACXb7swY7HAb8oYML2FNIpVl8h5KwiEHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2SZWoNRQyz4JwCpxJz1bdb/zXHzEVhPPNJyv5v2Q19bEU89rn9gkZu6v40xhYdNAjJeml9oBryT0N5512DnXfhbB5yrgFeuN7AZCHgrfzTkLAtlzzBWCr1IDI9Yc+4A0+rjBc/d3Ai8KMkJUMuNGtZtzOd2sCLLwbTr8Ey7eGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLEM8NkJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLEM8NkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166DAC433C7;
	Mon,  5 Feb 2024 19:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159664;
	bh=h/WWyjuGEfACXb7swY7HAb8oYML2FNIpVl8h5KwiEHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLEM8NkJ2VGcsp/2mIGmcIlgkg/koQD+R9tjgYKYquhYV566Ub/VZHb+zhS+cMctE
	 JHF8Q2yiIvmhtC82UKMFjkV0zIZ60SdXzOz59YiBpUMRbmqB1cVxDOlbEVtRMWHQYO
	 D+UuDJxYIkQawBP+vKy13CfwiaUdzP2SqIaweX1NEeLCatydNIiPXtFGgpoeI4yJrt
	 HmLbei2mThDKRETzFv6GnURShvFaybXArDd0C8Ho8UQypiBAV95KnA4eJIn45GgBUW
	 hanwfNDT9R0y6PAFVTAeg5MSti46775SFP4IT9xfhbjhx6p5Cda30atkSufy+9Bj7R
	 qUc+D8aM8oOIQ==
Date: Mon, 5 Feb 2024 20:00:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dieter Mummenschanz <dmummenschanz@web.de>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: Re: Re:  Re: Re: [PATCH 0/2] Power management fixes
Message-ID: <ZcEwa4fOzMif8lCd@x1-carbon>
References: <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
 <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
 <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
 <ZboztvrqKKdLQ1mt@x1-carbon>
 <trinity-61f604a0-1db3-4b6e-a316-fc7e609f38f4-1706771411065@3c-app-webde-bs18>
 <Zbt3qD8dMSqGYl8Q@x1-carbon>
 <trinity-78c294c6-cd07-4a27-befa-3f3fc9bd79da-1706885616508@3c-app-webde-bs04>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-78c294c6-cd07-4a27-befa-3f3fc9bd79da-1706885616508@3c-app-webde-bs04>

Hello Dieter,

On Fri, Feb 02, 2024 at 03:53:36PM +0100, Dieter Mummenschanz wrote:
> 
> > Yes, this part of the problem can be avoided by adding an explicit entry
> > that uses "board_ahci_low_power", as I explained in:
> > https://lore.kernel.org/linux-ide/ZaATdGDOo5jiBqCR@x1-carbon/T/#u[https://lore.kernel.org/linux-> ide/ZaATdGDOo5jiBqCR@x1-carbon/T/#u]
> 
> > We seem to have a problem with Tiger Lake, but that problem seems to be
> > related to Intel VMD.
> 
> > From looking at your logs, you don't seem to have Intel VMD, however
> > I'm guessing that some other motherboards that uses Cannon Lake might
> > have Intel VMD, so I guess the safest thing is to wait until that issue
> > has been resolved before adding a "board_ahci_low_power" entry for
> > Cannon Lake.
> 
> This mighht be kind of naive but what about adding an kernel option to force LPM even if the chipset/board is not oficially supported?

That is a good suggestion.
However, I'm hoping that this series:
https://lore.kernel.org/linux-ide/3e50681d-7a68-4c4a-91f6-278a3cfe23f8@amd.com/T/

Will avoid the need for that, as it would kill the
"board_ahci_low_power" board type completely.


> 
> > I see now that Damien's revert (patch 2/2 in this series) is not a simple
> > $ git revert fd3a6837d8e18cb7be80dcca1283276290336a7a
> > it seems to have some other small changes in the same patch as well.
> 
> > Sorry for asking you to test something once more...
> > But could you please test with:
> > v6.6-rc2 + git revert fd3a6837d8e18cb7be80dcca1283276290336a7a
> 
> No problem. I've explicitly reverted with 6.8-rc2 and have the kernel running for 1 1/2 days now with 3 suspends and on all of them my system transitions to pc8 so I guess we're good but I'll keep on testing to be sure. Hope this helps.

After talking with Damien, we are still completely lost.

commit fd3a6837d8e1 ("ata: libata-core: Fix ata_pci_shutdown_one()")
only modifies the ata_pci_shutdown_one(), which is only called on shutdown.

It is not called in the system suspend / system resume path,
so it should not be possible for this commit to have an impact.


Reading all the emails and bugzilla again, what you are seeing is that:

On a fresh boot, and leaving the computer untouched for a few minutes,
and looking at e.g. turbostat, some of your CPUs have spent time in
the lower-power C-states, e.g. C8/C9/C10.

However, if you do a system suspend + system resume, and then leave
the computer untouched for a few minutes, and look at e.g. turbotstat,
_none_ of your CPUs have spend time in the lower-power C-states.

Is this correct?


If so, it seems that suspend/resume must have messed up some setting...

The commit that added the code to ata_pci_shutdown_one()
was added in:
5b6fba546da2 ("ata: libata-core: Detach a port devices on shutdown")
This was first added in v6.7-rc1.
(So this commit was never included in v6.6.)

The code added in 5b6fba546da2 was later removed in:
commit fd3a6837d8e1 ("ata: libata-core: Fix ata_pci_shutdown_one()")
which was first added in v6.7-rc1.

Are you certain that v6.6 works and v6.7 is bad?

There are quite few libata patches between v6.6 and v6.7:
$ git log --oneline v6.7 --not v6.6 -- drivers/ata

Damien has sent many libata patches related to suspend/resume in the
last couple of kernel releases, so it is possible that something has
regressed. We just have a really hard time seeing how fd3a6837d8e1
could be the bad commit.


Kind regards,
Niklas
