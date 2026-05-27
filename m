Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDCC389459
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910510; cv=none; b=awi10y0I+/+WPMAZsHaBKhl51zdk0oioxQboutfIy6vhfGTitFWs5uVoWM33p0PDfdo1IoBRXjTbApa8MguleSS6PLiepPi5BMuGK2RcO7IYTcPVRegAGc8tTvxooxkSlg7mtkjgSh5kJFLUezGqe+AovX6WZGkLVJwKm3OH/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910510; c=relaxed/simple;
	bh=cMTXQhuakm6idmmy/3D9v3AyTkb5ds9yGqBGSDujO+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7Ktr917ZaHZpONYdJdwHG30mzcztdBFnN2cX3oaviavGG/xkJFkBuUXPzyI2zj7nYTer2fwyTRlnCRJFgbCFOxlyfL4ZirPmMuABKFoKeidlxvnfGPZk58V/q2vMpHD3HMKDqZqp7EdrXkpcIFvF6EdodPJknaFmX4K35A8Xd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM2qbvKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM2qbvKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974751F000E9;
	Wed, 27 May 2026 19:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779910499;
	bh=OdLA5ITWnbb7is9/fh1bLCGNhrsBMDYGLADyR3Q1McU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WM2qbvKvEVF1cekeB/GF5TvNT+E+58jDGOKWje0uI6VcIi5GAykfaFCZ5mr5N/ccl
	 RqqwM6kYjB4udJGuAHwyraDK08kEbNEfAMpHYe/Y/K255LJVqE9jKRkmgmi1XjrsEB
	 CXMvwUzROZjlMxhvGRYelcHBHkvI3PZJ5bVbGmdKFw5Oa721Zmc7xEAPA5KWKvZ94F
	 Eu7Oxxr8l+QPUEtUlgu+QbKu0vVKdN75DArCUPGAI2YYlbI2WJjRFdLi/EvGFYaYwd
	 c6/rSGbcCipjnzRo+Wwa2IxTGpIJ+fKL7UYL16B5QNEecfvtfRI4rpOvuVpPg3mh8J
	 ARX2BW6lGNumg==
Message-ID: <4481fee3-0f5d-4580-b502-d1237bc791e2@kernel.org>
Date: Thu, 28 May 2026 04:34:57 +0900
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
 <20260521173347.2079560-10-bvanassche@acm.org>
 <28915fc8-f2a1-4372-9f09-25f638585e0c@kernel.org>
 <b3ef2857-2023-415c-bddf-09c8b115b4f5@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b3ef2857-2023-415c-bddf-09c8b115b4f5@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/28 3:54, Bart Van Assche wrote:
> On 5/27/26 11:51 AM, Damien Le Moal wrote:
>> On 2026/05/22 2:33, Bart Van Assche wrote:
>>> Annotate all functions and also their direct and indirect callers with
>>> __must_hold() that have a lockdep_assert_held() statement in their
>>> function body for the host lock. As one can see in the comments added by
>>> this patch, locking is missing from the following two functions:
>>>   * Some of the ata_port_freeze() callers.
>>>   * nv_do_interrupt().
>>
>> What do you mean with locking is missing ? Do you mean we have locking problems
>> and bugs ? Clarify please.
> 
> Yes. It means that there is a call chain from the code where I wrote 
> that locking is missing to a lockdep_assert_held() statement for that
> particular synchronization object.

OK. So this shows that improving lock annotations does find issues. Nice!

So please at the very least mentions that in the cover letter, with lockdep
splats or compiler warnings showing the issues. We need to fix that before
applying your patches. Ideally, your series should start with fix patches for
the issues you found. But if you cannot do it, we can look into it.



-- 
Damien Le Moal
Western Digital Research
