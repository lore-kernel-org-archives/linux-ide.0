Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D21A4E9C
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310878; cv=none; b=GHaipzhQ/YDoI/X07cvbXr2lTp2s+DjjmoU8m31CqTIj2wuPFBDQbxOxaNZ+03lUju9nBqCugT3dmnUmv+u5cls1i4Z8chJ1EPUypn5dMpouuE/HXMTa/sx6dWL0TkpOF1D556xOrb0cP6katAPpcJDZkT00AyIZTn+F6dTa9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310878; c=relaxed/simple;
	bh=uuK9+g/evPJupcrQ3zQ8HPO8niMGkaAKjWysHcKmc2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STtw4mRi3ScxlI3NSi3uHhITir6Eo524UWi0GWncKYQS3Y+xkJa31capWZm0qaBjiYQfW+1ptvp8uQIK2sto37sKau+8PPW9aRdhqB8ZgpbxeKtg9/ChwEDwGF1EdXRX/SIAuMU0kftGEk0PfZvSrstTtMrAbWgkZR/x1sjCL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyorYM02; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyorYM02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBEFC4CEC2;
	Mon,  2 Sep 2024 21:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725310877;
	bh=uuK9+g/evPJupcrQ3zQ8HPO8niMGkaAKjWysHcKmc2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyorYM02fV/1XqSzt78gFT+xSZUZrw+R5nSwLlDzkdM+iF0XHfZVpylvRblKF/p9V
	 0nM7EHUbFuqPiGRl2LKbrX4o0EZXAwutD/Oy5RQPZYoV/8Zztf+GqhurwrYWorohlk
	 RQdOIot3yOm4O8L85vUK+Bh7FkDQce2GesLSOFnm5vcoqmBy3e8rgJ2wYGubmFMhGe
	 oaOtXb4q8LIFHwT94VSzmUhwsfMtkJE4NTX5l4sO4taa8Kn7QFZ144VQlJXkCJcx1o
	 jDf8231QzgLMC+AUDqv6WpK8uRknrv0EsLaSFQRqFLKxGze7PjgqbhcmipgwyBoz9Q
	 NDMpZwAGOeBFA==
Date: Mon, 2 Sep 2024 23:01:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v3 1/7] ata: libata: Cleanup libata-transport
Message-ID: <ZtYnmbq2crGr+kSk@x1-carbon.lan>
References: <20240902115400.166881-1-dlemoal@kernel.org>
 <20240902115400.166881-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902115400.166881-2-dlemoal@kernel.org>

On Mon, Sep 02, 2024 at 08:53:54PM +0900, Damien Le Moal wrote:
> Move the ATA link transport device related functions after the ATA
> transport device related functions to avoid the need for forward
> declaring ata_tdev_add() and ata_tdev_delete().
> 
> And while at it, do the following:
> 1) Change ata_is_ata_dev() and ata_is_link() to return a boolean
> 2) Fix a pointer declaration style in ata_is_ata_dev()
> 3) Improve the kdoc comments for ata_tdev_free(), ata_tdev_delete(),
>    ata_tdev_add(), ata_tlink_delete() and ata_tlink_add()
> 
> No functional changes are introduced by this cleanup.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
