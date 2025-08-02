Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DAE1EF09D
	for <linux-ide@vger.kernel.org>; Sat,  2 Aug 2025 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754156974; cv=none; b=kRj+AM/MFTNOC029olceyEl4aQe4ZzmqubEeQw1rvcA92LuDtvH9EuEwx3Z/SOiTHpd3Ev9BXhLKaaDwU0IEPIBdlXovkdFdqyv/mBKw8C6IXwZAzc/2KXGDgm31bmG5A5Zq6fADINJ8XXTnknQgn5sjmv+1KKxJr9DptM6QrEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754156974; c=relaxed/simple;
	bh=b+6mXS0+kdii2tzk9OfeoOTQOVaItq4/WfrPRxU2alo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk1Ti6MYdsD1nE/4LV8NKNcnlV8quqkBF6A+Smt36aaNkOQ0DAZRB9NoXkP+EreRCMdRqzRP6gijR08E80R7UBTdcGkh5NPHkCRaGBxIv/J46eqw6HBP4iTe28HTa90p6FBC3vvL3EPVCH2zUO19qT/WYM1oh8LLUJqbWWzZeNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LelbDt0P; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LelbDt0P"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-240708ba498so127755ad.1
        for <linux-ide@vger.kernel.org>; Sat, 02 Aug 2025 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754156972; x=1754761772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpj+8x80P2Ew79V+OZrYOMYLbi6xyDg1pUV+oNkhF/4=;
        b=LelbDt0P6B/RIQW5Yw+aor+TimDGw5EwOdQ8fOFGPVSy1IIYi32+Cz0qBR+WIwrHlt
         xo/8P0T6DnDoZTH87FLSWL5LFO9YQJhBGZb3Lf7Bv1gBfmIJ6g20KVNZQskp9zdvNxsy
         1my2DDccR+uPxY3Ua/A1hQ6VYhQiPRDw8l4suCdaX6PKObKBuTIj969kw5gySA5KwwAl
         nnKZ5Mn8hPOviNWI8BT4mw/ROFVjVamrdp2CtO9idlV/1oL8aLcpNOmU5sgx9TlKqHW1
         t98W4AIMkk4V8//7xwdr2eUcDtVUW8+rkzRw60gqpv311EQLLxLtT6Vd/2zkIwq8Mtpp
         OJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754156972; x=1754761772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpj+8x80P2Ew79V+OZrYOMYLbi6xyDg1pUV+oNkhF/4=;
        b=IlD/vysjgYIUGW57yMd9Dz6dJGlbupwD/nek8Pfx+ii02nEF40HUd+a51gIqt9WgVV
         e6wAzYZRpp26CsSSlzc2iR6GaX/+1+HJ3aJM6vI0eUl6+ifqDnoFasn1lWvT+A6Npgx8
         wBohP4SAJ53Q6eoImN1O1JLgyU8SZLjrIFgWrpq4ANdBcjyf6JhH2PqdKpXfeHA13AjL
         9T3olsRZD+OHFnqAEW1fxVdUuD8qNTsTxhbwepZkzWgp5G1oXhqh3Vf890KIbHMk52nT
         LrhePuOq2+e54z+VjfZXdKRajehtJL5/e78wjNT0xASlLO1FcDsvnkDVJmCKzR6SVh04
         AqDA==
X-Gm-Message-State: AOJu0YwT+5PK7qCUullbILHUGJ4y+yxdJjETwyD+zLnwXqzi2wLfgkEh
	RsMJMlAu+pPJImJLJYVURkiZoPHtyt16wrazRP6r2VzoS8VvCXWnQrPkn+hFqdAFrQ==
X-Gm-Gg: ASbGncuxSoaGZ+fD2Cq9R0dXNJHtERUsmw72+8ouHJtIb2Flw7o8ktyQ5sKp7xpzXwB
	BwvKuN+wzdTnJdhtsnNo3lOa3WFNnM3mNDGt24SiHx8ymp77yPPb1ktHjUFg1/WRBaRyRm2zggA
	dOcInie3gklNJTHLrsG+sucOQ36vX64f2ZeAqr1dQTy64CwurkCtd3JgyvKCYW0CBZXDUUUVBU1
	ykWxl4qQOpyGIrgh21+51CAB3PYCAPJIpqBOGT5XD/KeUNAteEQq3LHNtZQsanbri6QN7ILxU3j
	MNpEDEtnWRi6/RPH3tjshUsTFlHmZ/eanyP29ZsplHZA1fWgWl/Fr7ar5v7digBTp3pe8OoyhwR
	oqNOI934ATr0un51woT/GNZtkEq5cMJM4NOQj5IF9x+Zv3CCMp2mht5FPOQ==
X-Google-Smtp-Source: AGHT+IHOzcbB3qlEN+hH5hfao7724ZiaJbHfFNqwz0hBbU4GUBcpKxw22GNGLCAww3vKA7cLl1nnKA==
X-Received: by 2002:a17:902:db11:b0:231:d0ef:e8ff with SMTP id d9443c01a7336-24248569ae1mr2512305ad.8.1754156971426;
        Sat, 02 Aug 2025 10:49:31 -0700 (PDT)
Received: from google.com (166.68.83.34.bc.googleusercontent.com. [34.83.68.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0cb39sm10319066a91.30.2025.08.02.10.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 10:49:30 -0700 (PDT)
Date: Sat, 2 Aug 2025 10:49:26 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>, Lorenz Brun <lorenz@brun.one>,
	Brandon Schwartz <Brandon.Schwartz@wdc.com>
Subject: Re: [PATCH 2/2] ata: libata-scsi: Return aborted command when
 missing sense and result TF
Message-ID: <aI5PpnFUDXfMnvbC@google.com>
References: <20250730002441.332816-1-dlemoal@kernel.org>
 <20250730002441.332816-3-dlemoal@kernel.org>
 <aI0jVxj7GoHMkncK@google.com>
 <822c1251-d3fe-4dfe-ba26-63128d9ea3f1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822c1251-d3fe-4dfe-ba26-63128d9ea3f1@kernel.org>

On Sat, Aug 02, 2025 at 12:33:05PM +0900, Damien Le Moal wrote:
> On 8/2/25 05:28, Igor Pylypiv wrote:
> > On Wed, Jul 30, 2025 at 09:24:41AM +0900, Damien Le Moal wrote:
> >> ata_gen_ata_sense() is always called for a failed qc missing sense data
> >> so that a sense key, code and code qualifier can be generated using
> >> ata_to_sense_error() from the qc status and error fields of its result
> >> task file. However, if the qc does not have its result task file filled,
> >> ata_gen_ata_sense() returns early without setting a sense key.
> >>
> >> Improve this by defaulting to returning ABORTED COMMAND without any
> >> additional sense code, since we do not know the reason for the failure.
> >> The same fix is also applied in ata_gen_passthru_sense() with the
> >> additional check that the qc failed (qc->err_mask is set).
> >>
> >> Fixes: 816be86c7993 ("ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> >> ---
> >>  drivers/ata/libata-scsi.c | 18 +++++++++++-------
> >>  1 file changed, 11 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> >> index 9b16c0f553e0..57f674f51b0c 100644
> >> --- a/drivers/ata/libata-scsi.c
> >> +++ b/drivers/ata/libata-scsi.c
> >> @@ -938,6 +938,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >>  	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> >>  		ata_dev_dbg(dev,
> >>  			    "missing result TF: can't generate ATA PT sense data\n");
> >> +		if (qc->err_mask)
> >> +			ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
> >>  		return;
> >>  	}
> >>  
> >> @@ -992,8 +994,8 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> >>  
> >>  	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> >>  		ata_dev_dbg(dev,
> >> -			    "missing result TF: can't generate sense data\n");
> >> -		return;
> >> +			    "Missing result TF: reporting aborted command\n");
> >> +		goto aborted;
> >>  	}
> >>  
> >>  	/* Use ata_to_sense_error() to map status register bits
> >> @@ -1004,13 +1006,15 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> > 
> > There is a redundant check in ata_gen_ata_sense(). qc->err_mask (is_error) is
> > already checked in ata_scsi_qc_complete() before it calls ata_gen_ata_sense().
> >  
> > 	if (qc->err_mask ||
> > 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> > 
> > The function will be much cleaner once we remove this check. 
> 
> Yep, we can remove the err_mask check.
> 

To clarify, I mean that both conditions can be removed, not just the err_mask
check. In the current code the err_mask check always evaluates to true so
the right part of the OR expression is skipped due to lazy evaluation.

Thanks,
Igor

> 
> -- 
> Damien Le Moal
> Western Digital Research
