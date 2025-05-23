Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912272B9B7
	for <linux-ide@vger.kernel.org>; Fri, 23 May 2025 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985481; cv=none; b=mFMCfwasfKCMAe6FWevIRV69YhRiQJTCpV+aDSRLzFuxDZsT9+UYxZuYbuYlQy6SWBs0ZRFTq9GF+DU32f2rcnFAxd6WzVS6bFZwyCXhjPFYmzhgBR/zySIfI9h1PC29ivhzoZJiGQiTmp9yZ3TYHJDFqUmHa92U9IwxltBwQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985481; c=relaxed/simple;
	bh=4RVDd49BrvibjJUJQHSaM502HyDsbai8tMcVGg+3Lwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbviTzFAdIhNkGxSdZ7lEKLx41XwLxWxG5sLv9QuZXgdcUUPV0COylk88sDIrGkeNIklHpYy4ZilNjKhb4t9uVfG51otbsJz4AVC9QL8Q8+vPY3I41kC4tNTwJbfyas19/IQOLsopfUjWAIK6jekBHPNuTAct7wnrLWYfvHPSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p611bHQi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p611bHQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234CAC4CEE9;
	Fri, 23 May 2025 07:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747985481;
	bh=4RVDd49BrvibjJUJQHSaM502HyDsbai8tMcVGg+3Lwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p611bHQiWBdYssUWjuiH+AjQMscY8VwmCSm1ZLCBnonMMGakF05g2Rm6W2hRdEgud
	 rmRKF4AbjP2orbgUeDVN0+fqdY0DXilwzcPW0+W9+R+g5zJnEAr7ep0LrJMvhb5ooL
	 p+QKMNlmVWjkOK7WUhVQAVHdghMpkacWI1Ft8kAT6ORB/iKyuCqWEAZh687wJ65e4r
	 IjGbh95U7qeRva2pQ+kuc9Mm6aAG5GHHRxZ3jaMvJIwsToQfKbkGJLgraT3p2U0jnT
	 e+3tAI+VLCgTnsjk3HrFDvEh5zqTBsD9RMWxblE6Ycy3zGfovO7bN80YoSA/zWgRFO
	 M9KVdwenuDFFg==
Date: Fri, 23 May 2025 09:31:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ioannis Barkas <jnyb.de@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v2] ata: pata_via: Force PIO for ATAPI devices on
 VT6415/VT6330
Message-ID: <aDAkRUp6FWQkBaZF@ryzen>
References: <CADUzMVYk1VOB9u2n4Bxd=ZBeDspkorP94HqA9H1zb6QSDxmFbg@mail.gmail.com>
 <aC7UwqgemO28FGOs@ryzen>
 <CADUzMVY2_DHqko-863=2f8sU1EtQJXgFeN-_BccnajsYWTpuQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUzMVY2_DHqko-863=2f8sU1EtQJXgFeN-_BccnajsYWTpuQA@mail.gmail.com>

+linux-ide mailing list

Hello Ioannis,

On Thu, May 22, 2025 at 11:45:02PM +0300, Ioannis Barkas wrote:
> Hello all,
> 
> Unmodified kernel 6.1 was used without any patch applied and got no
> crash or hang while checking the ODD. Can test with the patches at the
> weekend.

I'm still a bit confused.

So kernel 6.1 works fine, but 6.15-rc7 does not?

If you haven't tested 6.15-rc7, please do.

If it still doesn't work there, please test 6.15-rc7 + the patches sent out
by Tasos recently:
https://lore.kernel.org/linux-ide/20250519085508.1398701-1-tasos@tasossah.com/
https://lore.kernel.org/linux-ide/20250519085945.1399466-1-tasos@tasossah.com/


Kind regards,
Niklas
