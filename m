Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AC37F75E;
	Fri, 26 Jun 2026 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473895; cv=none; b=OKc8CS1MevBAjaUQ3KZK5+u2gEylTDSJXMwMPP2dJ2ZJgv3FvRRT1n51NSydi5Foz3JZz0nYILioT7JM/qoEr2Bj4BrI0/mXKpWC9l36kmK7UO3PUOEwWaG/PqKU7FESY6+NS0+3P56e5MItTcYFOC1qm2fohD9ya+z1FhU6GFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473895; c=relaxed/simple;
	bh=ADYc+KelG6si0MtrEuVY+hB3EMIV6ITqYhIjXMAl0so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JE4nPi+097EsIMK0YwKIkC9DUS4CDBHPK8CTNK5w2tQRaKzZ7Uqe9K32TOPkti8L52FHnGpGnhwnI9O/J7dNWJ7YQ+/y86NvBceo1TGmNeyQR2BdJZCGL6gDTo83aLZQ4td1KvmYtuDzo4KHG0rwJr/sSSxqiI+r7hre/DghK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2UWTNKV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2UWTNKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657211F000E9;
	Fri, 26 Jun 2026 11:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782473894;
	bh=N68r265PDtHuwAMY/IsLEoTm053mJ6JZrcgwGORtfLY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=j2UWTNKVV8cTmbwnJ00pCE+Zy/MCHwhHJvmNSV+YocT/MZrzBfrwz6qQs8BvawhBo
	 iA2ixhhqEnTr5F4hTHKosBtJGbqXfrzLFA8T7LrdNoNdFGtn1xmUV1P8+SQVa6YLo5
	 T2cy6XAWkzxIuQT94l7XKboNgd0kmRSFxtk5ayKJJcIxQwmGezDaMo1ZlkWZSU66u6
	 izodo6jt1sBO72g6DXVO9VQQ7i2d/zsAe7gE2jZfA3Kasto1AgcZLJzeI2g0g9y7k5
	 7tkaTsd1y8iw/3rPihGeWbLqgz0wJT61Ug8giR09SnMjTjyQzx0/SGL64cUqdRFJD2
	 pXV9BsnoA5mZQ==
Message-ID: <d45baac9-df6c-4e75-a94c-f82cdc91e1c2@kernel.org>
Date: Fri, 26 Jun 2026 20:38:12 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_gemini: unwind clocks on IDE pinctrl errors
To: Niklas Cassel <cassel@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, Linus Walleij <linusw@kernel.org>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
References: <20260626085848.40199-1-mhun512@gmail.com>
 <d1b55e87-cc63-4851-9dc5-94ee9d326333@kernel.org> <aj5j5N2ROauxUEBF@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aj5j5N2ROauxUEBF@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 20:35, Niklas Cassel wrote:
> On Fri, Jun 26, 2026 at 08:32:02PM +0900, Damien Le Moal wrote:
>> On 6/26/26 17:58, Myeonghun Pak wrote:
>>> gemini_sata_bridge_init() prepares and enables both SATA PCLKs, then
>>> disables them again while keeping the clocks prepared for later bridge
>>> start and stop operations. If gemini_setup_ide_pins() fails after that,
>>> gemini_sata_probe() returns directly and skips the existing
>>> out_unprep_clk unwind path.
>>>
>>> Route the IDE pinctrl failure through out_unprep_clk so the clocks
>>> prepared by gemini_sata_bridge_init() are unprepared before probe
>>> fails.
>>>
>>> Fixes: d872ced29d5f ("ata: sata_gemini: Introduce explicit IDE pin control")
>>> Co-developed-by: Ijae Kim <ae878000@gmail.com>
>>> Signed-off-by: Ijae Kim <ae878000@gmail.com>
>>
>> One of the above 2 is redundant I think.
> 
> The tags are correct:
> https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> 
> "Since Co-developed-by: denotes authorship, every Co-developed-by: must be
> immediately followed by a Signed-off-by: of the associated co-author."

OK.

> 
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
