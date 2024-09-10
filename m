Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5511A7061
	for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993486; cv=none; b=g/J4wjqpo7G557GRx3yM9LxFnZDPQn9m7ifJGrXhDpt7O8LaBHSqG8pIFzZeViyvlgDCj+wKDLC3py0sqoanCfKOyTBJAGlvlcfXPj68EHKdhkeGxfeK3tVXRrPIcboHqznr9Tj43BrLs7dm73hTxM0kHeUIbrksXbh17U79TWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993486; c=relaxed/simple;
	bh=/G60LDplpiUOLNtczH8pAta878ub+rGXfjbZSVUnOso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLjtecnoyQWbu7Voy8eh+e8BnHNbo9TwP0XSeeHTRpda0BNNRYV68ZOS6DnSHvKVGvhfzoCh7lc4Lhl80TtjACP0nx7a2aklnB2lXcApca/z3y5Zc7C8IpXtkykLncz9j6QvGdThujcVOj+azXNdEhZTpM8P3WFnL5IEFC2eRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nqk+Nvvg; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nqk+Nvvg"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82cf3286261so83512439f.0
        for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725993482; x=1726598282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+b5/+gHoJMj6mYLwHoTTL9tiXX7JbTcTJlobOiBur0=;
        b=Nqk+NvvgFAlKvXjhElvxjHhTLQpNSEED3O/0oPRQbyN0Q+bdkY71XyVi0P+oVBfd5T
         OrZt7Ntol2v8pLyfCLV+8kvdogyF3tkF4hsBdKmhPolLXlrzfoGDkaPuWu+2lBjGhz9R
         jMNHaPf+UWr5Fq9l259RBL221igjsQqrhVJM0J/D+h7i88p+HpHsaOG4TptN+8Rr1/CK
         ou9Jh+8Zp95tpN/fWNWjfrZrjvYxnhwti5vOvmTMZWrXogVWQLkoi0bqXLErgjkF/Xzn
         z4Da2pgpHu1tyk/e8K6e2GaeiNTF3Bu0ernmyO4frj5kpsPj1xJ1qh/+UpEfE7dY+lZx
         Bg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993482; x=1726598282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+b5/+gHoJMj6mYLwHoTTL9tiXX7JbTcTJlobOiBur0=;
        b=VlwUyCqIybpYfBeGxpw+xhlRWuYNEmdZkdVavwri5B/7Y6+kCdHV+XEntczlB6Hr+a
         oF+YM55xZJkHsQizMeCfpsbwC0ahGWZGCstQ5GNL3LVhXfcybL8wWkFDvpSPAp1wNOCg
         5fqECk7wsp+h/Rq+m63Syh0oiPmOT76qgXkfCA5BwvM9M/fzD72kEIjrE9LZnRETR0rL
         gNJnSjzfVaPCwHkil9y1Nu41LYiNhLWrgVtAvDGTEQiz6z8zedEtM+SM7ENbxawcjySG
         2L+ehe6EjeQykbJsTpxaBqB/B0JlyWldPsk0aczjP1qW7vTt0Zq+T8tcZvnEUotADwc+
         njUg==
X-Forwarded-Encrypted: i=1; AJvYcCVI4142gIoSUc5rwnogNmgUshYAYhZDNBVqURI32qqvMGcSn3I9Y+InfTFFyAIO6+z+VGU6Tr9jwjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHawavl1lRiDqkjZFa7GBcuUcGIvuEBqi8z12UR8VUR/RmyX3
	Ob/Yx/pb0ReNalG6/IBKgbf62xJC59B2WGfWDE+S+GPuKAIbJXBj+GdbUZdGIms=
X-Google-Smtp-Source: AGHT+IH+WdV06g96c6VJrsu/wXzo0TZ/o6LkDv/UbED5p/2cJsQduOZpv686J9OeofJrMhIYG3IyTw==
X-Received: by 2002:a05:6602:1553:b0:82c:f05f:6c8a with SMTP id ca18e2360f4ac-82cf05f9d19mr666839139f.0.1725993482337;
        Tue, 10 Sep 2024 11:38:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09451dbe0sm1732226173.19.2024.09.10.11.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:38:01 -0700 (PDT)
Message-ID: <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
Date: Tue, 10 Sep 2024 12:38:00 -0600
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-ide@vger.kernel.org,
 cassel@kernel.org, handan.babu@oracle.com, djwong@kernel.org,
 Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 kernel-team <kernel-team@cloudflare.com>
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org>
 <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/24 11:53 AM, Jesper Dangaard Brouer wrote:
> Hi Hellwig,
> 
> I bisected my boot problem down to this commit:
> 
> $ git bisect good
> af2814149883e2c1851866ea2afcd8eadc040f79 is the first bad commit
> commit af2814149883e2c1851866ea2afcd8eadc040f79
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Jun 17 08:04:38 2024 +0200
> 
>     block: freeze the queue in queue_attr_store
> 
>     queue_attr_store updates attributes used to control generating I/O, and
>     can cause malformed bios if changed with I/O in flight.  Freeze the queue
>     in common code instead of adding it to almost every attribute.
> 
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>     Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>     Reviewed-by: Hannes Reinecke <hare@suse.de>
>     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>     Link: https://lore.kernel.org/r/20240617060532.127975-12-hch@lst.de
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
>  block/blk-mq.c    | 5 +++--
>  block/blk-sysfs.c | 9 ++-------
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> git describe --contains af2814149883e2c1851866ea2afcd8eadc040f79
> v6.11-rc1~80^2~66^2~15

Curious, does your init scripts attempt to load a modular scheduler
for your root drive?

Reference: https://git.kernel.dk/cgit/linux/commit/?h=for-6.12/block&id=3c031b721c0ee1d6237719a6a9d7487ef757487b

-- 
Jens Axboe

