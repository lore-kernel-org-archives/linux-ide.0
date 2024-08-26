Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213BF153836
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683203; cv=none; b=hiz5C974NV55pTsKkFK4Hc6P9FcaXaqOlBUpEZl1+sD9d5Ji0ixen4qLk21kFI1UQS5VUK46148xz2+g+wcy9qzFd8X/cKvUmmJ38UrZQKDEdmblyizIEDKlmG1AyD5q8rISmtVjEVxeuZ4voCQnSkuqyt0V4AVdJ5sPD4oUGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683203; c=relaxed/simple;
	bh=HKi/CcmK/Gamji15Dhs4Ai7yCZ7QgNslm+qdCLv+CXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NemC/1iXq/8t0T9wwXePEZg54tM0fml8DhlsOp87r2j4WL855yx8T7TE9+4n3uNv2iFL3433i3y63wLdFvH4/2ZBLgTZEv3xCh/QXY2ub3gO9BGX6SqW9ETo/F6amuh4LjNwXXacqqyBISrrZ59S7Fc9Ag8gBUruOsxkEI2yBbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svt7l+LX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svt7l+LX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC6EC4FEEF;
	Mon, 26 Aug 2024 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683202;
	bh=HKi/CcmK/Gamji15Dhs4Ai7yCZ7QgNslm+qdCLv+CXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svt7l+LXQtJ61N5BYXp0VRWdjmRf+FjFE0ioUBWs8Y02rD3xZfixMor0yUGTuLqmL
	 7/6SBdWIiqDt46OLbAOVUpA7K4jyQoQu81Cx/lk5CMK6L88sDgfGWSgsLxdcQ8yOYd
	 t4c2S/2RlQaEjjWzhXYJn7uLHt6rv/iNtYJENt6YOKlho/XONy24M8/G0X7HbTtkz7
	 zIuCJdjze+vBUUEP3FTorrY9l+HycZbRzxHq8RqVhbyvvzMpdBQRsQduNo8DlJXpGa
	 boZPWh2wBUQ17kUt8GvLQn95hSf0iGW+Dj3WEvytXzOwckJaNRt62EZPK/g31NVy5O
	 L94aspAoeufCg==
Date: Mon, 26 Aug 2024 16:39:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 5/7] ata: libata: Rename
 ata_eh_read_sense_success_ncq_log()
Message-ID: <ZsyTvyLbjLrCz2No@ryzen.lan>
References: <20240826073106.56918-1-dlemoal@kernel.org>
 <20240826073106.56918-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826073106.56918-6-dlemoal@kernel.org>

On Mon, Aug 26, 2024 at 04:31:04PM +0900, Damien Le Moal wrote:
> The function ata_eh_read_sense_success_ncq_log() does more that just
> reading the sense data for successful NCQ commands log page as it also
> sets the sense data for all commands listed in the log page.
> 
> Rename this function to ata_eh_get_ncq_success_sense() to better
> describe what the function does. Furthermore, since this function is
> only called from ata_eh_get_success_sense() in libata-eh.c, there is no
> need to export it and its declaration can be moved to
> drivers/ata/libata.h.
> 
> To be consistent with this change, the function
> ata_eh_read_sense_success_non_ncq() is also renamed to
> ata_eh_get_non_ncq_success_sense().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
