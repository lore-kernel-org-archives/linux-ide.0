Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1FA4C97
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347332; cv=none; b=RSzFItTttk/LRSine3KdWdXhqaVWUS86aqkO8HIThJb1PpYUSocW+H1eE4URev7U4gRW/jGUabfkgc3GB33kloSd+5iSZgMufP3w+jvKLiX1sDeY1no33YPKQl+KFv3gHH3cMo0XHoC+IZhChkODwGsNCW8hwx6vVI54MYW50eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347332; c=relaxed/simple;
	bh=PSqbS63Q4mlu+RHB4bc+jQhbrxDWrkZBuQw6DseEAxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot0z2npk5k8clAsZAnQDx6mN28FfLmAhO6TNrEEDJww2NB4xxRDks6DiR2sJVkTaHVtSl65vY4VbWvPA1KZMg2faLlP+gdnVm/BSL1rg+wC84PlNjXMyLOzAZ9Xdx1XMrkoXdv0oxYe/90jiv45EBv7gdHlQnQv6J6SpibAok/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT3pd2zs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT3pd2zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C30C116B1;
	Fri,  2 Jan 2026 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767347332;
	bh=PSqbS63Q4mlu+RHB4bc+jQhbrxDWrkZBuQw6DseEAxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aT3pd2zsghKKotEQQdLCMngrw8VIRUqKAJRj/5/K+brnc+G9hy9TKIVKYnUPb217k
	 TQ8jgWjVYAz73hR7yfFOi8aYGbxxH1cDpeqNklkf3hsNtCMLGZ+9NHqAnKjFrwiGfX
	 UHwvFHSeXvsuBYSh4LfjYdr0IgCjPuzgblFTDWw0yTFuQZgMjHC/u+r23u0asU4Enk
	 5vJXxrk+SZoR02pm8vhTIdT4n518IFUB0msGIJx+mFWfsKDn/pbdiXqiEBgp/OW2+X
	 xwaOks7P5TjKvpvNN0EENGKYI2gINJ7Kohg3M2qNrqLS4dgX+pt+HvTPjHtDmW7smx
	 AG9iBtFS3NfxQ==
Date: Fri, 2 Jan 2026 10:48:48 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 2/2] ata: libata-scsi: avoid Non-NCQ command starvation
Message-ID: <aVeUgIk9pJzUDu5A@ryzen>
References: <20260102013533.1131768-1-dlemoal@kernel.org>
 <20260102013533.1131768-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102013533.1131768-3-dlemoal@kernel.org>

On Fri, Jan 02, 2026 at 10:35:33AM +0900, Damien Le Moal wrote:
> @@ -1776,9 +1864,20 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	if (xlat_func(qc))
>  		goto done;
>  
> +	/*
> +	 * Check if the qc must be deferred. If yes, do not report the deferral
> +	 * for the qc that we retained for processing using the port deferred
> +	 * qc work by returning 0 without issuing the qc. This signals to the
> +	 * SCSI layer that we * accepted the command and do not need a requeue

s/we */we/ ?

