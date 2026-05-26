Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F438F633
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811017; cv=none; b=TQIrDBH256ZB4BjunD0NNKSY+g0egYicVrweI+CleGhpRhdY6Up8olTj6n0yermHP+AnZYHXBmMvO0c2KB9yapj/xKF89vcXsN1gmgj463qI/TUqB6Z2fRtNrkEHpxCKnUElAu4JO0p6SiYwelUNCD8ijgGneP1zQXtppQ0obDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811017; c=relaxed/simple;
	bh=gGpi5KExTU80obdL6BDhy5dpSQp2rREuoLxAY9GiqsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyaXuvUdkofp6jf2t7JD2RqqBO/yx9tKfCqxwPXgHPbh9RmphRG/HzFT4hJanNUcwU3pLUQaQL6mTYSZ7XCGudgeleY9MeZPBSrnK6jZrVPntFD9ThZ2olycpB9RH3YQgOr8lV7Q3fKp3tI9pIjqWYq05NQIxF+vgaTSfewc5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Cd4PkC5F; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Cd4PkC5F"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gPy6v0jvnzlfl8N;
	Tue, 26 May 2026 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779811012; x=1782403013; bh=eb5ddf0EeLMGpr0pf02grRl1
	wGwspDEPaXRcYDzb6gE=; b=Cd4PkC5Fj0ToioFQ10eJQ1ys69TtA/63aM5hPLsZ
	OLdWU1gkKMtsE+ulYh1ugZgDRwmZ1hpVB5auP65M+tChgNkTdvo5CfpkCyTB+19o
	fQtG8L8pWO3P17ZyqViJDjzqpVvTN/Whim9u+UaFmaeQ881O7hxQc5F8CXBIv6an
	R49ByCYijk4YcVegQ2U3X3SaC0T4xatSnce305w7WsDfqqYr6xMHY84r4Z0z94ln
	t2Gvcx0UcXO42zPUYp+FbVHwpA1uNgt9mvkukr7Qi37hQl74xRQEssWXu05nfAj5
	c1xFUk9KdaJnKdv2NRa34Qc5xTwJwHmckdh64bVGr2Sbqw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sZqCx6nPrQt9; Tue, 26 May 2026 15:56:52 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gPy6p4KZxzlfpMC;
	Tue, 26 May 2026 15:56:50 +0000 (UTC)
Message-ID: <4ceff843-148c-43ef-ab74-ba8999412f7d@acm.org>
Date: Tue, 26 May 2026 08:56:49 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] ata: libata: Fix ata_exec_internal()
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Marco Elver <elver@google.com>, Jeff Garzik <jgarzik@redhat.com>,
 Tejun Heo <htejun@gmail.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-2-bvanassche@acm.org> <ahWjcGUeSo76OIs3@ryzen>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ahWjcGUeSo76OIs3@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/26 6:43 AM, Niklas Cassel wrote:
> On Thu, May 21, 2026 at 10:33:29AM -0700, Bart Van Assche wrote:
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index e76d15411e2a..3d25dec6ac6c 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -1540,6 +1540,7 @@ unsigned int ata_exec_internal(struct ata_device *dev, struct ata_taskfile *tf,
>>   {
>>   	struct ata_link *link = dev->link;
>>   	struct ata_port *ap = link->ap;
>> +	const bool owns_eh_mutex = ap->host->eh_owner == current;
> 
> We have similar code in ata_msleep(), which does:
> 
> bool owns_eh = ap && ap->host->eh_owner == current;
> 
> do we perhaps want the "ap && " here as well?

I don't think we need this since ata_exec_internal() unconditionally
dereferences the "ap" pointer and hence would already trigger a kernel
crash if "ap" would be NULL. I'm referring to the following statement
near the start of ata_exec_internal():

	spin_lock_irqsave(ap->lock, flags);

> Otherwise, this looks good to me:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Thanks!

Bart.
