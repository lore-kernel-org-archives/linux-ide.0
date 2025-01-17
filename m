Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408D1E485
	for <linux-ide@vger.kernel.org>; Fri, 17 Jan 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121043; cv=none; b=dqPGhdtE8sB36FCGsNmww7CA7bMEjpCVnqpOrpzxdZHOc/rsRDeOj0w/Yj0lQe3RSUwMVAUntL2otRTV+gLUU3vJZt59AklK+BDvvhc6IkKmQStL0tK0VualRpTrtjLfamlaWVnZ9Is1tKQDCIm6cCHf07Yd44slyqK6Inwnw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121043; c=relaxed/simple;
	bh=8COTnNnssFoDXRHsqomLRcuzH/5gPn/pW0f3fU453Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4KZ6aWUnzlQXBzyV4k4mQJWdyAP2JZ41lkLiSo/UoHtD9MFZrI/9jjEzQ0ShLcxEC+n05k3puPZKBP6gs8G7CkrYGN6c1UrZAsNwusmMy6O7+ZkrHi+YTLpccVKYGZsROidHWHCIB5fPUNtLv+Cekq0D+ame2zM4mmtbDHhn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl8ooYWz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl8ooYWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3402C4CEDD;
	Fri, 17 Jan 2025 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737121042;
	bh=8COTnNnssFoDXRHsqomLRcuzH/5gPn/pW0f3fU453Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sl8ooYWziZ6s5tu0nuQm1OmRY7b6mY6660CalEX3FWpJL7eijbeQM/OfAihxilj6i
	 w2wBnTsWLbkn/jmFK2EXaBhx7VRuFBj8I9DCQ/wszc1kUNANpYeyIg74RID9eJEM4h
	 q8uAAOxTxrY+g2+N5pMyrO5C+HQgwso92/enQFG0CcOp8/NqHaNFOqhzXntsXht3/I
	 ryONDCnC2yvH74UzB5hyNQhi03NRUvYML7SDasMqGDetQYlkZuHabOzpyH0WrSzukI
	 SP8EJI0VM4xWkEm/xb33LXPAmyN+lUHiuLyUtkph+lAsiKNv0Qtl0QUu0yOwTSWon7
	 Xq9ghGgkVMk1Q==
Date: Fri, 17 Jan 2025 14:37:19 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Philip Pemberton <lists@philpem.me.uk>
Cc: linux-ide@vger.kernel.org
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear
 UNIT ATTENTION"
Message-ID: <Z4pdD1Z2mJnF7N3O@ryzen>
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen>
 <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
 <Z3-_dt0m_2UrtKon@ryzen>
 <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>

Hello Philip,

On Thu, Jan 09, 2025 at 03:31:05PM +0000, Philip Pemberton wrote:
> (Repeating myself here, ata4 / ata_port=4 is the DVD drive; ata_port=3 is
> the Zip drive)
> 
> There's quite a lot on the ATA buses, so if it helps --
>   ata1: Samsung 860 SSD
>   ata2: WD 500GB mechanical hard drive
>   ata3: Spare port / Zip drive
>   ata4: DVD writer
>   ata5: Not used
>   ata6: Not used
> 
> There are a couple of SATA disks and a SAS tape drive on an LSI SAS card but
> they seem to go through the "scsi" and "mpt2sas" driver route.
> 
> 
> > Note that for ATAPI, it also looks like your SATA driver needs special support.
> > See e.g. libahci.c which does a bunch of extra stuff if it is an ATAPI device,
> > e.g.:
> > https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libahci.c#L1699-L1702
> > https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libahci.c#L1638-L1643
> > 
> > Same for the libata-sff driver:
> > https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L2672-L2684
> > https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L295-L297
> > https://github.com/torvalds/linux/blob/v6.13-rc6/drivers/ata/libata-sff.c#L687-L715
> > 
> > 
> > Which SATA driver are you using?
> 
> It looks like it's "ahci" or "libahci".
> 
> 
> > Are you saying that it does come up and work eventually?
> > 
> > When we see the "disable device" print, it is usually a sign that we have
> > given up, and thus remove the device.
> 
> No, it tries to connect three times, then gives up and disables the device.

Unfortunately, so far I do not think that we have enough information to
do much about this issue.

We know that the "SATA-to-PATA adatper + Zip drive" combo worked on some
other PC (that might have used another SATA HBA) with an ancient kernel.

I think my first recommendation would be to try to build an ancient kernel
on your current PC, and see if the same "SATA-to-PATA adatper + Zip drive"
combo then works. If it does work, then I think the best bet is to use
PCI passthrough and do an git bisection (which can be automated).

Or, do the opposite, see if the latest kernel with other PC still handles
the Zip drive properly, if it doesn't, then perhaps the best thing is to
to the bisection on this other PC.

You could look at this guide for inspiration:
https://github.com/floatious/qemu-bisect-doc


Kind regards,
Niklas
