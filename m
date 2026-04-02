Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3223156F45;
	Thu,  2 Apr 2026 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118481; cv=none; b=q0MnOukWMwNBMLkaaWJW46LXulfRUWEjpnBEnilSgawrcZu2gKETjUPOukidqyd+ulRE+mBQZ/Hn/VczluBGogZ9QeEmDHLwCuYONuklYNrnIFZdLPa1LYvSbNo7YUoplt2vb7xbbZxL4gev1JK/vtZJrvKYs7q0GtLIsKHRjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118481; c=relaxed/simple;
	bh=G8SiDjGqC1Rg8EZnFk69JOSwtRzvSWgjuNNkZjvYGHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbczeQV2Oaqiz9U22vLgCGKGrwv1e4SP8dZH1OvApYH6wEbDMIcLkBbmqfZDihlKaDIC49txJikStKlGHRoIhMYIr5LiEZT4oewnl0Cwg3jCmzV/O2n8IkOawgpH0WN5NvASoUNZR5I9PDuD26zoBigBNf4T7EkHDEF3sRbGh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHcL6rtE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHcL6rtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDECC116C6;
	Thu,  2 Apr 2026 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775118481;
	bh=G8SiDjGqC1Rg8EZnFk69JOSwtRzvSWgjuNNkZjvYGHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AHcL6rtEvgdWEcZxsGumjDKKS1ZGFXwhea0Tz4NLdQdTJlt/nrwpNIn7JC9IEpjtL
	 gZQN6T7U0r3c7phc5r+lrmdZblKh7RVeiWUjxZNZEPpC8K9NOsgGcfz8lMt7YGXVn4
	 68x0CVNNoiWtmdRZUGoHNgRVQNFNrVJElUuoiNrmC6QyUz+eLZYMVeXWMPLIN/tPV2
	 VGcxBNynWYdJ5P2ISH2CG1bIdeQNeLtrtt0Pb/x4XZ/vgSc8QHQe/P83xmGmJa9Ejg
	 fi4WPf3zSac4ZHz/8dsaJ0+aU+zJFmJNRNqPU5LRtDkAHRWv5Kzu+MYYAmFSQqTjMj
	 VX+IG7m8nnEJA==
Date: Thu, 2 Apr 2026 10:27:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Haoyu Lu <hechushiguitu666@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_arasan_cf: fix missing newline in dev_err
 messages
Message-ID: <ac4ojZl_qe3NXwwi@ryzen>
References: <20260402021027.56-1-hechushiguitu666@gmail.com>
 <403a9722-02b8-463b-9980-e7de32e30008@kernel.org>
 <CAEZ4rQ8QMQ8q0ev2oSmVUoFw=02Sp5BEqTjzr_=Y+pv8Uk8osw@mail.gmail.com>
 <87f5a30f-0b81-4c88-bd33-c89970021ec5@kernel.org>
 <CAEZ4rQ_c9m=3Ksp15706xq7TtH-9SxF8vaNNZoNj_dBgP7EuNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEZ4rQ_c9m=3Ksp15706xq7TtH-9SxF8vaNNZoNj_dBgP7EuNw@mail.gmail.com>

Hello Haoyu,

On Thu, Apr 02, 2026 at 03:48:42PM +0800, Haoyu Lu wrote:
> Hi Damien,
> 
> Sorry for the mistake!
> I didn't realize libata patches need to be based on libata/for-next,
> not mainline.

This patch was not based on either libata/for-next or Linus's tree.


> I see the driver has been refactored and the newlines are already fixed.
> I'll drop this patch and follow the correct branch for future changes.
> Thanks for the clarification!

There has not been any newlines added upstream, your fix is still valid.

However, the function has not been refactored, you must have based your
patch on some downstream kernel.

While the patch does apply, and I could theoretically apply it, please:

-Send a V2 based on libata/for-next or Linus's tree
-Pick up the tag from Viresh
-Change the subject from
 ata: pata_arasan_cf: fix missing newline in dev_err messages
 to
 ata: pata_arasan_cf: fix missing newline in dev_err() messages


If only to give you experience working with upstream kernels.


Kind regards,
Niklas
