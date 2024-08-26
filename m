Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6180027
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724714830; cv=none; b=qtKLKEpB9JaAEnSriDG5uUevJXPavJuiKzD/DETIGSoxUZwRN0v2MjA2uWnXzg/VY1xPNmftpudBb+Z+1AQimjivGuV9APRSsHgCImf2gwxIUNqBOMB9f627sBy3JUJxkK+OufWy/SCIqkfj0nHqdlLhY9PP8UCI53+yDekV280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724714830; c=relaxed/simple;
	bh=YefWLqiKAATFoEGjFcBq9d+GAJOF3ui2f6kVN2t8ZNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSG0wG8RQTMaavRsPaWYEyfFQZK0PHLUDFNQCKpqS0BHO9Nt2ji9GEVcVbmlzGh79tdNf0l8ywr/al7oQh4wRrnIGAF90lYEx0bbOg+WkDvmE802FbVgC/dqqxf8msmQxtKP4dlL6s+TtWW0blSj0Pe9UpxnCGJeRKnm56wn/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEO5H8Ru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEO5H8Ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD7DC8B7AF;
	Mon, 26 Aug 2024 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724714830;
	bh=YefWLqiKAATFoEGjFcBq9d+GAJOF3ui2f6kVN2t8ZNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vEO5H8Ruj7CGoBfRvbXBQVe9lG4i7UuEhJCovLiOyfavRVXN7rMAbzvxtnl9BJNe0
	 le9YqD+NOxF14N3Ndng6FkMzXJGIPcQDkx2oIIxTQ5YxSbn+dx9txVkdLkss7EntsM
	 POJrg73hQFibcgD/TyyoQAT5AXMdEBpaEqMgTHBKSW3XqxRGWq9RinBxVAHLB2ZuBm
	 cgp5qfb2AR/Cucf1LTvW8ZWnxHruJjyX7ckHKne7o3YqiT3pLBz7brxzLn2yz8PlcL
	 XqUw49bJgKIFt4H0UQomVSHf4Fmzq0mMos34H/hSpjSkBdx0h568qJZSxOlUn+K/LS
	 QQCdq0yfgbrUQ==
Message-ID: <bd3b12fd-a6f6-4ad9-86b1-7e770237b56e@kernel.org>
Date: Tue, 27 Aug 2024 08:27:08 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next,v2] ata: libata: Remove obsoleted function
 declarations
To: Gaosheng Cui <cuigaosheng1@huawei.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org
References: <20240826063242.4132493-1-cuigaosheng1@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240826063242.4132493-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/24 15:32, Gaosheng Cui wrote:
> The function ata_schedule_scsi_eh() was removed with
> commit f8bbfc247efb("[PATCH] SCSI: make scsi_implement_eh() generic
> API for SCSI transports").
> 
> And the function ata_sff_irq_clear() was removed with
> commit 37f65b8bc262("libata-sff: ata_sff_irq_clear() is BMDMA specific").
> 
> Remove the now useless declarations of these functions in
> drivers/ata/libata.h and include/linux/libata.h.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Applied to for-6.12 with some tweaks to the commit title and message. Thanks !

-- 
Damien Le Moal
Western Digital Research

