Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272B32ED54
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830433; cv=none; b=mE31rqXFDKvRk3wsSR50Lc+TtkK2w+UeWt5rybo4sVJwrOLTjqhEknlsDfvVPLcxVIIRa1ya3E8+0BxCVxejjtdtO135aoHwX0g1ahXArhDgHMtOpjcMgAPBafIE/sBXFp7MW5gv0vB96m5M1mZmcIfLnOaRiI/7wBg7dSBBtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830433; c=relaxed/simple;
	bh=KvGX+44SPYr6D8qIe1uXj80+DgpAoZqDnGfB0H8zb1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CARwliSts6Axlrkj4v9yp6vrrqhFDxo50gR3+HkAtjMCJ3RvPlsOXjVR08m05Va2A5oWWtKZs2G7oS4HYnn5wjY0RxO/koseeiOXiHeHjFxPjr+/XrwcEk/GbfhKjo6JPHb/6WPMudPdWVI4TogsF/jE0J7/4e5kNuXK2TuOj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=OYenKvK+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="OYenKvK+"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90e7bde5596so52859906d6.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Sep 2026 18:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1788830420; x=1789435220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fyMVY+2XETzDWaOQjFfSXpsUHtwGfs1gS31f7gitpY=;
        b=OYenKvK+eWtQM9po1yMAY19A6tXFHHJEi6uAS1XRGV4mUHaSBnWMJvgyO04nvJrtTD
         wxDvmZcN8DlzfyomJb3YUePSjhPtMOLrsplDdwSGteY6LKjI5agBcX/9cN1pULd7oyhm
         Ek1Lkidd+aud1rZIwHGGnEovN7u+ry8ZXKykSvdOHgWbn4OQy8tEoL/PWC3GXI4yuimb
         H5XV5Nx9nQ//5Ms71sWFCK3vDljdyclwL6kjXkEBYGyB/ttTE6w98ERRMqvE2gziVIjw
         MOGeuzc580cqHqtwsIpXUVfvlLYgU+dnn7+iUOnB02NV73NAQEBzd+kpbDzNdBHeUvtu
         0bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788830420; x=1789435220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3fyMVY+2XETzDWaOQjFfSXpsUHtwGfs1gS31f7gitpY=;
        b=jc8j3jmlhxk+fXBrcU+QkEPQ7F8nYHq+WFTTlRksX9YLDq0MiXM3eu6Ul5Y3BhW92M
         XL2CkyLDDTyQ0v0fZgK/VXsAWGkrAjcM0VdbonjNcSrVV+dBYSZxHnJFvp66Q+qFP3dn
         nHluB2GqW1lmDEvDgeuZ9Agk546aW0joP+NZecjuvKn6I1yQs34ns8qbHxoL2HwBRy+p
         ITYCQ5sQXHeLWWbwvniBEUXuLq39zrft9IUsm2ivZLa1JnVsBbrOmuXJsOfQmm2ZIiYo
         pTFsLtB65vJHMJzivL7CGzpVZl253fdQTl3XwkLFl1vcFZOp408aFRqMlJo4lwdM4hq1
         2/fg==
X-Forwarded-Encrypted: i=1; AKwUvBw4sHOFOiwxZbe9PxvRrp0o9RgMsKzgqB/oCi/tZK7wrSbhCT3i8HpH0qwsii9wzwDmxA/OP4zON+c=@vger.kernel.org
X-Gm-Message-State: AFuF++nwKMNEy7gWOB/Pkk5IFimR3JlO31iH2xLDzv25N2yHEQnWAaiP
	vU0cxpAqjr7IZClpPitUloDvDOrX9Fl4mvg2Yiiuy79CY54Lse73Q45zU3uPfAhXXA==
X-Gm-Gg: AYBFou2zYtPJMZDPWF9SeUpr0s51sKC1+Ig1q5LLuJi9gil5wVacdVw52Z3N3meIJsy
	Nnqc8Yo3ZFVmsEYdyPaXQZcPMUAg9yGYP1kiqkTv7f8C8yJepvMsa0W2tW8LCYgSkEr270FlmNe
	ZchGFd/Es9r1V0v1Ya1L3y6tv75VdDzWvXMAN4ysAf5xMo0XDexSNqLseSqEGxgwD6wSbs1jwZg
	vCLJFAFlugH+XZx4QNbIUYbnMzffc3ew7JoIHoQRiprBR5E4VVhU6FHxTiqpi6EBIFPGQrfN+FI
	RscbXtvowKm32YlWqkbYKhlckcEiHXwgFAIqLF8xyhShGTcMweiZ20m2N2fuTp4cJb+PfvxKHQV
	PvplZTh8rLu7WQT6i3Gs11WV0tiKQ+1aBV9LdRpMYF+/0sMQaJvoXp1IdLLEuYarNNIVzEHqvBk
	pi31BcX14rtQoJ4i8rQk6ryM4aT442N5pPCdne5OO2efqpezcbMMddpCTNE44zCtw=
X-Received: by 2002:a05:6214:4905:b0:90e:7e02:cc3f with SMTP id 6a1803df08f44-9103ef88dddmr126267776d6.18.1788830420097;
        Mon, 07 Sep 2026 18:20:20 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::7544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104049d30asm105322846d6.0.2026.09.07.18.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 18:20:19 -0700 (PDT)
Date: Mon, 7 Sep 2026 21:20:17 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v5 35/40] usb: storage: use 16-bits defined sense codes
Message-ID: <c4dc659e-8292-4702-8d03-933b9500430c@rowland.harvard.edu>
References: <20260907024343.1046387-1-dlemoal@kernel.org>
 <20260907024343.1046387-36-dlemoal@kernel.org>
 <fbbde389-d040-405b-8f87-f589c4890afe@wdc.com>
 <f65388b1-e299-4f1f-927e-445f6d9e77df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f65388b1-e299-4f1f-927e-445f6d9e77df@kernel.org>

On Tue, Sep 08, 2026 at 09:27:30AM +0900, Damien Le Moal wrote:
> On 9/8/26 01:13, Johannes Thumshirn wrote:
> > On 9/7/26 4:43 AM, Damien Le Moal wrote:
> >> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/
> >> gadget/function/f_mass_storage.c
> >> index a50743caf083..05e138968389 100644
> >> --- a/drivers/usb/gadget/function/f_mass_storage.c
> >> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> >> @@ -1103,9 +1103,9 @@ static int do_request_sense(struct fsg_common *common,
> >> struct fsg_buffhd *bh)
> >>        * FSG normally uses option a); enable this code to use option b).
> >>        */
> >>   #if 0
> >> -    if (curlun && curlun->unit_attention_data != SS_NO_SENSE) {
> >> +    if (curlun && curlun->unit_attention_data != NO_SENSE) {
> >>           curlun->sense_data = curlun->unit_attention_data;
> >> -        curlun->unit_attention_data = SS_NO_SENSE;
> >> +        curlun->unit_attention_data = NO_SENSE;
> >>       }
> >>   #endif
> > 
> > No sure how relevant it is to change something in a commented out block.
> > Wouldn't it be better to just remove the block?
> 
> Well, I don't really know why that block is here. Might be for some quick debug
> thing, so I left it, but made sure it is also corrected so that if the #if 0 is
> changed to #if 1, it still compiles.
> 
> I will let the cleanup of this, if any is needed, to the USB folks.

That block was created as a way of documenting the choice I made and how 
it could easily be changed, if needed.  Your change is fine.

Alan Stern
