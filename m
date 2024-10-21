Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E711E6DFC;
	Mon, 21 Oct 2024 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514100; cv=none; b=RiA87lxEtjqU4TCusPFuafCENnCHktN5D01oqorUygJFLHKqtFNLMLiShYkc6f1q2H35v4BySO+enUTSe76IQOK9H6AJfhJZxcIooU7QhCv3XOQ/O3Eu774YAEwVTDDFEMRPch4TcqgQLPSSSoluva6VbwxWl0wKLAiUydBpltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514100; c=relaxed/simple;
	bh=VZOZCsa7qmUi1UJAs2g6UE5vKe3qppCZnU+/JmMs3MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqSQLJgO8GKKYKpX5o1TiKeMNO8aXO7aBn9XcxAlSMAjWi+KiwfOvyW6/Rsu1R6rnQmqdTnMW0+iI5lJGdPSoK130r1CK6l4j6LajXJBrOyJldkmk230BusSlZqNAe28/f8ItGXklMGgWaCwwXF/ysGzxiPBnJBxilU8GPDq7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir1E01Hk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir1E01Hk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2609EC4CEC3;
	Mon, 21 Oct 2024 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729514099;
	bh=VZOZCsa7qmUi1UJAs2g6UE5vKe3qppCZnU+/JmMs3MM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ir1E01Hk4ahjBe1tmsfx5Gf2r2s8a23b73oDLRtW8dM4ZpsNVVSH/LHHWTLYEH2wX
	 QQqAFDsITMAlDpiHa96cI9PRGxWcfBIcdT0kT/RNR9eYnM15jhQvbEyEmgCMdP0Sb9
	 7SMvrp7LApAfACXBVCeaVppnQThqHx//jvk3Mw9Yc/rwbG2er2IT+cIMAh25BdTp9t
	 JGCkLHcM8n4wJNkk7GiQEf6wWlmJ8twc1XrTDa7hjlE9rLqHqpRRX+R6xrpiutR5d8
	 Tq4QnGUviSZAClOLyyLrSMtwHlmoLUj1Ych5UnvSYwP+vtsN1EsxbFiTTRtlAMp/Uf
	 aWZynCA/UBeug==
Message-ID: <6cda84ae-c07a-4905-9cf8-12622dab33ee@kernel.org>
Date: Mon, 21 Oct 2024 21:34:56 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
To: Niklas Cassel <cassel@kernel.org>, "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 linux-ide@vger.kernel.org, yi1.lai@intel.com,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
References: <20240909154237.3656000-2-cassel@kernel.org>
 <ZxYz871I3Blsi30F@ly-workstation> <ZxZD-doogmnZGfRI@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZxZD-doogmnZGfRI@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 21:07, Niklas Cassel wrote:
> Hello Yi Lai,
> 
> On Mon, Oct 21, 2024 at 06:58:59PM +0800, Lai, Yi wrote:
>> Hi Niklas Cassel,
>>
>> Greetings!
>>
>> I used Syzkaller and found that there is INFO: task hung in blk_mq_get_tag in v6.12-rc3
>>
>> After bisection and the first bad commit is:
>> "
>> e5dd410acb34 ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data
>> "
> 
> It might be that your bisection results are accurate.
> 
> However, after looking at the stacktraces, I find it way more likely that
> bisection has landed on the wrong commit.
> 
> See this series that was just queued (for 6.13) a few days ago that solves a
> similar starvation:
> https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block
> 
> You could perhaps run with v6.14-rc4 (which should be able to trigger the bug)
> and then try v6.14-rc4 + that series applied, to see if you can still trigger
> the bug?

s/6.14/6.13 in this paragraph :)

-- 
Damien Le Moal
Western Digital Research
