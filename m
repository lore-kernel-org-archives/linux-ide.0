Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1231CAA85
	for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2025 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795154; cv=none; b=s6X51v1IKz5PwvkmW4CoLEm+zt9m84Cf4zVzNgKGdbChFaCFBFmsFUx68H3WgOLidNWHhl8bz51gp3MI0pLCqJS9kyDR9tGRdgj/TZzHndz65vu5EoEdJCL/BZnoWLuC1u8zG37Jgt4YhMb9G7epG4ZZpx9ggjnBPFS/+0FzBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795154; c=relaxed/simple;
	bh=TDREk00CdIvaIOit452rm1IumgGP3aNUUsWSp8axN84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRqt4EmTTERmMCn+SnV2o2L4qZlRpj/NEdRJiUwnj3sIA03Z7/I2YGjLC7K8j0XKTZpYeG/ig23MiSBPUUFTh4nl2du+9XEowxwKgzb1rEiispDB66k73iktPtcVWIUCv6uIDm9qE2BrX4eHHgdQiiPe+pCgTfM4O+6IHd06c9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDQA+Osu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDQA+Osu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2673FC4CEE2;
	Wed, 16 Apr 2025 09:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744795154;
	bh=TDREk00CdIvaIOit452rm1IumgGP3aNUUsWSp8axN84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDQA+OsuKPSTm5jNZMkR1jtHc0FHStwogDf8xYMhOrIaFlIH05lFf3UTKhUgoTjdf
	 SfXRDFQU6VFdBl2RE8iDisjDnSStZ/jbjJ71vEJH3F29pnaV2Ie8jC+7jCMkHpTTyY
	 mFD1EwAGOhM5zn8DZl9YtR0aqcEdekxjWdnYS6esjLo10/5k2es8vm3XhhJ+hx1E07
	 qtmAXE4iJL2q0YOJ3CmDNf/14KT3JO9r+cS8daJz/jRgufoJ22pn636V3zdleweFpo
	 S5XJSTy0SGDa11xzaPVLFJwk06y4uySnEMlbUBwlEz3JhAdwXvymjv8DiB/R7ohh+S
	 lgOyfyW5mbAGA==
Date: Wed, 16 Apr 2025 11:19:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 3/3] ata: libata-sata: Use BIT() macro
Message-ID: <Z_92DlLnyhCr5MvP@ryzen>
References: <20250415073013.414987-5-cassel@kernel.org>
 <20250415073013.414987-8-cassel@kernel.org>
 <ed8aca96-896a-48fa-9cf2-b0a50f3e4ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed8aca96-896a-48fa-9cf2-b0a50f3e4ef6@kernel.org>

On Wed, Apr 16, 2025 at 05:32:11PM +0900, Damien Le Moal wrote:
> On 4/15/25 4:30 PM, Niklas Cassel wrote:
> > The BIT() macro is commonly used in the kernel.
> > Make use of it when converting a tag, fetched from the Successful NCQ
> > Commands log or the NCQ Command Error log, to a bit field.
> > This makes the code easier to read.
> > 
> > Suggested-by: Igor Pylypiv <ipylypiv@google.com>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Patch 2 changed sense_valid from u64 to u32. So I think this patch must be
> squashed into patch 2 as otherwise, the first use of sense_valid doing:
> 
> 	if (!(sense_valid & (1ULL << tag))) {
> 
> looks very wrong to me. Even though in practice it is not going to be an issue.

Integer promotion will happen, so it is not a bug, and I change this in patch
3/3 anyway.

But sure, I can send a v3 where I change it to "1 << tag" in patch 2/3,
and then change it to use the BIT() macro in patch 3/3.


Kind regards,
Niklas
