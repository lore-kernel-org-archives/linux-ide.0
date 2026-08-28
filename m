Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4838D018
	for <linux-ide@vger.kernel.org>; Fri, 28 Aug 2026 05:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895830; cv=none; b=YJOxjOZvGf0E4uPHgonWZn4XdOmAq35AP5nAkyZ9sivP+iLiOEAdHWCk6O5rrHos6/glBKFeupWKlHluTDfsFITAAXezFG8D9XqQPOdM44PWkDbiJicWslBTi3vS0hzUS6BZU601kTIhYcwlvofkDrLjR3X2pXi0YGvUoti5bXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895830; c=relaxed/simple;
	bh=QY8YiOGMqgWCKy6qCnTwvboay5jx3xHGzXsdwwzvdzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1yO5VyjFc7nF4ugNnMJKh6ku3psQaCTtXHwEviD8LQsGCE0cPaOcry+pNEd5ISMFxbUcibtJEP1eVUKXEhPcFIukQdExdTbt44PFfLKctxzBc+NGD+bpZyDcBscbNjC40u36/e7GnTlEj2FPCqcDugiPIXVN0+5F9GWTaAp6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ1CvsfQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ1CvsfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C756A1F000E9;
	Fri, 28 Aug 2026 05:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787895829;
	bh=rFiu0dAFBhdgxweKqueKPRdN13KiWCttmGc8dsOdprk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QJ1CvsfQylBQa5w3CCna4WxfQjztzRFLNuvvAvC6s3QGg6Cucs7NzMrYPBqSCNW5D
	 pAHlXs24Nxf9kgLUpxaXRBzS98ERIUQAHwtwLr3jg777rpJBOlsWsdm0C6TY/uoArx
	 X2rfPYygz2T2zLgPxYmbMQsQiFQLJL5nAYaaqDxCV4uWjhy2DQCWXBXvDdX2Kt1x3I
	 iCXh0rouarG2f9f7ClejUklW0dIjGwHoKXe3y71ZZEjfIuiOqNGGEyZf5M8Vqpdvk5
	 vC14JPmDZgtI8cSEgAA18x7SognnZ43ZMg2GtdZIYjldt0z7Kz1nd/XlMP/vMzB8IW
	 +bgAa3VzrO9Bw==
Message-ID: <1f90bdf2-3aa8-4f39-9a32-627aeb400aea@kernel.org>
Date: Fri, 28 Aug 2026 14:43:47 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: clear HOST_IRQ_STAT before the ports on
 Marvell 88SE61xx
To: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>, linux-ide@vger.kernel.org
Cc: Pali Rohar <pali@kernel.org>, risc4all@yahoo.com
References: <50ebd35a-086f-40fb-887e-576e36e7a2b8@noerenberg.de>
 <df91dc9a-58a5-49e1-b208-507cb9593cd1@kernel.org>
 <ed203607-19a9-4dd3-89b2-ba94b1bde4c0@noerenberg.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ed203607-19a9-4dd3-89b2-ba94b1bde4c0@noerenberg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 16:58, Hajo Noerenberg wrote:
> 
> Damien,
> 
> thank you for the quick review.
> 
> On 8/25/26 02:51, Damien Le Moal wrote:
>> The commit title is not great as "before the ports" is not very clear.
>> What does "clear the ports" mean? Though I do not have a better alternative
>> title (yet).
> 
> Agreed, and "the ports" was meant to be the ports' PxIS registers, which the
> title does not say.  Would this be better?
> 
>   ata: ahci: work around lost interrupts on Marvell 88SE61xx

That is better!

> I tried exactly that: a build that registers the existing
> ahci_thunderx_irq_handler() unchanged for board_ahci_mv, taken out of the
> #ifdef CONFIG_ARM64, with a dev_info() so I could be certain which handler was
> really active.  It does not work.  The controller fails exactly as it does
> without any patch.

OK. Understood. Please resend the patch with the fixed-up commit title and we'll
apply it.

-- 
Damien Le Moal
Western Digital Research
