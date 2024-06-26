Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5610F4;
	Wed, 26 Jun 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383540; cv=none; b=UcspFLDVErXLHOoKXARrsWWmKpolNBxULvmr3tQC3poyTQDw3qUVrhL3isy90XEn0IQ6bDu33gfixQab4rSZuZ5j6gA9AlGsOdhTByhcSHZVY7K36Rzs7lTrrEsRlX2V1/8c9IJcbcov0nuauCWldG1o1YhpfeMNfg8sOfQcoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383540; c=relaxed/simple;
	bh=u2zXzDLfzmnAjqoK6BrWNwex1pGzeIhKDQnN5jti7Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxspeUN9drunOZaZ7+Y/u6OfWMKG+G0HzkoKui8H7xiSddvE6NgjTBXEVy9tfuNSIxKUQvCbnXsv6KCrLXzwg4pJ+6om4i7/PzKi7L4CUzRvc4RgrxCSXQ5DFBYh7q4nbHzyAwAALuvPbnyZGhMz4+S0BH9RNKaQ1I+HvWjRFII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB+wKga8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB+wKga8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D75C2BD10;
	Wed, 26 Jun 2024 06:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719383540;
	bh=u2zXzDLfzmnAjqoK6BrWNwex1pGzeIhKDQnN5jti7Nc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WB+wKga8tc4VXCjuNPunqy0rQ3mOaK2RzGaDjAcDccccWjqEeCERyIbZWaSfJfPuH
	 Ph6bVmvEkJkPDuMmps11omhUXwV5QYn+yR2jg++I9AjtAidRLuNllQj1jOoo+PNDqf
	 C16zABeLyB4SSdcv5tL7ndTNUNriXZJSTSpuqxOjZc62P86T6rd3MrK2e+vQz0RyyI
	 2sj3cU5S4TOLqQhMlkoL7T3TB3hJCuLCKNDnMbXeGQszY1i4u6UJCUG11JmSHy2Akw
	 2yzxutF2M4986AbGSZl3rDAxh4wV6Dgskj3xagHAHbkGd9F60Lu5MHaum3zRHqAUk/
	 UCkmJ9NGv/7Qw==
Message-ID: <96a20c5d-726f-4cfa-aaf7-5e5349511db3@kernel.org>
Date: Wed, 26 Jun 2024 15:32:18 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] ata: libata-scsi: Do not pass ATA device id to
 ata_to_sense_error()
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-5-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240624221211.2593736-5-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 07:12, Igor Pylypiv wrote:
> ATA device id is not used in ata_to_sense_error().
> 
> Fixes: ff8072d589dc ("ata: libata: remove references to non-existing error_handler()")

Not needed. This is only cleaning up the function interface and not fixing any
bug. So please remove this tag.

> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

With that done:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

