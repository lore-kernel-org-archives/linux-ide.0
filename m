Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9A3E8685
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873433; cv=none; b=V0eZg46P6Uo9/eBNKcWzgAcUko/6XKXaN2ka2++ogM3KX+7CYFmhNu6oaCd6CJICrtVLQ9pwurQKyv1leMv0TNw4JRl4a5Dtcb0A4G4VkqkSccag6NFRCn8dLYC0qsvYGEB+QBEmDQ9v0HyW9TLNgpu5Ov1wM7JfYaF/sQHIhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873433; c=relaxed/simple;
	bh=Bs261RqAHi8eqSSph1NiFXsR0ZPCr1i08D+ntP8xC30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi+Xkku/yi5pkCA4y+KTwhSA9dGTo8s1z/pqILRVPGtvRmwfi0stOqZvIF21ijLi9tPzC+5gFH9q1I/dqBQs21xFz648RzsZGNTkAiyUviGLyGbhUDHSYFUWGmeWK5C0OEKpPpkZyCqhEKpJc4DXWIQ5chpqalTgiKwtS1Tw4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+g3Hgf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+g3Hgf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D7F1F000E9;
	Wed, 27 May 2026 09:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779873431;
	bh=D4XSoII1sH9DsCjF8cc7Gm0EUcf5sTl3ojWC+NhLoMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+g3Hgf9gKcMmd5f3FWS8/sOtl3+UU2E5KzSM3xh7rhpCfXWxcU0GmsACuZAEtbmf
	 at/V32Sixn+tnL3Vf9dipVvF3E8+PnYOMLsdlewkbJ3VhA81OyyGYtb6WPFjNP1i8H
	 4yuBi/khT6X93ZIHq05wvwij1PjZjgvYpfO5j23hf7qLs+ZLqArOamtUhrNUy9C4f+
	 R6LyTgzdZfypiJXPW/iwxO5VXcI29a3/BvVV1qX5XYpK9TH+ZagKzSpSFMwEVLXt5O
	 h/8Ccc0tzk7xV6L3Od/IxnEyHMRXGW0Rq3S0+gg0+EpJWYusdMNgKxdUac1XBk6YTO
	 PqrafsIVHTEbg==
Date: Wed, 27 May 2026 11:17:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>, Jeff Garzik <jgarzik@redhat.com>,
	Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH v2 1/9] ata: libata: Fix ata_exec_internal()
Message-ID: <aha2lJqk82COjgK2@ryzen>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-2-bvanassche@acm.org>
 <ahWjcGUeSo76OIs3@ryzen>
 <4ceff843-148c-43ef-ab74-ba8999412f7d@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ceff843-148c-43ef-ab74-ba8999412f7d@acm.org>

On Tue, May 26, 2026 at 08:56:49AM -0700, Bart Van Assche wrote:
> On 5/26/26 6:43 AM, Niklas Cassel wrote:
> > On Thu, May 21, 2026 at 10:33:29AM -0700, Bart Van Assche wrote:
> > > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > > index e76d15411e2a..3d25dec6ac6c 100644
> > > --- a/drivers/ata/libata-core.c
> > > +++ b/drivers/ata/libata-core.c
> > > @@ -1540,6 +1540,7 @@ unsigned int ata_exec_internal(struct ata_device *dev, struct ata_taskfile *tf,
> > >   {
> > >   	struct ata_link *link = dev->link;
> > >   	struct ata_port *ap = link->ap;
> > > +	const bool owns_eh_mutex = ap->host->eh_owner == current;
> > 
> > We have similar code in ata_msleep(), which does:
> > 
> > bool owns_eh = ap && ap->host->eh_owner == current;
> > 
> > do we perhaps want the "ap && " here as well?
> 
> I don't think we need this since ata_exec_internal() unconditionally
> dereferences the "ap" pointer and hence would already trigger a kernel
> crash if "ap" would be NULL. I'm referring to the following statement
> near the start of ata_exec_internal():
> 
> 	spin_lock_irqsave(ap->lock, flags);

I see, thank you!

Normally I would queue this up for the current release, but
considering that this has a Fixes-tag that references a commit
from 2010, and considering that Linus has explicitly said that
fixes that are not serious enough should go into linux-next:

https://lore.kernel.org/lkml/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/T/#u

I will queue this fix patch up in for-next.


Kind regards,
Niklas

> 
> > Otherwise, this looks good to me:
> > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> Thanks!
> 
> Bart.
