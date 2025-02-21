Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302751BEF8A
	for <linux-ide@vger.kernel.org>; Fri, 21 Feb 2025 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103041; cv=none; b=T1iOQOHKJd8k676qwT8BwcwCGZXDfMsl4E9HB3VhhYbrCuor949Zu1J6FJNaHHKZOSKjGeNpaWTX3EtCxP6uErR6Nrx6U1CJDn04cJQEuNI6qSVNN07FDXq2BovLtMJ8gf8q2OJIaTSRRexp8PZrdrFmhx0FKqKweCkf/ICHYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103041; c=relaxed/simple;
	bh=FSCqF5fddUJ/CY4Fmlso4HgVPzCQfjGTqtXy95zK0d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJN6Y6Wern+bme7CdII08UGJakqOeOSR/ZRNrCRAQKglBQ4Cs7kipdxzTcP3NA9PtWKxXr+H83YLlgwR28I0Nb/iH/Gw+avOJDhnhwWcF+7YnXPP4+QLG4E7Tp8OjdiHesgiRpulElbrUaJXv4rO1mzYW82w+GjIC22gAwdfU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L30lkKOh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L30lkKOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5106C4CED1;
	Fri, 21 Feb 2025 01:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740103040;
	bh=FSCqF5fddUJ/CY4Fmlso4HgVPzCQfjGTqtXy95zK0d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L30lkKOh+5Q9nspdHZxFpxp9lSjfeO8ZYyU9kh5SjU0CtkY2oADDgCFMoWIWZEcs5
	 CrMXSMdURseORLzTbHaJV4DJmSZWNdJfYDMyOQ2urOP4fOImR0npCTud7caxlyT2uE
	 SYgiy4VG1qX7cfenofNt2UzSTDDfzfblJhi86PfVDLmqy0GPcoL+KnB7NjD3Gh3oce
	 BgGr5bfnPS0uiwyAVNzhxb0r2t1h/OnavJnmxdPVLwNaLNnSj3QN9M//C6dUquWVv7
	 ncC7iGOh+x1p03f72GvPcbpDztTrKZeEey4OPE3HxYhPwqDUjStWmhRThYiqvo6ES5
	 X06ovcVzc2Z5A==
Date: Fri, 21 Feb 2025 02:57:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Philip Pemberton <lists@philpem.me.uk>
Cc: linux-ide@vger.kernel.org
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear
 UNIT ATTENTION"
Message-ID: <Z7fdfX6GD6D98UPp@ryzen>
References: <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
 <Z3-_dt0m_2UrtKon@ryzen>
 <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
 <Z4pdD1Z2mJnF7N3O@ryzen>
 <2bb1510c-c42f-468b-a8cb-70603bee846b@philpem.me.uk>
 <Z5NlVjIMp6Wo8dQd@ryzen>
 <9253b1b9-0f92-45ab-8b8a-44064ffa9cd9@philpem.me.uk>
 <Z7X9aPpgBjNln9CJ@ryzen>
 <Z7YAnqGsrWSzBirf@ryzen>
 <27dbfb0f-2dfb-4f4a-bc5c-bb53a9f1eef5@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27dbfb0f-2dfb-4f4a-bc5c-bb53a9f1eef5@philpem.me.uk>

Hello Philip,

On Wed, Feb 19, 2025 at 08:04:50PM +0000, Philip Pemberton wrote:
> 
> I've been able to get a good read of a disk with ddrescue:
> 
> GNU ddrescue 1.27
> Press Ctrl-C to interrupt
>      ipos:  100597 kB, non-trimmed:        0 B,  current rate:    720 kB/s
>      opos:  100597 kB, non-scraped:        0 B,  average rate:   1070 kB/s
> non-tried:        0 B,  bad-sector:        0 B,    error rate:       0 B/s
>   rescued:  100663 kB,   bad areas:        0,        run time:      1m 33s
> pct rescued:  100.00%, read errors:        0,  remaining time:         n/a
>                               time since last successful read:         n/a
> Copying non-tried blocks... Pass 1 (forwards)
> Finished
> 
> I'm pretty chuffed with the data rate, 1MB/sec is far more than the
> externals manage.
> 
> I guess the question now is, how to fix this properly?

Please try this patch:
https://lore.kernel.org/linux-ide/20250221015422.20687-2-cassel@kernel.org/T/#u

and see if it fixes your problem.

Please also make sure to check that you can still write and read back what
you wrote to the device (with the read data matching the written data).


Kind regards,
Niklas
