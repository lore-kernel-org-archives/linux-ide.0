Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794055082;
	b=W7oxTpQv8Oyz3InvOyjm7PW2lg2wSCLY0oDSZOLsya6g9xdBuCkNgnahCg2sTBiQc/A7
	 eVChKVUJO1fEQhlj5PpNsNe8dDZOltGS032FdLISdwD0fChwBoVpikpsW+CcTxOg/CiQn
	 v8Fyrbx3mvhtCL7TOMOJ4ifxU94tQOSfw1oM6y+r9ug+5OtIHSlFMHPb3pKV8iu8MovH8
	 P/5hpfklHjYoTKt4IXVvqaNEZVn/eOL9i2UVKJP0Q/+vHKKAv4XX3gfSg+uEPiC/ixnzy
	 +1k6dPx8jsiVRu+mj5ah7KM8B0wPkoaiwbVXmnLomWuUPNytGz8tTTILJxOoH7VA9TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055082;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NvkwIN4EAH0B95Zf7QTnzHR3SOpoXYA3xI6kKuWgeIk=;
	b=bDMR6R4dsBRBTAsXhCk+gwVycUYq5a5s7xRBQN0Ud8ji50aIt3sfNqOdgVNCrCvco5ui
	 tL5oju/y5UEEs9wTM7i8ykAU1LFLN/T6f14hgKQnKSsgChLHnjOZ97DSJcG65DhMT1ZMf
	 7QWmrFvRfQwxJo01Y7Id/dzl3ZNSApDs1AetPG+cs4pkF+A1/QAdbILSQgiQOUKTTNYB6
	 tYfD8rlBL8/PFKVk9KG2cMAxH9DRMYMrKf457CmTdgYvFf8cEg6vI38hKZNqlezSUqN3P
	 MtRq0a4Dz51lhPuBinqXcZ9EX6cIazQ80ZqyOrsHhqiSzqN0SR5x8n4LxiSmE1gy/SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdRhpUsT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246BA606A326
	for <linux-ide@vger.kernel.org>; Sat,  7 Nov 2026 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdRhpUsT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB791F0089F;
	Sat,  7 Nov 2026 12:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794055082;
	bh=NvkwIN4EAH0B95Zf7QTnzHR3SOpoXYA3xI6kKuWgeIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MdRhpUsTQoaHruVe6nKpO7l0FGVZuk8trUPocFw3O8XrnskJHpH1EnbeJk0yo1hwC
	 e+SRt7F2GWR6oSinybphUxcDpddzAcLE04ssDTFf3r8o4nOnsZiilAyUZ2tpRDq7Du
	 e0zkGVhm6qzgco28pkSbmVRsyH3wirGwYQITba84Vf6wSxBZ7AAJhm2G2OHndLrpRP
	 1kCAjT/rIMWvu+ukDI8cju/rQD4N0j/eTYzsHcnwDN3XKDk2bSxKWPDW49YOOBvRO1
	 U5kmdePHbJcFoGByxyMYWLeEBpuaXZgQtrQYPcLzE914GYgppVlB/VFpaqa5CPI1b7
	 +lMxcbpjD4zog==
Date: Sat, 7 Nov 2026 13:37:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 3/8] ata: libata-scsi: reject MODE SELECT mode pages with
 a wrong SPF bit
Message-ID: <au8bpVOcd2JrPmwe@ryzen>
References: <20261103205448.931471-10-cassel@kernel.org>
 <20261103205448.931471-13-cassel@kernel.org>
 <1af3f18a-5595-4591-8fbc-e5e4d889b036@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af3f18a-5595-4591-8fbc-e5e4d889b036@kernel.org>

On Wed, Nov 04, 2026 at 06:22:08AM +0900, Damien Le Moal wrote:
> On 11/4/26 05:54, Niklas Cassel wrote:
> > ata_scsi_mode_select_xlat() accepts the caching and control mode pages
> > both in page_0 format and in sub_page format with SUBPAGE CODE 00h.
> > 
> > However, SAT-2 and later versions of SAT define the SPF bit of the
> > Caching mode page and of the Control mode page as not changeable and
> > set to zero (see SAT-6, 10.4.9 and 10.4.6), and SPC-7 (6.12, MODE
> > SELECT(10) command) requires the device server to terminate a MODE
> > SELECT command with INVALID FIELD IN PARAMETER LIST if the application
> > client sets any field that is reported as not changeable to a value
> > other than its current value.
> > 
> > Reject a mode page with the SPF bit set to one and SUBPAGE CODE 00h,
> > with the FIELD POINTER set to the byte containing the SPF bit. The only
> > mode page with the SPF bit set to one that remains accepted is the ATA
> > Feature Control mode page (control mode page, sub-page f2h), for which
> > SAT-6 (12.3.4) requires the SPF bit to be set to one. The opposite case
> > does not need a check: a mode page in page_0 format always has subpage
> > code 00h, so it can never be the ATA Feature Control mode page.
> > 
> > This also allows the mode page handlers to rely on the format of their
> > mode page, which a later patch will make use of.
> > 
> > Fixes: 1b26d29ccd59 ("[libata] scsi: implement MODE SELECT command")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/ata/libata-scsi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index d7923bc664d6..7b0a02903fda 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -4629,6 +4629,16 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
> >  			goto invalid_param_len;
> >  
> >  		spg = p[1];
> > +		/*
> > +		 * Mode pages with subpage code 00h use the page_0 format: SAT
> > +		 * defines the SPF bit of the Caching and Control mode pages,
> > +		 * for subpage code 00h, as not changeable and set to zero.
> > +		 */
> > +		if (!spg) {
> > +			fp = hdr_len + bd_len;
> > +			goto invalid_param;
> > +		}
> 
> The comment block in-between the assignment and test is odd. Can you move the
> assignment right before the if, after the comment block? That makes the code a
> lot prettier :)

Fixed up while applying.


Kind regards,
Niklas
