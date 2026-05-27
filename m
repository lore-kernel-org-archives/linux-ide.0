Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457DD329E6A
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908076; cv=none; b=i0naON9gadSWOdUh83iy4I1k3W18qo+A+eUL+zO9Oz6jO4H7RWxOcSqsZBJ/8dR9YYMp+LqzP/zPcj1cVMELE0zJ2yI+j4aWAZLFQ63WimH+FY3LEKMqSRVFPZcKC1ZNUTjpsBX/YJYJ5vJ9kxsmggdJLJxOyL+NOY63pfQ87pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908076; c=relaxed/simple;
	bh=OvDNvJlmBESXFS3MsHlUutW09QwToLRNb5KBIQJxLcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlmQ8vj2hshqNrqVD5YLok45QMWP2ea+8yKEkji1ibA4dY4rdn1eps/ydUrgY50TbC6B/PKPibNGU+fZzCCKJwPLqWY9G/ORap/IS1Y5Jng29z07v9X2+Kpz+U8RN+OTUv+xjkIbwak0Xk6EuXXq3SR2DrjRiXdSN5TXmStZnu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=INfcy7id; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="INfcy7id"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gQf1M1kvnz1XM0ny;
	Wed, 27 May 2026 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779908067; x=1782500068; bh=WMsSoy5zvNQkjmVtyRqiVRWV
	RgPUgGjAygwqOGNbUvA=; b=INfcy7idhLuqmdU1rUTV0VnEjLPQu2oMuBk8MFcO
	ZZ28bEI9xSgRdUdjWwolRrQZucfzPN6SskyX3stxMQFs7LHp7nkITUI/HcS0TT7l
	JU9sOZMzmPxLlo60cxJ5Nm7B/KIN4ghQq1Qhu0xrkhLu+nX8qkGb2TYEAhNWqST7
	RScmBhrw3gmSC2qIeVcvwaPa0eKoS4TzXXwKwoM85/DgMllkwiRFeKcYJUSngYjz
	O3yPoH5eck13JMu8ljI1131Us1zJtUnsBj4MnoeaVvObvdlSR9fbMRtPE4YsYvJE
	++IA/gpxbQSWksK6G3hUb+JrRL80XunZqYZWEJDrsfSWGg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DoFq1amOJwt3; Wed, 27 May 2026 18:54:27 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gQf1F555hz1XM0nl;
	Wed, 27 May 2026 18:54:25 +0000 (UTC)
Message-ID: <b3ef2857-2023-415c-bddf-09c8b115b4f5@acm.org>
Date: Wed, 27 May 2026 11:54:24 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Marco Elver <elver@google.com>,
 Mikael Pettersson <mikpelinux@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-10-bvanassche@acm.org>
 <28915fc8-f2a1-4372-9f09-25f638585e0c@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <28915fc8-f2a1-4372-9f09-25f638585e0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/26 11:51 AM, Damien Le Moal wrote:
> On 2026/05/22 2:33, Bart Van Assche wrote:
>> Annotate all functions and also their direct and indirect callers with
>> __must_hold() that have a lockdep_assert_held() statement in their
>> function body for the host lock. As one can see in the comments added by
>> this patch, locking is missing from the following two functions:
>>   * Some of the ata_port_freeze() callers.
>>   * nv_do_interrupt().
> 
> What do you mean with locking is missing ? Do you mean we have locking problems
> and bugs ? Clarify please.

Yes. It means that there is a call chain from the code where I wrote 
that locking is missing to a lockdep_assert_held() statement for that
particular synchronization object.

Bart.
