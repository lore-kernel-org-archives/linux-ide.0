Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93737316199
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835053; cv=none; b=j9voBR96Z3S7KwSngb5pGSl1RdOdqclcNhykqHb/Mincqr2Ei2qbG+y35BbZ5jBuMXNtmUWaGyT6KYlZtB3thKh/EaRiOKuPQQNx6BNLt8T8HHXEhH4cBSqYlgxa49qX05oXwWcyDsIAKv/iqE/A3mcH5kqLID//IVIlA9n2dkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835053; c=relaxed/simple;
	bh=QKa/sFaghfCOMWsgUsHoOf42UXHn+LojqrdRJ5LY6+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMmFw79xOPohTfMDuYsu++YwEBcPF0IW07BK+ei+B8FGYpluvNwvRIE0k70FJQl86N+13IX3+80hELrqsxykEYGRZOr4BpLdjz8s4ctMe0cA21CSz7+7pC80WbizMDIamEc9VIQPQGZmaxmi5HDgj4rKngI05kNv6ycUWA1S6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK4Ty+0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK4Ty+0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383781F000E9;
	Tue, 26 May 2026 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779835052;
	bh=VE47NIvB8vuslxsGWhrNlno5SmWQCXw3Dg8dg0CNk28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DK4Ty+0GKezvOGzYShh0S0rBuQRpSyrN8JFK5W6x6qPhPz0tHDNCPg8U45QXY5wyy
	 KbDFH5aSMRMOVaBsC0cWUfFCZMPviW01bn/cK//x22Ezg2ksrVwFoEznoMSqA/KRsa
	 9RD+rl9dz5QOoY6isqTB8EYzri7D67d8K/4cztzBKt4/xNebQrAwP2WjoHIQgmuTcm
	 cLUXV6jRcGJZws3vCqOumjTJ/t3yOUhPtInsK/wWiM9erkAdhwhheMM9VQXT8eV/lF
	 d8e+b0sEyrQXbo3ccI6huU66He5Z4M6/qbv/L8xawKKqH71a4ipwkhsOtMOuuVw3ZR
	 ql8xjurK111PQ==
Message-ID: <713b4ff9-0a7a-4241-8fe2-201ba52e1d79@kernel.org>
Date: Wed, 27 May 2026 07:37:19 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
To: Bart Van Assche <bvanassche@acm.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Marco Elver <elver@google.com>,
 Mikael Pettersson <mikpelinux@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-10-bvanassche@acm.org> <ahW5MI_05l2bpKBN@ryzen>
 <e1e8b05d-6dc1-47c9-8b85-bfb2d756a204@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e1e8b05d-6dc1-47c9-8b85-bfb2d756a204@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/26 6:33 AM, Bart Van Assche wrote:
>>> @@ -1149,6 +1154,9 @@ static void __ata_port_freeze(struct ata_port *ap)
>>>    */
>>>   int ata_port_freeze(struct ata_port *ap)
>>>   {
>>> +    /* TO DO: fix all callers of this function that do not hold ap->lock. */
>>
>> Please write this as one word, i.e. TODO:
> 
> OK, I will make this change.

Absolutely not. If this patch requires fixes for problems it creates, and these
changes are not included within this patch, then the patch is simply wrong.
If that is not the case, then please drop this comment as it means absolutely
nothing.

-- 
Damien Le Moal
Western Digital Research
