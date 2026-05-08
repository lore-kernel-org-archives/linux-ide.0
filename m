Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264ED37B41A
	for <linux-ide@vger.kernel.org>; Fri,  8 May 2026 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268222; cv=none; b=UwbppDARdQNAPl6sqfQzcatcov3jNk6L12EBKKPix03xIE/mZXun2EKMKig7O/a4gyYloYQrl5JvAGejWsFzdZMdVCYTj9p1SW6CLcv8B4lQkiiR6HDsm9xcjSKrq3lI2zzOd28MVo3BM9EGXINZY3NDsDHufPHDb8eBbexyU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268222; c=relaxed/simple;
	bh=Ui6v7ZYYV108+i/doDDUhMIYyfstgEMqKZnw483GfBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jW4gFa2dG4CeOPpIQf3zb7hWeq+q1EpzpL0LNhmUbbG8ty1ImItTL9+7RUPqvCLf0Hxlb4vl09dfJgZtEZF4eT3kOWCdfvGeDK++pdhlRNNFwiSSXtf6xWTFa/xaah+4LiPMil9wBhEcsluLkQRt+2WsSbgT+MJY2TO388mAkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye+pBlBx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye+pBlBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69815C2BCB0;
	Fri,  8 May 2026 19:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778268222;
	bh=Ui6v7ZYYV108+i/doDDUhMIYyfstgEMqKZnw483GfBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ye+pBlBxEj91+llTIqxOK1CVYiVnTLJdusqHOEv2aX/jLyjSiVqmuJrPUdlsie+at
	 iLzMxoOMZ1t2wfyz/3uF5RglZKTO+D8/70RHKpQeRZzb8jJtrN4VwypSyhAq7mKDfY
	 aNDBks2f4CcDv5Hus7akkFRhdLP8rwDcyGV1scLQndhFQtngTFHKznrKhMnWO4rNTC
	 nKaQzRccBx7437k4AaT8+RZtMyhlu4SibZSYhyanvtAE0L8asMy+GZ4YXapJuMoisB
	 iQb7Zx2eS6xA+Tfd7pxb4TfygFDswUILVoSri9hxVsTsgcE1atSt+SP04/nVFiT8cp
	 +1RZIE4DV1w/w==
Date: Fri, 8 May 2026 21:23:36 +0200
From: Niklas Cassel <cassel@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Tommy Kelly <linux@tkel.ly>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <htejun@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-ide@vger.kernel.org, hare@suse.de
Subject: Re: [PATCH 0/3] ata: fix deferred QC handling for port multipliers
Message-ID: <af44OKkuhWtlO3fU@ryzen>
References: <20260501125410.1204490-5-cassel@kernel.org>
 <4be77745-2b7d-416c-b01a-88669d9bbeb8@oracle.com>
 <afT0INMUg7scssxk@fedora>
 <0f4458e2-cdb3-463b-a25c-5b2147e4e442@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4458e2-cdb3-463b-a25c-5b2147e4e442@oracle.com>

Hello John,

On Mon, May 04, 2026 at 08:27:06AM +0100, John Garry wrote:
> On 01/05/2026 19:42, Niklas Cassel wrote:
> > On Fri, May 01, 2026 at 03:19:03PM +0100, John Garry wrote:
> > > On 01/05/2026 13:54, Niklas Cassel wrote:
> > > 
> > > As I understand, this deferred QC scheme was intended to solve starvation
> > > problems for multiqueue SAS HBAs (using libsas-based drivers). libsas has no
> > > port multiplier support, so I wonder why we make deferred QC scheme work for
> > > port multiplier, i.e. non-libsas scenario.
> > 
> > Are you certain that there are no libsas HBAs that support port
> > multipliers?
> 
> No, I am just saying that libsas does not support port multipliers, see
> earlier effort @ https://lore.kernel.org/linux-scsi/1398346023-10225-1-git-send-email-yxlraid@gmail.com/
> 
> See this today:
> 
> int sas_discover_sata(struct domain_device *dev)
> {
> 	if (dev->dev_type == SAS_SATA_PM)
> 		return -ENODEV;
>

I see, thank you for the information!

Will send a V2 soon.


Kind regards,
Niklas
