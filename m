Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2852E07C
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989076; cv=none; b=QnU/Qh5khZV4vWLbjkZb/IR6mUQJhGTTSoPuXUYpEv53QaRexorsFJyqPbRiv4SXxnEP7uQtlQuYeSgTVgrS6uedrTqtUknstoBWd4BZI57+Bwf8NDyq9ORUZY8Yj2/dcIG6IRMYJBoVDdsszYZSuJ6aZGe2T2HvxxnUKPqKjKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989076; c=relaxed/simple;
	bh=/6qJR4cOGN7u4o3YBZ/GsPlDk1v1mh3gOixXSFcIH08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVPjBxfq1I8ELhQkSbjtLJTyQBjgUW4PbMoiXjDNy4LpRDaVXPHxOjvs3xTrAgvPlKJSZWgz8wd4k+i2j3DojAQlOFzEzALYndTPIoxU5TVZHszUWTuOcqewKZ+HgxMoaZ86Nv3UNUFYET/EFSm+mZi1YxehsDek82NkUcVT27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYwvtMy/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYwvtMy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033401F000C4;
	Wed, 14 Oct 2026 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989074;
	bh=25o1lqywSka8GR6PKWpie9HdCpltSBI0hIT9zDd3Ou8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DYwvtMy/4Nmu4bj7p1wflz9gB4NlGKPSHdZV4vlp4Fzq9u/pBE3aUAjqVaG98Vw2x
	 TeDhrV6WdE2Szfc+9Qz5h0cTFFYYVQu015jukxYP6qOLFOu1RdWv/AgdO1tu0xL2x2
	 XwLFLRZmWwYMllKMfEorCiYcjsGMWi2JnJTGCfiwnqeDHVDcRNmHu35DlCNeuvdhYq
	 kODV+uJiNFq+Kxe4RqYJQVWslEURCfSAgVPJajiPbzaOO0/6z05sl+umSEwYzO4cuk
	 HQ8Il89ncqYUTPtW2rRFuwHT5e40veJ0yG+dVeV1SpT7duZn225Ffjltv1JU8jAC1j
	 4mTFr/NIKSd9Q==
Date: Wed, 14 Oct 2026 16:44:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Fix NO_FUA quirks shadowed by earlier
 quirk entries
Message-ID: <as-VUDKNQRyNk_ez@ryzen>
References: <20261013193915.174460-2-cassel@kernel.org>
 <9136433e-297d-47b1-b341-7ebc008f3e43@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9136433e-297d-47b1-b341-7ebc008f3e43@kernel.org>

On Wed, Oct 14, 2026 at 04:34:55PM +0200, Damien Le Moal wrote:
> On 2026/10/13 21:39, Niklas Cassel wrote:
> > ata_dev_quirks() uses the first entry in __ata_dev_quirks[] that
> > matches the device and ignores all later entries. Commit 38d431229bfb
> > ("ata: libata: exclude FUA support for known buggy drives") appended
> > three ATA_QUIRK_NO_FUA entries to the end of the table, with model
> > patterns meant to cover whole product lines. Earlier entries already
> > match some or all of these drives, so NO_FUA is not always applied:
> > 
> > - "INTEL*SSDSC2CT*" never takes effect. Every model it matches also
> >   matches the earlier "INTEL*SSD*" entry, so these drives only get
> >   ATA_QUIRK_ZERO_AFTER_TRIM.
> > 
> > - "WDC*WD2500J*" does not take effect for "WDC WD2500JD-*" drives,
> >   which match the earlier ATA_QUIRK_WD_BROKEN_LPM entry.
> > 
> > - "OCZ-VERTEX*" does not take effect for "OCZ-VERTEX" drives with
> >   firmware "1.30", which match the earlier ATA_QUIRK_BROKEN_HPA entry.
> > 
> > Move the Intel entry in front of "INTEL*SSD*" and keep
> > ATA_QUIRK_ZERO_AFTER_TRIM in it, so these drives stay on the
> > ZERO_AFTER_TRIM whitelist. Add ATA_QUIRK_NO_FUA to the WD2500JD and
> > OCZ Vertex 1.30 entries. The quirks of all other drives are unchanged.
> > 
> > libata only uses FUA when it is enabled with libata.fua=1, so systems
> > using the default setting are not affected.
> > 
> > Fixes: 38d431229bfb ("ata: libata: exclude FUA support for known buggy drives")
> > Assisted-by: LLM
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Your solution works, but I think it is very fragile. We will most likely again
> make the same mistake with the oredering. So what about something like this:
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 92233fb25051..980a6a6256b1 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4515,6 +4515,7 @@ static u64 ata_dev_quirks(const struct ata_device *dev)
>         unsigned char model_num[ATA_ID_PROD_LEN + 1];
>         unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
>         const struct ata_dev_quirks_entry *ad = __ata_dev_quirks;
> +       u64 quirks = 0;
> 
>         /* dev->quirks is an u64. */
>         BUILD_BUG_ON(__ATA_QUIRK_MAX > 64);
> @@ -4527,11 +4528,11 @@ static u64 ata_dev_quirks(const struct ata_device *dev)
>                     (!ad->model_rev || glob_match(ad->model_rev, model_rev))) {
>                         ata_dev_print_quirks(dev, model_num, model_rev,
>                                              ad->quirks);
> -                       return ad->quirks;
> +                       quirks |= ad->quirks;
>                 }
>                 ad++;
>         }
> -       return 0;
> +       return quirks;
>  }

I like the idea.

Send it as a real patch :)


Kind regards,
Niklas
