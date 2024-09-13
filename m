Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C9143C40
	for <linux-ide@vger.kernel.org>; Fri, 13 Sep 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210645; cv=none; b=IBC4A3h105/k7s3p6L5FLc27NjufmaQ22xplibDjzBQ/n6XmB3p9QUU3HmPsBSdaw4BGWb81Fil698m22YPRJp6lpwUGGIQkUAdLtEHzmwI6Tqmgp4jM2bcpDyhT5ZKmxohKbhsgZPtSZW6UOpwvNkeXR22K76k5WEP4mp6KEUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210645; c=relaxed/simple;
	bh=fcOpYMZNrgB8p3+xk4Gk2fwx4K7C7h0xFji9pr4VBrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9+P9H8t4ojhLRn8SV+Wp+8mQ41Pdw6uQ2zdiKRAJEMBSWUzzH+C8QQPEpLGhdzmsFiW3aC4C9PYzlzzJSkZ5poNx0qLqth2yILiz+O7RSvAjKdHcGEr2KJrCdQGK6dzbjqHnw4X8fLg3UrgIzCj80xtrOCTHSHgOPWGQg5Ph30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vID1+N6J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vID1+N6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AC7C4CEC0;
	Fri, 13 Sep 2024 06:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726210645;
	bh=fcOpYMZNrgB8p3+xk4Gk2fwx4K7C7h0xFji9pr4VBrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vID1+N6JLrmZIFrQa3tDxbOYbZq7qLaFimdGTcrgKlp0Syszpwo27MKr0eehQGYxm
	 SJtUxoGqkvKEEmyf/XAWc1kLTkCovtmpJ5R8KrZ0Ez/pqcKvvJ3RxErC9NaVwtd/Sv
	 VSCzzGw1aHfM8zMPbP5bZUje/jBPRphdp4UrRVxhPb1PLLjIPmG6vauQUDSYF1+nmI
	 /nkx3Y5c0PTT2fHMlvt3X/rByGWUgz+XVh5PKquEnYOUwnHTGRpqjJYT//h3M7V+Yv
	 6bmheqo8faW9DL1zjokNm6JPlihtvkymbfieoaV1OHLD+noBD4U24gCijsFpGWU5PS
	 ZDiX/3pqJcAPw==
Date: Fri, 13 Sep 2024 08:57:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] ata: ata_generic: use IS_ENABLED() macro
Message-ID: <ZuPiUWlcNmBt9tqH@ryzen.lan>
References: <d9c0acab-909e-da06-decf-be5de59d23bf@omp.ru>
 <87f85704-656d-4c08-b729-87c9b2e6d686@kernel.org>
 <4414c20f-7e0e-de47-8311-4a8948f2504d@omp.ru>
 <f5209cc3-a0c6-4722-92b7-533c0b244527@kernel.org>
 <65e70327-62e1-3b1a-7b69-eae765241b5c@omp.ru>
 <9d7e0d4f-1445-4729-9e4d-9058c35db1b2@kernel.org>
 <5bed15cf-b6c2-62e9-c23d-7a3c94f2dcc2@omp.ru>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bed15cf-b6c2-62e9-c23d-7a3c94f2dcc2@omp.ru>

On Wed, Sep 11, 2024 at 08:14:32PM +0300, Sergey Shtylyov wrote:
> On 9/11/24 1:22 AM, Damien Le Moal wrote:
> > 
> > Maybe rename the option to CONFIG_PATA_TOSHIBA_PICCCOLO ?
> 
>    Nah, that doesn't make much sense to me; if we rename it, we should match the driver's name, i.e. make it CONFIG_PATA_PICCOLO.  I'm mainly concerned about the
> Linux distros which would have to handle such rename somehow, IIUC...

I still remember:
4dd4d3deb502 ("ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY configuration item")
and
55b014159ee7 ("ata: ahci: Rename CONFIG_SATA_LPM_POLICY configuration item back")

so I also prefer to avoid renaming Kconfigs as far as possible.


Kind regards,
Niklas
