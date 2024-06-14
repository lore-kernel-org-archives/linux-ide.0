Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E6811FE
	for <linux-ide@vger.kernel.org>; Fri, 14 Jun 2024 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366598; cv=none; b=m1e8aPeqyqEZ1rYCRB65/SRc6FB4ygZS8nNXf68xWMHqsAYU68dEtz1r7ZRknGZQ7RER8+WaepOq1mvo5ClrzefRSZYujrK2ti7oaKaMSN2s9jWd0z4SIS0noeoDK63+AwGCbNvUnKOdcoyP3KoeqORvkoLvfa2Vm0cuA9l/Ty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366598; c=relaxed/simple;
	bh=6s1o5MARXwvGOegX24U1eFGmFQcePYmOWbCZMKRQZP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbKPuw/h89U6aPVzeJVMLcmVcvlCqkAScjmpZ/2GJfuxJYk9LAvG5jUfA08NMQokHjqkuoSseKwgQWJ5Q65NjjHghfIOUlwhpMo0TiuJ8EDENGnQ6wiPUBMv76f9UuiZagaacyhKHb1iV/yP3Bs7CPSTIL8Iyf3MtyLGXk+osHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKGr09Es; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKGr09Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1085C2BD10;
	Fri, 14 Jun 2024 12:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718366597;
	bh=6s1o5MARXwvGOegX24U1eFGmFQcePYmOWbCZMKRQZP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKGr09Esx5zm4cbCoc0QOMs2s6wQda/F5gFxM6pheV3kK+LQ7HuNy5FxKtnE/Az5K
	 JliW8mgve+JkPR8WYiZzRoqL49KEjL/baYrg06disZEtZKm8IcFKsWX7JXKfAZyPom
	 BXOJ51nnJYR/Iyqq/vDWaG9DoBPbbUgjGbSpGLqoaL+92Q6gufC6IchvrXgSlxV6qn
	 JNmzf66DOW/28fRmVxd+472iKthemZcpoCc+oTG393QD6NJXTaMCt8KgR6Wf2XUS5y
	 p6YtITOFxzO4cH3pmHGr7VYDEUzj1oLmMrGREZRY7HGC42WX81ffUoZFR0g7qieRpJ
	 4we8i2y7WlD5Q==
Date: Fri, 14 Jun 2024 14:03:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: Set the RMB bit only for removable
 media devices
Message-ID: <ZmwxgBHXHv8iKjFv@ryzen.lan>
References: <20240613173352.1557847-2-cassel@kernel.org>
 <60f1465f-c4da-5d0f-e395-8457a9287996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f1465f-c4da-5d0f-e395-8457a9287996@gmail.com>

On Thu, Jun 13, 2024 at 10:00:30PM +0300, Sergei Shtylyov wrote:
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index cdf29b178ddc..e231ad22f88a 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -1831,11 +1831,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
> >  		2
> >  	};
> >  
> > -	/* set scsi removable (RMB) bit per ata bit, or if the
> > -	 * AHCI port says it's external (Hotplug-capable, eSATA).
> > +	/*
> > +	 * Set the SCSI Removable Media Bit (RMB) if the ATA removable media
> > +	 * device bit (which is only defined in the CFA specification) is set.
> 
>    It used to be defined since ATA-1; I think it was only obsoleted by ATA-8 ACS...

Looking at the t13 achives, it was obsoleted by:
e06116r0: Obsolete removable media related feature sets
in 2006, ATA-8 ACS (i.e. ACS-1).

I will update the comment accordingly and send out a v2.


Kind regards,
Niklas
