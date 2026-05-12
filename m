Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48316349CEE
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582272; cv=none; b=LkhPnC3KUTQH4uNtIq5tGJdqeUoDeYEqOtNpH6F16lZMZKqOsYM4fWcxLiNcadT+6jLsLdiMOrAtuVKnfVN62ApGxTsFoQ7uXCVvJoXu/G+xavGvKKbPepOqFniJWRJUBoTmPZtd9ZAjQkHaWW5P6psdpmUbFL7/cA/2GiRw96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582272; c=relaxed/simple;
	bh=oV5/WCfStg4rAtzCm3SUX07/pMz1B3x/pETzyq5sAuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQxvnZrj1g0sHYIxUaf1MtnpDKnjCYWp9K9ySKDY3/lVUrkyJ7R+rhWpGmWZsXsuSIatEzQIgYimFvsCVmsd6CRwIajKEBh14ECiKpLzfZ2yj0VLsWo7ZT9obrzLX+agTelcph4TS18MuvZBK13DLS8+84/dspx+PsnGju7RSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMj2xzuZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMj2xzuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09BCC2BCF5;
	Tue, 12 May 2026 10:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778582272;
	bh=oV5/WCfStg4rAtzCm3SUX07/pMz1B3x/pETzyq5sAuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMj2xzuZ1fA0UDIfueVwP22AlKpOsNViNox9b29B7labCuPyRuywqJYwRZH91jVLU
	 RgbYN9uugcS+X3D0NuiuNitpGExCUCSzVbbn3H8lMAVFzDf68sXNUZkmuGlhN/gsTw
	 YHpeyKUz++ADnlVtVWarSH7e6GnkDBJVl5xBMNwFbMe3TmtHN0+avYoNPnzQLvu7/w
	 wIQ7DaBPAAk/wNGU5s19PFRklYMJEmCYXWRwe8S883Oo4a6w0/8rOXQYl7+iWu9KJH
	 MNzLy/hawHvOUagwikc1nMUWIeb9mzA6t/bpIykXuEN+EvJXWv75sQMmaX9KHX6+KF
	 5d+/yunilFUaA==
Date: Tue, 12 May 2026 12:37:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Tommy Kelly <linux@tkel.ly>, John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ata: fix deferred QC handling for port multipliers
Message-ID: <agMC-0JrfMxsarzC@ryzen>
References: <20260508195051.188207-4-cassel@kernel.org>
 <9a0b2636-1411-4ce1-bd7c-6fc265a1901f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0b2636-1411-4ce1-bd7c-6fc265a1901f@kernel.org>

On Tue, May 12, 2026 at 10:58:04AM +0900, Damien Le Moal wrote:
> On 5/9/26 04:50, Niklas Cassel wrote:
> > Hello all,
> > 
> > Tommy Kelly reported a regression with PMP that use CBS:
> > https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/
> > 
> > It turns out that the ap->excl_link logic used for PMP that use CBS is
> > incompatible with the deferred qc issuing via a workqueue.
> > This is fixed in patch 1/2.
> > 
> > While looking at the code, it turns out that the deferred qc issuing via
> > workqueue is misdesigned. It assumed that we can't mix NCQ and non-NCQ
> > commands on the same port. The limitation is that you can not mix NCQ and
> > non-NCQ commands on the same drive. However, with a PMP with FBS, you can
> > issue (mixed NCQ and non-NCQ commands) to the different drives. Thus, move
> > the saved deferred QC from struct ata_port to struct ata_link. This is
> > fixed in patch 2/2.
> > 
> > 
> 
> What are the changes from v2 ?

There are the changes since v2, I simply forgot to change v1 to v2.


> 
> > Changes since v1:
> > -Avoid a local variable in sata_pmp_qc_defer_cmd_switch(), call
> >  ata_std_qc_defer(qc) inside the switch() directly instead.
> > -Fix a typo, such that the the code actually compiles... Sorry for that.
> > 
> > 
> > Niklas Cassel (2):
> >   ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
> >   ata: libata-scsi: do not needlessly defer commands when using PMP with
> >     FBS
> > 
> >  drivers/ata/libata-core.c | 16 ++++---
> >  drivers/ata/libata-eh.c   |  8 ++--
> >  drivers/ata/libata-pmp.c  | 26 +++++++++--
> >  drivers/ata/libata-scsi.c | 95 ++++++++++++++++++++++++---------------
> >  include/linux/libata.h    |  8 ++--
> >  5 files changed, 101 insertions(+), 52 deletions(-)
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
