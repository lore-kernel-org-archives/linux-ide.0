Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008744D6C29
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970161; cv=none; b=kZPzQFWf9Jf/YhXE0+uqV1vncBB0CCq97gJO5OlWJBxMfX9VXwm9hVrC0frl0wa2HGEP+PJPnG/PlmNPGvE/6Vg/ZMXlry8nXce4Ro5loyOt7eVMRfA33Q1JFVn2eDlv9h56yzB/mxrvFtWm67PDRpLY51r873UnnRdWuJ7p3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970161; c=relaxed/simple;
	bh=hdmzJV60/GtnH/uuD2unyG5RHLQGRrRrk3I0QmHG8G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4L7yeVyGsT8MWWeXc0vjV70duetbp+el1EFRVkcZJIthG5FHu+b+wSMY6Q8fXNVTY6JSFnbaPVOVxa4oCsoW42rd9ibBGQlClJ/zN9uFDgcQFmQEojrQYfqWET5OCr36pCLwWq1TNGhshD1Wwr8MV0u06K0pBRnt6B7sstP298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPYaCLst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPYaCLst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0131F000FF;
	Wed, 14 Oct 2026 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791970159;
	bh=6VJXCGz4T2puCGwBqgOHauz82z3lDSRpAhJ0IXpt+Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aPYaCLstztKWFwjfkxkmTgLTkLXN3AvpeOXoPtwefOVBZ167bz/CM5fS/fYXPsYeD
	 mFxRbIy4MwlI32eewSfMX3jlnqpW73h5MX+0AARwy8s91WD+gpr7N226XakVVNbcKa
	 emPnZlPQbx0ivwusomIHKb0oRN3R7SFhekcCMIh+oczi9azbSO6be4JeOV84O3n9xl
	 L61S/6NWuwzPdI9qk1V3S9VmWNDldpoKaM5ToPDXLk6sEYAOIH9aqkTkXQIW9ZnYFh
	 1L6uqbc9xA4q7K1WELFCOJIFxkOhqbkFG2K6sufIDGMqGLpEADupVitiZFd+dROyN1
	 udPew9xzqeIcQ==
Date: Wed, 14 Oct 2026 11:29:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ioannis Barkas <jnyb.de@gmail.com>
Cc: linux-ide@vger.kernel.org, IoannisBarkasjnyb.de@gmail.com,
	NickBarkasnickbgrk@gmail.com
Subject: Re: [PATCH] [PATCH v3] ata: libata-core: Correct HPA horkage
Message-ID: <as9Lawcj3q0XKWV6@ryzen>
References: <20261013201926.14456-1-jnyb.de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013201926.14456-1-jnyb.de@gmail.com>

On Tue, Oct 13, 2026 at 11:19:26PM +0300, Ioannis Barkas wrote:
> Code wrongly detects disks using 2 specific serial numbers
> Use their firmware to detect whole family of affected disks
> 
> Fixes: 16c55b038033 (libata: implement BROKEN_HPA horkage and apply it to affected drives")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=8888
> Signed-off-by: <Ioannis Barkas jnyb.de@gmail.com>
> Signed-off-by: <Nick Barkas nickbgrk@gmail.com>

The correct format is:
Signed-off-by: Nick Barkas <nickbgrk@gmail.com>

It is automatically added when you do: git commit -s
You should not need to modify it manually.


Also, the final Signed-off-by should be the same as the sender.
That is not the case here.

Two Signed-off-by directly after each other is only used if you took the
patch authored by someone else, and submitted it unchanged.

If you were two people to develop the patch together, the correct tag to
use is Co-developed-by (in addition to Signed-off-by from both), see:
https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by



> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 59e87b987d..b23e1c3e4c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4248,8 +4248,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  
>  	/* devices which puke on READ_NATIVE_MAX */
>  	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_QUIRK_BROKEN_HPA },
> -	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
> -	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
> +	{ "WDC WD3200JD-00KLB0", "08.05J08", ATA_QUIRK_BROKEN_HPA },
> +	{ "WDC WD2500JD-00HBB0", "08.02D08", ATA_QUIRK_BROKEN_HPA },

Where did you get this firmware versions from?

As I stated in:
https://lore.kernel.org/linux-ide/as6GuZaRvJFbxMgK@ryzen/

I would prefer if you simply dropped these entries, such that the existing
wildcard entries (which already match these devices) are the only ones used.


Kind regards,
Niklas
