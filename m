Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87F372EC1;
	Thu,  2 Apr 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121018; cv=none; b=Wc+uI8YwAillbXdY87FaeOz0u3QAmaVjwg12753TuJMJfs0EFdHYuAQzqjmZaunwkhfLwCW7tB6F/tOiLSwzQvcrI6hEGddvBBiFhTvdq+zHRwSh8Dxww9/HygY7/CA8TMiPYT4mJnwZ8sMAHtXBO9IxHqNU4jHnFCi5uDVW4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121018; c=relaxed/simple;
	bh=wmT0ZmijEFvrl1388WrgDWnnnKdQw5vMqgqyTMmqPg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u086da9y7/Bb34krXhKWfGsaJXWJ9IPO0E74Gi/9eu+27vapqdbyv+H6boC+3Xdsojo8XiyVaFbGXTDv4mtuCOCQDtwZpkOGxwo0/r6Hh44uH7t79NNM6g8nlh5Fm49zdGoAM6qZ1SfZafdhV+dmFl65JV/D75SmgegRv3y4nuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiI05YUE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiI05YUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD190C2BC9E;
	Thu,  2 Apr 2026 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775121018;
	bh=wmT0ZmijEFvrl1388WrgDWnnnKdQw5vMqgqyTMmqPg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiI05YUEYMiqLme4/VWc8wWjvhQe4LxID7ZpE01jBh4770eENx2czEFBEkTpPDooz
	 FQb+f0Ldco6EJ8eoKaTvDQU1luqAZXCCemVDs9mTN/OIZ9jB4MCOt8/Aw1nGcc70KM
	 IQxcAfv+nVZ9AOm8OSCgvjJPWWbMH9AoFFqT9LAiFFD38NqcWLqlGcfFf1UWhbcQfR
	 ZVZ20AbU5i8QLQ9LFfvuYkF94X3SZcg5kYbi09bWtvQgh8m+2W63NY97dsGhmlMqO/
	 iizzkM34AZDfarFv06RFETPP5VVPpkmFNYpfGrjlop5jSqT6RqNfztN4P1WzCYCPaL
	 Bjc8iSKcCOCOg==
Date: Thu, 2 Apr 2026 11:10:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Haoyu Lu <hechushiguitu666@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: pata_arasan_cf: fix missing newline in dev_err()
 messages
Message-ID: <ac4ydu1CKrPb0f0g@ryzen>
References: <20260402090612.2236-1-hechushiguitu666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402090612.2236-1-hechushiguitu666@gmail.com>

Hello Haoyu,


This patch is still appears to be based on a downstream kernel.
(Which downstream kernel are you using btw?)

Please use a mainline kernel:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
or
git clone git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git


Also, Viresh provided an Acked-by, not a Reviewed-by:
https://lore.kernel.org/linux-ide/ac4ojZl_qe3NXwwi@ryzen/T/#mb2b5ed70f1b4256fe3c675b539c1791249e08d22


Kind regards,
Niklas
