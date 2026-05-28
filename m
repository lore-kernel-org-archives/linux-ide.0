Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30593B583C
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990888; cv=none; b=CC4Qa4mDL/krAiKeBSbKCJQTkF8sDWiMIZuq5BXlu6A8QKitiHReTs1Iti4X8/GWOgvTeNVf56PILlEK4JzN5Ze2CEwog2Tvuy79JMELHoAeN7xTaxc0ABY8R7Kcyj2tlHH4RmqYeHyIBw2iCcL3GEiA5wkCYih1DcSh6Fyrgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990888; c=relaxed/simple;
	bh=PsbpLvC5Au9wsjf/xpS2qVDXCVq40MjFlSV6JWEmojY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOfJ9fWWKPOx2AqQXA1ZGvae+NFY8Cp1XBV5vTI/VUrcXlycmup/+oGCizEa+7vRoKi9W0+RX+c8nnUXts4gdvV5kQpFj+nYdT9i1kX6pRsHwv+7BRp+brUTN8Vgh5RO0BBz18O2IZOyEr2OeUQZCtngoaColg9rxATVpMnvAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAf3V67w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAf3V67w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A64E1F000E9;
	Thu, 28 May 2026 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779990887;
	bh=8SCK72woQtyocPAHEUsLfGVA7lrkJUUi/bIy9d9ag74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OAf3V67w+hykTEF2l2WTHhANm8AXPzsYIdNI3PTkMDdS9v0Pl6KKvf1CVTnqU6NhA
	 kVLd2ztY27/qogiL6USsSb5rzcyBQKWNf22qLhvBqiaRr3fgRagZgRfFHcwiq5kc7z
	 YbkygZ5h60jXPAKz6HU4+RqI28/CWMgnUhYruMcKBHxWn3n+9l4jUT9PFEvTzwPvK3
	 ogLAZp1PI98Nt9r90P/5okB7cM4B26kxpDLSl5HrP3BYUeyiYx7FP+tzKfSOKOvIg2
	 grqE/l91e+upflVrPm1POwkJEUvuXxha6I0Rfy/7gOIchkQ4yE9VoimCKsa3ESUQOR
	 i2jZywnyOa8lg==
Date: Thu, 28 May 2026 19:54:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/3] ata: libata-scsi: Remove lockdep_assert_held() in
 ata_scsi_translate()
Message-ID: <ahiBY8mcOV2wfOEU@ryzen>
References: <20260528172855.703631-5-cassel@kernel.org>
 <20260528172855.703631-6-cassel@kernel.org>
 <b4023c30-881b-4bac-9543-b14646c8d49c@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4023c30-881b-4bac-9543-b14646c8d49c@acm.org>

On Thu, May 28, 2026 at 10:33:30AM -0700, Bart Van Assche wrote:
> On 5/28/26 10:28 AM, Niklas Cassel wrote:
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 6733f2b14521..8bfd3ffd8b89 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -1852,8 +1852,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
> >   	struct ata_port *ap = dev->link->ap;
> >   	struct ata_queued_cmd *qc;
> > -	lockdep_assert_held(ap->lock);
> > -
> >   	/*
> >   	 * ata_scsi_qc_new() calls scsi_done(cmd) in case of failure. So we
> >   	 * have nothing further to do when allocating a qc fails.
> 
> This patch removes a useful runtime check. I think it is better to
> add the following annotation to ata_scsi_translate() if the goal is
> to make the compiler check that all callers hold ap->lock:
> 
> __must_hold(dev->link->ap->lock)

Well, this runtime check was added in 2025-12-17. We did not have it before
then, so it is a very recent check.

As you can see in patch 2/3, I opted to add a "struct ata_port *ap" parameter
to ata_scsi_translate() in order for the context to be provided all the way
from the function taking the lock (e.g. ata_scsi_queuecmd()) to ata_qc_issue().

So I guess you mean __must_hold(ap->lock) in ata_scsi_translate() ?
This series already does have that.


As you know lockdep_assert_held() does a __assume_ctx_lock().
What I don't like about this is that, if the lockdep_assert_held() is there,
you can even remove the __must_hold(ap->lock) from from ata_scsi_translate(),
and we will still not get a build error...

If I remove the lockdep_assert_held() and I don't have a __must_hold(ap->lock)
annotation on ata_scsi_translate(), then I get a build error.

So I wanted to remove it such that we don't have any "fake assumptions".
There is no need for any assumptions, since Clang will be able to verify the
call chain all the way from ata_scsi_queuecmd() to ata_qc_issue().

(I'm kind of starting to see why you wanted to remove the __assume_ctx_lock()
from lockdep_assert_held().)

I guess my take is that, lockdep_assert_held() is nice since it will do
runtime checking... but if we can do context analysis without any assumption
(uninterrupted by any __assume_ctx_lock()), then is seems like context analysis
is better in every way.


If we really want to do runtime verification, and runtime verification only,
perhaps we can add a new macro that explicitly does not call __assume_ctx_lock().
Something like lockdep_assert_held_no_assume_ctx_lock() :)


Kind regards,
Niklas
