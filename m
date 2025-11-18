Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351F2F1FE6
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479065; cv=none; b=XUWfPbx9eQlGDlTVjiLXlgmEaTOC2KIeV+wJBfMpcqsjvUPJNwb9PYprnWLNb4UqXhdC13rtSy3tBcBynzY/t1CElmBPuOH2k5L3C4APVDBU7D6ZymssPNpolzD+tgQCEWVlEJCXn6DJP5iN5AoQskmZmTfkF/QIyA9A9g3D9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479065; c=relaxed/simple;
	bh=xgjJcpN8wyC5rx6EYo6xQMrPJ1gHGATDSKPD8u/XGwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkam6l7hI1Tc3tH2CQMvEfBPklPHnWou4fu6HVaMJIjdEt4vsXjArTX6gJ0+K6hR9sJ2vFIk6lit3e8wK+k0fPAkY6Ag4tdv0qRWypRQv3hUqc3aeKr7c55TQyk+fspuGIEC4+e7Ab1yfG1RqlXC3GWO7OSGnSXEyfiCC/4EJlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muQbPCR+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muQbPCR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19701C19421;
	Tue, 18 Nov 2025 15:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763479065;
	bh=xgjJcpN8wyC5rx6EYo6xQMrPJ1gHGATDSKPD8u/XGwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muQbPCR+iKkpChjCmWuFC+GG7VkUTP9fO0HizqQ3oHjYqqCf92zfEJbG/pwPVTdmU
	 9Uuo9O7tIG4pRrMMgRtK4f54ZPTzj/cmT9rG4su9syOmkS1HJucqx520NgWLQ0jiWs
	 iIk5QGoW4YDuy/Mr1/Eqo7zhweFYlVxGU5delDXukd2eyZQd6EYPd2NsbVXi1vbty1
	 qW6owpPr7JZCzAbyMzKNdlmxIoh+EkBj3rn+rAf9tIqZ+SVfF4f/yteYcb5JWgH5RU
	 71ycjzAKaULq0ZCidfaLFaQdx3jEMIlPi+RozPKyEDEZtXUZIkM1dJ5B3lRburqmox
	 dmUxyuIhO3y7g==
Date: Tue, 18 Nov 2025 16:17:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-ide <linux-ide@vger.kernel.org>, dlemoal@kernel.org
Subject: Re: ata timeout exceptions
Message-ID: <aRyOFRCQ_nSWtmsh@ryzen>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <4f0fa70c-b259-4998-bf94-c6c6fd8c733c@eyal.emu.id.au>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f0fa70c-b259-4998-bf94-c6c6fd8c733c@eyal.emu.id.au>

On Fri, Nov 14, 2025 at 03:32:20PM +1100, Eyal Lebedinsky wrote:
> > For the last few weeks it started to log timeout errors (not always) like this:
> 
> For the last two weeks I was monitoring the activity on the disk and here is what I did:
> 
> - added to boot command line:	libata.force=2.00:noncq
> 	now smartmon sees no more Command_Timeout errors since

To be honest, I don't think you should need to disable NCQ.


> This disk was used for a few years without such errors. The first report is recent (from 25/Oct this year).

Which kernel version are you running?

> 12:15:14+11:00 kernel: ata2.00: failed command: WRITE DMA EXT
> 12:15:14+11:00 kernel: ata2.00: cmd 35/00:00:00:68:4e/00:20:77:00:00/e0 tag 28 dma 4194304 out
>                                 res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
> 12:15:14+11:00 kernel: ata2.00: status: { DRDY }
> 12:15:14+11:00 kernel: ata2: hard resetting link
> 12:15:15+11:00 kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 12:15:15+11:00 kernel: ata2.00: configured for UDMA/133
> 12:15:15+11:00 kernel: ata2: EH complete

It is a 4194304 byte write that is failing, i.e. 4 MiB write.

This sounds very much like a recent bug report we have received:
https://bugzilla.kernel.org/show_bug.cgi?id=220693

In fact, a lot of the failing commands in that bug report is also a read
or write of size 4 MiB.

I guess you could try reverting 459779d04ae8 ("block: Improve read ahead
size for rotational devices") and see if that improves things for you
(while keeping NCQ enabled).


Kind regards,
Niklas
