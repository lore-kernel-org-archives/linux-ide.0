Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2C382F16
	for <linux-ide@vger.kernel.org>; Sun, 12 Apr 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007489; cv=none; b=ltHdJ2YJJPvqp5Fn6f2IUpo1+PSJHhpOj+AfJtxTenEX6UZWwCqnHyORwokUHyq3WK7cZh2+rFIAinSIvNzY+UeqT/lyZ++Dh3iJU9wjfv4+TV8KF1+Scch0dHA4hiXpt6oKVd9KxC5GW5SXnjjcRSgvOvlATl4ti7j19MY+nyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007489; c=relaxed/simple;
	bh=XgP3KwC58zb3/opTPFHRLxrELBJ3ntPRPoey+cXXTPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tguT7YBVQ2IGGHiXN0oAaLCrE1b+DLaytnxQYh4vXczjpcjyoaOrvJ7VSov1S5aXsDp1ph0YM1oB34r1TbJUG8yiQGNdIPbgIViU4/XLZLwMLuEIvTKESsNuYMkp7HcfH5rLiCb1B09iLdYDyyzgAyaYrepYItk5q36UJ/+ihTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRjBf64B; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRjBf64B"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1270f10a774so28218c88.1
        for <linux-ide@vger.kernel.org>; Sun, 12 Apr 2026 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776007485; x=1776612285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxVEU8M9tLLC0GDPV7iNVKeKt6wxmMr9DFDIGX2wN90=;
        b=kRjBf64BDWzh7DgbEVlOGAtaY/CcaBWlGhdNobZK3zHHe3JUt3KjWzs2asheWQi/SQ
         HXuScs0sO54saCU+20fHNY0/XmWLh7xAo4MDvYDcmvIwXA2W030NVvywqHbLr3G6op0q
         acWijT1nY7xqKb3+WbJlFJioYppdJMJB0WFRN0K8KBIlf15txezCcvCXIca17nugQAbl
         RJ3Okb9lZS7tivFpnf5b0GLDqxF9pC3h2XC3KjahlDTZUGAn8Nlup1MUpHdZibwP8uJe
         r7Kd+Xs1fNbe4Nz192F1i90Q27rzLGEqKgth3WB4dk52EtxMJG2WKrC/iDt0wioNu+o0
         mtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776007485; x=1776612285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxVEU8M9tLLC0GDPV7iNVKeKt6wxmMr9DFDIGX2wN90=;
        b=NRxRhQe7MNoRIlDOa5/04UtDO8g2cNMJaQkytICbRycKYpstPArNN1KQHr0UDEuYxu
         lyEizIoAug2FLh+VtwxEzDzRTpfgfX1kJAjSYbx82JHyKo4vMmrvDM9lx/XVdbjU/4KY
         Mgi7B6sPHxB4gqbBF+lyU06tBNCtbUIsK35CwKQxaeWBVerMKlBWraiznql4Z16kPCeE
         I49Co1JwyPY45yvaqDr8a2UZP2LTigCNX3ljjlQungcozadexq8/nGPiE0uj/jAi4rJn
         5dq1MiJXHshMjKZkbth8tue0TL5IxLvmUKnWghhMPFgQ41d6cWjT4Rlf7o63kOiaI8xa
         VlGg==
X-Forwarded-Encrypted: i=1; AJvYcCWdKO4YkgCkubCkRncThwNxS5AOl7Uusn4CelBfGUwB3PyS0d8Om2bOo3kR+QAaYCP67w6sLdih60w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtVC9gu8Oo4fPckbIwaNrFEMFTjIV5MEqdJ4/MY1i29Z+qDXH
	HSehHRzPMI/FdaTCLcOwgnnF8446GtGPrzlshnrjQ1hflrYW103Nj//1YIeJRyVmAw==
X-Gm-Gg: AeBDieukm7eZWTVFxHYF+EHy0f5r1p3+co7BsUm8MeKTorUNAEIYLL91saHTrg06syW
	CgMNZsMb6gmrfum6lJ53gtlm4YoFcg0iNe6ZxA0E5NLgeFzdCuzGmEfb7rNziH1ZxvjT6OmcZ/+
	cMh1DERUA733VrVgZgACvlGp396VUaCI2NKz5s8ohhtqSmWX0bep5xWz37HeQ3WYRgftHFpjxVe
	tuEo6UPBKu3WR2Ddg04+G1ugFFGOXMny0CYKTf8bKYZr0Re/V+WKwKdhQ9GFk+RnIujIxfomb1A
	BTYyMqAXE8SL/m1rmkyqg2O0bSg11oDdgWyJ4n7dOoayBIvEA5Gmvk2r4NvZLJQ7JAjbVOEQPK1
	g4g4750/d5JQOnECrwD9/HxPbx3jKVlerpD8PNXpxNewrJgb7qf6ZiIvQBS1TXNm1PvwOYHa7NF
	bdRUdQWoQr2wioC4S7HeyyvI5AXfWIZckl/jSH7/zeuNpNmBcbnet93ww4EvVDl1gXsiElqxr3
X-Received: by 2002:a05:7022:211:b0:12c:3d1c:b317 with SMTP id a92af1059eb24-12c3d1cb56dmr155191c88.2.1776007484428;
        Sun, 12 Apr 2026 08:24:44 -0700 (PDT)
Received: from google.com (91.195.168.34.bc.googleusercontent.com. [34.168.195.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa571csm15163191eec.10.2026.04.12.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 08:24:44 -0700 (PDT)
Date: Sun, 12 Apr 2026 08:24:39 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Xingui Yang <yangxingui@huawei.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: fix requeue of deferred ATA
 PASS-THROUGH commands
Message-ID: <adu5N3dSydy1uGXM@google.com>
References: <20260410231519.951971-1-ipylypiv@google.com>
 <adt3JqwFcDx-Xe30@fedora>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adt3JqwFcDx-Xe30@fedora>

On Sun, Apr 12, 2026 at 12:42:46PM +0200, Niklas Cassel wrote:
> On Fri, Apr 10, 2026 at 04:15:19PM -0700, Igor Pylypiv wrote:
> > Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> > introduced ata_scsi_requeue_deferred_qc() to handle commands deferred
> > during resets or NCQ failures. This deferral logic completed commands
> > with DID_SOFT_ERROR to trigger a retry in the SCSI mid-layer.
> > 
> > However, DID_SOFT_ERROR is subject to scsi_cmd_retry_allowed() checks.
> > ATA PASS-THROUGH commands sent via SG_IO ioctl have scmd->allowed set
> > to zero. This causes the mid-layer to fail the command immediately
> > instead of retrying, even though the command was never actually issued
> > to the hardware.
> > 
> > Switch to DID_REQUEUE to ensure these commands are inserted back into
> > the request queue regardless of retry limits.
> > 
> > Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-scsi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 3b65df914ebb..0236394900cc 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -1692,7 +1692,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
> >  	/*
> >  	 * If we have a deferred qc when a reset occurs or NCQ commands fail,
> >  	 * do not try to be smart about what to do with this deferred command
> > -	 * and simply retry it by completing it with DID_SOFT_ERROR.
> > +	 * and simply requeue it by completing it with DID_REQUEUE.
> >  	 */
> >  	if (!qc)
> >  		return;
> > @@ -1701,7 +1701,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
> >  	ap->deferred_qc = NULL;
> >  	cancel_work(&ap->deferred_qc_work);
> >  	ata_qc_free(qc);
> > -	scmd->result = (DID_SOFT_ERROR << 16);
> > +	set_host_byte(scmd, DID_REQUEUE);
> 
> set_host_byte() will set the host byte, but it will keep the status byte
> and the ML byte intact.
> 
> By using the assignment operator, I assumed that Damien intentionally
> wanted to clear the status byte and the ML byte.
> 
> My point is that using set_host_byte() is a logical change.
> If we want to stop clearing the status byte and the ML byte, then I think
> that change should be in a separate commit, with a proper motivation/commit
> message.
> 
> However, for the fix patch itself, I think we should just do:
> -	scmd->result = (DID_SOFT_ERROR << 16);
> +	scmd->result = (DID_REQUEUE << 16);
> 

Hi Niklas,

Thank you for pointing it out. I agree. Switching to set_host_byte()
is logically a different change from the problem that this commit
is fixing. There is no particular need for using set_host_byte().

I'll send a v2 to drop set_host_byte().

Thanks,
Igor

> 
> If that is sufficient to fix your observed problem.
> 
> I would also be happy to see a follow up patch that changes to use
> set_host_byte(), if there is a motivation that can motivate why that change
> is safe/valid.
> 
> 
> Kind regards,
> Niklas
