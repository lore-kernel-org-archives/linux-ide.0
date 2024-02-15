Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFF13B28F
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2024 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036539; cv=none; b=OQwlRu8/fYFVN+Rz/AIo4Jnr5TR9dcxVuq4gnnJ+HQ6//O7cYOssxt+QdpDLHFjMQi6eYgCHH8g+ZycjK5J/LOhBodV9MYIk7HVDTS+t/xFyzHilpMBjTM9VL++TUXmsIDkjabxnswYFY44+tjTsn1ydi/gKRmBbzaSUI5ZC59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036539; c=relaxed/simple;
	bh=PihKIKOHm3H1RZsPzgGfh2+eB3Z+52304r94/KdXlBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFOFyx3kRf3RAqY9it/I+fsGZKBlui13dTtO+xUGoPowcrszLSB6PIHWkTwi5HN5cKFKEEtVzItAXon7dTEH+vmM+oUjimHJT/3R0GJsvGfjmZ5MCTsd4LbREjd4q7KEqxrmZqo04T7IjpWH7M6JfVvBtlNY4JR+Hv4qyhopzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxUHFg8b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxUHFg8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741FBC433F1;
	Thu, 15 Feb 2024 22:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036539;
	bh=PihKIKOHm3H1RZsPzgGfh2+eB3Z+52304r94/KdXlBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mxUHFg8bE/aMO0xWBNo4+PGQAD0zS+FvWQpTiMb3XWDzF+s1WYI/+bgxfdrzNOtaC
	 cIZawuxAJfljwSVN1vbS3xy25XgcKIUGi+tCdYV0R/QQFDQWHvx+x9u+fNBBX+yrJl
	 ilWYtHD9kyM8Mt5risZSUanm4PjojD0LxJkMc5yyYd9P8fklt8UH1/WGR44C2qxRlV
	 WjaJB8+nMZY4pgzYKlkcVe5UjiqqAimumUvEn5co6wp/1oXCqLYffaD0KJGjpxjv4G
	 aSe9yt/Q9jEQfnAu0BSQC/Wq8aEQVx3X8kYzPLzMT8fEWFtdkKJ9Dt1vsGXEdQ5dYs
	 WGy8A/SEOWPHw==
Message-ID: <c11dc521-ecc6-4dd3-a799-e577f4b3e16c@kernel.org>
Date: Fri, 16 Feb 2024 07:35:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ahci: drop unused board_ahci_noncq
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
References: <20240214130015.952685-1-cassel@kernel.org>
 <20240214130015.952685-4-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240214130015.952685-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/24 22:00, Niklas Cassel wrote:
> Since commit 66a7cbc303f4 ("ahci: disable MSI instead of NCQ on Samsung
> pci-e SSDs on macbooks") there is not a single entry in ahci_pci_tbl
> which uses board_ahci_noncq.
> 
> Since this is dead code, let's remove it.
> We cannot remove AHCI_HFLAG_NO_NCQ, as this flag is still used by other
> boards.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

