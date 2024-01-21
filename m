Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C478383BD
	for <linux-ide@vger.kernel.org>; Sun, 21 Jan 2024 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705870843; cv=none; b=IoKL1j8IADAyhofLO25ksJrEmUjXo08Q+rtWd7Z0zAFnkQR3fhHJQVzMhFjjs5E6SdDfmVuZF/qFtbcn/RoOIqEdLCR8pSmthz9X2sKhTVs9YygeKRwaAwob9dRFbQ6mRPhdOQbuHu1YjPN9f/7J/WvtOKfRjY1Uw+PNV1SiQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705870843; c=relaxed/simple;
	bh=zlLzIMc0K+Hs3GtHLMJf/u6sjUkTFUvpoYJN1dC9mdA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kr+jCGgKLyeSzJarInM0nIdjIw3pjtAXPocM9aQupcR3489IVZSN/dEEh+PxkLUkNb62xfT/j+F520RhDsTnFGRG1Rfxu0k0hlkCMsGORDWT/4WHMAZs3paEiLuu22PnFc+iAX3NOQ1tiE8xzUOgQ08PQ1HFABT/CWzDmmD9P+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDmcjE0i; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDmcjE0i"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d72043fa06so105215ad.1
        for <linux-ide@vger.kernel.org>; Sun, 21 Jan 2024 13:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705870842; x=1706475642; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRZzT2f1JofCE2kB4k8BjPK4SbjBTzmzlRfHn5i6bdY=;
        b=RDmcjE0itntM4wI6gOXAdwNnKxIs7qzYEiR/bZzE/EobVpaMGxkjEAlnjS4uazePq/
         xzoGq+kxJ27WD7FOtHh2QsvSzs06gVCqny10oB6/ESAkYr3fO8TsU2RdoiRFsLUaOyAi
         wG6cYi+RHABY1g+o88gFSiL+4pyVWwQYqwvVbFX2n2kFqBMwJ28DcIRn7PsnTePT2z/v
         BAy/QvqrUS/4+GD4Dj+QjOkZG9AkptWLkVoki8UJHwQ1QAa6r+Lm98Omh50dEnbUtb7e
         J6gadp7bZZuYuohw5NY3fcZbWK7SpCELQog/M7Y76+vBANsvLEWcURHsY4D9HXTjMNZN
         fl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705870842; x=1706475642;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRZzT2f1JofCE2kB4k8BjPK4SbjBTzmzlRfHn5i6bdY=;
        b=E7oeAgO8aTDIRyYWg9PbUE7s1FdSZIC9aqEXXsmWOdIUuPQsgmAgiIWvw1qLwfD9Wh
         l/A6XIvV+I2yCdD32hZ3So0W3SKOCPSFG6eZnf+gMRJVcwjsnoAlW4yjVjkvd8q8M3fW
         LhMseUoHJfWIc+cOaqZiUzKVtlnR2Jfh6fADSlU6ScBqlWES9BHuC7ztqs2t5uOxxxEl
         eE7LA3axeBzJ0wXuxqogKLFjObYb6LlfOVUP/VU46EGUQUD78VindJlLylkkMwHt0nmx
         V05G2w7rg8bDbfrzDPG8Jc8ZICMp1K04w0OcCTHLV0Regf3rxOm8+jUPT6tYjfn51iCd
         zqPA==
X-Gm-Message-State: AOJu0YzBWHHGZfmcPWjFQnDcfn08DKE5Tcoqj7CNY60JFyRlQiqNCUjw
	TGdFFc818Qk0HBilsFk/zygXoinyhC51
X-Google-Smtp-Source: AGHT+IEXMNPZIS3H5wZZueT2jT74eobFzGlQuvq//fhxcAORa46mOSrn/8EHf0mLkfzQHYyU7j+f5w==
X-Received: by 2002:a17:902:ecce:b0:1d6:ffb7:4af9 with SMTP id a14-20020a170902ecce00b001d6ffb74af9mr161181plh.14.1705870841493;
        Sun, 21 Jan 2024 13:00:41 -0800 (PST)
Received: from [2620:0:1008:15:9c9c:e5a:9eed:f21b] ([2620:0:1008:15:9c9c:e5a:9eed:f21b])
        by smtp.gmail.com with ESMTPSA id sl7-20020a17090b2e0700b0028b6759d8c1sm8191663pjb.29.2024.01.21.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 13:00:40 -0800 (PST)
Date: Sun, 21 Jan 2024 13:00:40 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Matthew Wilcox <willy@infradead.org>, Pasha Tatashin <tatashin@google.com>, 
    Sourav Panda <souravpanda@google.com>
cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
    linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
    linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
    bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
In-Reply-To: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
Message-ID: <b04b65df-b25f-4457-8952-018dd4479651@google.com>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Jan 2024, Matthew Wilcox wrote:

> It's probably worth doing another roundup of where we are on our journey
> to separating folios, slabs, pages, etc.  Something suitable for people
> who aren't MM experts, and don't care about the details of how page
> allocation works.  I can talk for hours about whatever people want to
> hear about but some ideas from me:
> 
>  - Overview of how the conversion is going
>  - Convenience functions for filesystem writers
>  - What's next?
>  - What's the difference between &folio->page and page_folio(folio, 0)?
>  - What are we going to do about bio_vecs?
>  - How does all of this work with kmap()?
> 
> I'm sure people would like to suggest other questions they have that
> aren't adequately answered already and might be of interest to a wider
> audience.
> 

Thanks for proposing this again, Matthew, I'd definitely like to be 
involved in the discussion as I think a couple of my colleagues, cc'd, 
would has well.  Memory efficiency is a top priority for 2024 and, thus, 
getting on a pathway toward reducing the overhead of struct page is very 
important for our hosts that are not using large amounts of 1GB hugetlb.

I've seen your other thread regarding how the page allocator can be 
enlightened for memdesc, so I'm hoping that can either be covered in this 
topic or a separate topic.

Especially important for us would be the division of work so that we can 
parallelize development as much as possible for things like memdesc.  If 
there are any areas that just haven't been investigated yet but we *know* 
we'll need to address to get to the new world of memdesc, I think we'd 
love to discuss that.
