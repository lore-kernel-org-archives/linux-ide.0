Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252B30566F;
	Mon, 20 Jul 2026 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784588555; cv=none; b=GVBPggDMn3FIvLoW2rl3UPKWhSNcT8LwjP5/+Z0ct8A95W7yLVlK/jXWbGhERkwSicYcejkSfgmo6Ng/fEzla4YKYnWc6y8K1UG0th4LDWkkOYEFxyEVvUgGMh4ZzAEOD0mcS1xaD83A4Z/xBSLSA5V8+BQK9vcTIjCVqbDnPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784588555; c=relaxed/simple;
	bh=VBXpq495oBuYWABdv9f5Ti4OmI4iAWmIz/Zz+TEGKdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acsRCqm553ErEd13F8ZUAwYBd0sZB9LlqWGuQWgSlkjU8+EGM2bIxqdlRmmtx+Z/DHAKATsgmKd+UGdaU+SAEGDvHmhGGcSqaR1cc3zq7z5lBHl2wx/z5HvgvBWTCunJDlvn6b6I+z6aSa/ydQ7Cvk0RdI9Kf9pRKggR0S9t49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILyb6rYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILyb6rYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372EC1F000E9;
	Mon, 20 Jul 2026 23:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784588553;
	bh=PnW0lZd/JsTnJbPqyIclWVPnCm2B6xPQbEZiok5Yhi8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ILyb6rYVRUYE67uRr5/622CA/wZzg0PNJlCQLHXjYnMSnQnWd0tJcX4oMOSfFhuMk
	 6GCsa/ziZTR92DMHJ0rvxkClz99ZWyBMeNimh9Czml6ISx4W6tR9xIM4OPPzGWhpVH
	 MhcSvs5f09wcF5ossvM1hZcObfOplj/8s1QdONIhQ6fo5wGh1XsKQuALmWzaZYoiQP
	 ALCmU4aZCe7jt4XnXiNlftOuoYKjO0Pmeq15YTWfUCZJcfn4JQY60j6E98bpelfEGr
	 UC9DTRNFLuVj/iJH1bUiBTSY3jAvyBo5O5yaTwH/uuYk4evJPZ2WqtVPKIGPF7h0td
	 e2iNtp5TCqBCQ==
Message-ID: <51f5420b-4eac-4f7e-9da6-727bc027bc23@kernel.org>
Date: Tue, 21 Jul 2026 08:02:31 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_ep93xx: add missing "cc" clobber to inline asm
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260601183458.11448-1-rosenp@gmail.com>
 <CAKxU2N_Jwq4jqS7ckqBaXpAskeKtu4Giou7ssNvhhV8j7ROxBg@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAKxU2N_Jwq4jqS7ckqBaXpAskeKtu4Giou7ssNvhhV8j7ROxBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/26 06:09, Rosen Penev wrote:
> On Mon, Jun 1, 2026 at 11:35 AM Rosen Penev <rosenp@gmail.com> wrote:
>>
>> The inline assembly in ep93xx_pata_delay() uses a "subs" instruction
>> which modifies the ARM condition code flags. Add a "cc" clobber so
>> the compiler knows the flags are altered. Without it, the compiler may
>> reorder flag-dependent instructions across the asm block when the
>> function is inlined, potentially causing incorrect control flow.
>>
>> Assisted-by: Opencode:Big-Pickle
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> should I resend?

Oops. This fell through the cracks. Yes, please resend and add a fixes tag as well.

-- 
Damien Le Moal
Western Digital Research
