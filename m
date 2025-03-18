Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103361917F1
	for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2025 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284875; cv=none; b=FqS1CwBDD5+aVBNlctxNAfXe2xPWrPUkxVI96XodRPATR2re7kjV70tLYPPEOGF3VOifVr06lRQX52wcTbVW0bk3/x16OrLxVexEWEbYPo04W8Jw20NRvMhIpiJ5EIMx3cI7T3SHy4Sxi6oWjVJkDyeKtUefSAu4dvlgk8xOleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284875; c=relaxed/simple;
	bh=BI0xue928PffjLPtGZL0KW+GDiGw6uJihNIadWkmv8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLruf1Ps1Fdu1zr2ZgYQwVb6syEC8rzUJ2rvs/5bkAKOUmqmsvD51Z59yVHZ+erTdoblyqQxjQFTl/+WaB4LVcC6joD+3Z6GQspwo6sFAwo5pbNlQeF/gsapLruaMH9OA79YMUbPPLGHg0xKUWbNLe1mKK8a3ypOzg8Ejynt8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9eViW4C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9eViW4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9A9C4CEE9;
	Tue, 18 Mar 2025 08:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742284874;
	bh=BI0xue928PffjLPtGZL0KW+GDiGw6uJihNIadWkmv8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9eViW4CjgxLOzeyX3X+7tASWexcIVra/96jyXSIb/OMcK3pkAdgvWLHY7kIafLIg
	 Xb8Z6X8/Yo+AjjKYRwq+I9r1luzL5NmNhCFauWDrHU7/vRw40J3MRyXVrrN/uX0NaE
	 l9D7/BGlYkqSUCcEoMIkyDR80fiS9HfEpVfmSxe0PcmHCyIFQQEONzVGMtRpv31f9P
	 i/6LyBGEP9rqqg60YHGNfvx9RYzPe8kN1m4QDzbYIVwE/OEyVQPVfOaJMVWaXHipTb
	 DzlnNNg+zebkWWz2NyCgndwjWk7/ff5SG/8513zQ2CRujLMRIVq48OnL+6CT5T5C3/
	 /hQvhWv5i5HaA==
Date: Tue, 18 Mar 2025 09:01:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Tomas Henzl <thenzl@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH V3] ata: ahci: simplify init function
Message-ID: <Z9koRvxBwzwfjQ81@ryzen>
References: <20250114182956.40923-1-thenzl@redhat.com>
 <0e2a0f69-7b98-4b48-8a68-6a554cbbec09@kernel.org>
 <be4fb93d-ab73-47d1-bbd9-1ac098b23ca3@redhat.com>
 <abef767e-9479-4109-8057-d549ac999107@redhat.com>
 <Z9gxiFiKsfXXyOkp@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9gxiFiKsfXXyOkp@ryzen>

Hello Tomas,

On Mon, Mar 17, 2025 at 02:28:25PM +0000, Niklas Cassel wrote:
> On Mon, Mar 17, 2025 at 03:00:46PM +0100, Tomas Henzl wrote:
> > Hi Damien,
> > 
> > the V3  patch applies to the for-6.15 branch with just an offset.
> > Can you take it as it is or do you want me to resend?
> > 
> > Regards,
> > Tomas
> 
> Please rebase and send a v4 with an improved commit log.
> 
> -Remove the double newlines.
> 
> -Use paragraphs (with an empty line between paragraphs).
>  (There can be multiple sentences in one paragraph.)
> 
> -Improve the motivation. I.e. "removing a few lines" doesn't make sense,
>  you are actually adding lines:
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
>  You are however moving all the IRQ vector allocations into a single
>  place/function, instead of having the allocations spread out over
>  two separate call sites, so your refactoring does make sense, since
>  it improves code readability.

If you want this patch to be queued up for 6.15, please send a new version
this week, because after this week, it will instead be queued up for 6.16.


Kind regards,
Niklas
