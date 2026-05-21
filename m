Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D832B128
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395508; cv=none; b=nW4tNJAtrB1o1X+iY+07KBO5AsL3fkhuQPQHfCBOX1jZsAy+zP2UAYPJ8HgQoXunvzSeduoBcBatb7hs7giK8Js79bda4h8dqHr7N//9CQR3rFdEdT4BCTdvjKfvJ64Y2erDAuGVGLSh6o1ZSkw7LMUEDuom1/sBpbS3/WlcF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395508; c=relaxed/simple;
	bh=Cj/YJTXnbsT6qNQsO/hL4N6W9867XSxsE7HnP9b/xdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqmBAIpkWmUs34AgDTdvWhB4bNDvnRvbEYz87LLH/qZqeVXdeeS9yq+1PZHEshXrLM4cg9B6veBivQwCsiieqZVQ+Ac7PvzDxlzyLN/fkGTrvgW1r90nIhJq5KWqZqSdPZjwdXMShpGqbeVKdANRFobPGv5XnjfdaEYG/X1PfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=P02KjUKA; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="P02KjUKA"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gM0SL4RhPz1XM0p8;
	Thu, 21 May 2026 20:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779395504; x=1781987505; bh=Cj/YJTXnbsT6qNQsO/hL4N6W
	9867XSxsE7HnP9b/xdg=; b=P02KjUKAfyFSjXEtX+XMJjMijIzEdaqkMCIVOpC3
	I8CMckGiMGa80n6BHZdmUGMul2uPxyH4RAxmYd8vRqYoxpDPJM7/TH6ksOOA3hdN
	8IWfA7Xu371NaT2HmZBLvdaJqVJkz0W4ngINotfuShYnqhZv5CNg8WQq8AL+FAnD
	fHNtfKrKiFBfWstcfXfNtghsQbwXqUgyrNXmBxWcuKOajI569eJc5UuTA+iQStZk
	b9+MYS4j8CJfwvQQo9v1qaXfen2PaPSRgHiGyzj2AdLV56cJCHBXAHzMaDX2h5NI
	bc9dWiUGTlLDvzfcQZ6mWfCYi+zCSRMWQ/vRLjwPldanMQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uyoUX0Fq1f_N; Thu, 21 May 2026 20:31:44 +0000 (UTC)
Received: from [100.118.237.20] (unknown [104.135.180.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gM0SH413Kz1XM0p0;
	Thu, 21 May 2026 20:31:43 +0000 (UTC)
Message-ID: <6c9f5d36-3daa-4eb7-8c1f-3fb81f62dbd7@acm.org>
Date: Thu, 21 May 2026 13:31:40 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] ata: libata: Enable context analysis
To: sashiko-reviews@lists.linux.dev
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
References: <20260521173347.2079560-9-bvanassche@acm.org>
 <20260521201706.5EBC71F000E9@smtp.kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260521201706.5EBC71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/26 1:17 PM, sashiko-bot@kernel.org wrote:
> New issues:
> - [High] The patch introduces incomplete or mismatched thread safety annotations, which will cause compilation failures under Clang Context Analysis.

This is on purpose and is fine.

> - [High] Adding `__assume_ctx_lock` inside a loop causes a lockset mismatch compilation error.

No, the __assume_ctx_lock() statements added by this patch do not cause
a compilation error.

Bart.
