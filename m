Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4842668E
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395428; cv=none; b=QmU5f6YVJXtF3rzVQWGwmAYgUtl8TNCR2WR85LVdjCtN4woMFk7PrfCu2kJrQxKqX1Q5tl9+mYEUKm8noxyULCzpqiyd09E8NwVSTPiV2VJ+G+rn7GdbQ9X5SdNHNENpFo5ikTh22hANzCUSiV2jqrmqpSGF89rSK5LN27HQyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395428; c=relaxed/simple;
	bh=BDdZ8IC661eqmlOAW7l4i8GtYHY/KNmPSM7XBmbTPQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGCaNfNSZrFIJDsSG+0DSeiVMLPxmXKO/qsRfh32E+WlTljJ9/JacfNsnY2tz75wWv4MCrtJ0uyYbwst/kRZ3ixhAB1Cr0ndrnSDq3d7BgUDXgtqFZVtryGdoSnMmlVkyIdWVPXPsT4n1smFvrk/JNbQaqRcdHQnqQgRjVpX4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SJCrZHUQ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SJCrZHUQ"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gM0Qq1594z1XM0p0;
	Thu, 21 May 2026 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779395424; x=1781987425; bh=BDdZ8IC661eqmlOAW7l4i8Gt
	YHY/KNmPSM7XBmbTPQ8=; b=SJCrZHUQLkms1g98rUv2iMyfSab1RKZ2EbzJMx9y
	FN79cYaJsxJc8mGmUDGhrdMReTeyUT+5efxQflKaWoqhMR94EVyetYY0k2aFRQRG
	vbq+7GGu8zMFEg67Z7uqeWUuJ+RYs2BiG9ioPezVA8cpymk8E/Q44N5ZdoM+SYxE
	E3SQ2V2WGGO996uKcA1jsFyhwjEnhkVJ50umfRzt33diTlzAwflHNSkroXAvNMNY
	GjywVizi08x7OKaH4lGxOBeyUq/fJXOAmv8HbwD/z7K5ATGh6T3bgvyd38TRB+t7
	CnXeyeaqHNu7L/Oz+5rUpx8I1llWNB7gxBO6n4L9dyGCSw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oBh1GFDc1kao; Thu, 21 May 2026 20:30:24 +0000 (UTC)
Received: from [100.118.237.20] (unknown [104.135.180.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gM0Ql6mpTz1XM0ns;
	Thu, 21 May 2026 20:30:23 +0000 (UTC)
Message-ID: <d5103cd1-5940-495b-823f-055631b76f03@acm.org>
Date: Thu, 21 May 2026 13:30:20 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] ata: libata: Pass the ATA port argument directly
 to ata_qc_complete()
To: sashiko-reviews@lists.linux.dev
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
References: <20260521173347.2079560-5-bvanassche@acm.org>
 <20260521184035.DAD131F000E9@smtp.kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260521184035.DAD131F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/26 11:40 AM, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Is the kernel-doc block missing the new @ap parameter? Since this is an
> exported symbol, omitting the new parameter might trigger kernel-doc
> warnings during documentation builds.

Yes, the kernel-doc header needs to be updated in this patch and also in
several other patches in this series.

> [Severity: High]
> This is a pre-existing issue, but does this code prematurely complete an
> active internal command on a spurious interrupt?

Since this is a pre-existing issue not related to context analysis, it
falls outside of the scope of this patch series.

Bart.
