Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C73203B6
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908126; cv=none; b=ZqVZfGOLJBUBwdHIt40A5Smeb3CX1/dI+8VakgkcLOk22mv9dmZOmihPFdBtXj6IvWgQrgQAHZpKsdStDPiwrVg3HSaqahYn6EWqcIXdyVIri6Uniy/P8vtXgsNuT3UkLMNtWELISmzClzIyeMq98WQV84qvN0QQM7BTkG/GvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908126; c=relaxed/simple;
	bh=UjrhbfZjkcGybZYu8ZVDlFgSfCYwE6CmW1H63/wHGs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzoo6p4MmJLieyj1iAiyDmN9cwB6a5N4+SbCznpVy04Bz/ZnZlpJNlb3wTCMoBmjoQOgJnJwGG48C4GJYmWOMVcNbex9wLK+hGF7CvpIdK9qXbmCrAaDYLK8jGqttUC76Zou2SosZGUjg4rLhtHg7xuVg4lw8VXbo8vUYug9s7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XwD2Fysi; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XwD2Fysi"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gQf2N2kPxzlfvpG;
	Wed, 27 May 2026 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779908121; x=1782500122; bh=Qq94/kNEUCYLaOu0bk7kfwpK
	PPxDcVH4v7DflS8SUs8=; b=XwD2Fysi3hODLfBrmrKpqCAGAaQby2RKWU7nYeB/
	7wXjJXgQD+2Hi59l/tyWPPXXu82I+b3iXycBbER6BiY4kKP5VZ6V4/YvF2nlZCpf
	4JiCf8OmYFh2dfGvsLocqIukZH4/yv63QelHKaWRQgSHMBP1xpTOLAqVnuycJp8S
	sA8XIo1fpU2oxsLBAK5lj58/oM3jPX7Gzis5n6yNZIWftcYEDta4w5Vcscdbc3py
	6EAAVI4ALD9k6PhkaKKOrtYAu9mYSEapUPuas6Quo/AdkyJK+bt5Da6wwO6Uo67G
	iDZG7GUXzX0+Nyove5idO9bQWcB4MFNU5CKd9VFu6sPleQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qr5f529vaDPh; Wed, 27 May 2026 18:55:21 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gQf2J5RSdzlfwHM;
	Wed, 27 May 2026 18:55:20 +0000 (UTC)
Message-ID: <fcc80572-88da-4e16-ad09-69819f43cd73@acm.org>
Date: Wed, 27 May 2026 11:55:19 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] ata: libata: Pass the ATA port argument directly
 to __ata_scsi_queuecmd()
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Marco Elver <elver@google.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-3-bvanassche@acm.org>
 <ad5c6534-d161-4c17-81cf-dd2b944ebe9f@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ad5c6534-d161-4c17-81cf-dd2b944ebe9f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/26 11:43 AM, Damien Le Moal wrote:
> On 2026/05/22 2:33, Bart Van Assche wrote:
>> Prepare for adding lock context annotations that refer to the ATA port
>> argument (ap). No functionality has been changed.
>>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> I do not have a strong objection to this patch, but its justification without
> the annotation change together with it is weak. This change is introduced
> because you want to add a __must_hold(ap->lock) annotation. But why can't we
> have the annotation be
> __must_hold(dev->link->ap->lock) ?
> Or a simple lockedp_assert_held(dev->link->ap->lock) ?
> 
> lockedp_assert_held() is for runtime. I am not sure if this includes a
> __must_hold() call for compile time checks, but if not, what about defining a
> lockdep_must_hold() function that does ? That way, we can have both runtime and
> compile time checks.
> 
> And a similar comment applies to patches 3 to 7.
> 
> So in the end, I am not sure this is needed. See also my comment on patch 9.

Hi Damien,

For every patch that is left out that adds the ATA port argument to a
function, one or more lockdep_assert_held() statements will have to be 
added. If nobody objects I will leave out the patches that add the ATA
port argument to several functions.

Bart.


