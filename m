Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F83B27D7
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831213; cv=none; b=T20jYdC6KFWacZ0U9sAeeJurw1dTYai1zVCcfYDg7lZ5DDTqFk8sm+BWREF1lqpOZjLOcc5VjmEi2dNcFeRgpYvZGR2cJkh4yiJbBwE/vcG4pqLyrFFP3p+zlaW3Mq4kViPyvmLR5O7YPhVJnDw7nPnhJzzdduey8+66MZfM214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831213; c=relaxed/simple;
	bh=Ij1BsaootoqxyaMEbebIOjlbRgbHnQwHujL7LtixJHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frCZJE4ZSrV4bbrMJaoc5XWM0yYF4Sk4MStuATbclEQ05L5j/xPkuWfVAWF+NqtMcf1KnJGjyDNPOouRsEyhxlflMsn5Z4x2I6QGAGos95esBreydDYpqFFntt/yEFxlRy8gp3zFWZsFJ/KEjTlX/hTxNtBfUiJzqBZebGIPfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=07kptOgo; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="07kptOgo"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gQ5bH5rV2z1XM6JN;
	Tue, 26 May 2026 21:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779831206; x=1782423207; bh=FBW8bXyoqfNXlGgVSoXh0JfZ
	R7VC3zBl1Sb+rb4XaJ0=; b=07kptOgo9oRXNBSbJTbLsgXmBzhASd5MOG6/Wtky
	0qZhlUFeM1Ki3LXQPPMXKZw2Grtq1pench4lV0gUIjuiAS5LpL/G8GuZBvMdZSaY
	XyfhpX6X/WYx58AtRyt5aX1qdEVv7SSbUDP3XfoWU1Hm6qmPgqCfXFVpNEV8ecLV
	LjuqGfwwSALc+Dln1iqwJrhIQwpwVf+C3KIHIOkwhdKDHAnKLgScJUjYLqFwwvn6
	3XPbIRrCFMWSbbyUu99FSZqCADUO1qWDLq3tBhNNBjnv2UTPkDxg887NGnPeizWQ
	Q8gC/+AXtRKGwTuiyu/GxmlnhdYUJbrhEQMMicQcELz1Rw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2qPyx_Wmos1g; Tue, 26 May 2026 21:33:26 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gQ5b866hsz1XM5jn;
	Tue, 26 May 2026 21:33:24 +0000 (UTC)
Message-ID: <e1e8b05d-6dc1-47c9-8b85-bfb2d756a204@acm.org>
Date: Tue, 26 May 2026 14:33:23 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Marco Elver <elver@google.com>, Mikael Pettersson <mikpelinux@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-10-bvanassche@acm.org> <ahW5MI_05l2bpKBN@ryzen>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ahW5MI_05l2bpKBN@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/26 8:16 AM, Niklas Cassel wrote:
> On Thu, May 21, 2026 at 10:33:37AM -0700, Bart Van Assche wrote:
>> @@ -5162,6 +5165,10 @@ void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
>>   	struct ata_link *link = qc->dev->link;
>>   	u8 prot = qc->tf.protocol;
>>   
>> +	/* Tell the compiler that qc->ap == qc->dev->link->ap->lock == ap. */
>> +	__assume_ctx_lock(qc->ap->lock);
>> +	__assume_ctx_lock(qc->dev->link->ap->lock);
> 
> When I look at the definition of lockdep_assert_held(), when building with
> lockdep:
> https://github.com/torvalds/linux/blob/v7.1-rc5/include/linux/lockdep.h#L284-L285
> 
> When building without lockdep:
> https://github.com/torvalds/linux/blob/v7.1-rc5/include/linux/lockdep.h#L392
> 
> Even in the case where we don't build with lockdep, we will call
> __assume_ctx_lock(l);
> 
> So my question is, why don't we instead add:
> lockdep_assert_held(qc->ap->lock);
> lockdep_assert_held(qc->dev->link->ap->lock);
> 
> Right now, there seems to be very few __assume_ctx_lock() in the code base,
> would it not be more consistent to add lockdep_assert_held() calls instead?

My opinion is that adding __assume_ctx_lock() in the implementation of
lockdep_assert_held() was wrong and that this change should be reverted.
Most code annotated with lockdep_assert_held() is suitable for compile-
time context analysis. Adding __assume_ctx_lock() in the
lockdep_assert_held() definition suppresses useful diagnostics from the
compiler about a lock not being held although it should be held.

Whether lockdep_assert_held() or __assume_ctx_lock() is used to help the
compiler alias analysis, there is a risk that these annotations are
incorrect. My preferred solution is that a new macro would be added that
supports expressing pointer equality in a direct way to the compiler 
alias analysis engine and also that evaluates pointer equality at
runtime. However, I'm afraid this requires compiler changes and changing
Clang is out-of-scope for me.

I chose __assume_ctx_lock() because it is evaluated only at compile time
and a compile time annotation is sufficient in this context.

>> @@ -1149,6 +1154,9 @@ static void __ata_port_freeze(struct ata_port *ap)
>>    */
>>   int ata_port_freeze(struct ata_port *ap)
>>   {
>> +	/* TO DO: fix all callers of this function that do not hold ap->lock. */
> 
> Please write this as one word, i.e. TODO:

OK, I will make this change.

Bart.
