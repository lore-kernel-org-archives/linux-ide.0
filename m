Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41023B8D54
	for <linux-ide@vger.kernel.org>; Mon,  8 Dec 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765152334; cv=none; b=JTGMcC+zLHkrbDAzjdTpGAnVuIbAa07bbT4ZbMlC8fgP0xJ97lcM0bAxs/D0NdCIByRcidaNVTGQ47FHyP5vHGZtoTBx5yPtzhJx8YiEUWK+YRavt/KS7iCZrFFu3jRuyEMT+0CU/jM9NqY2JQglfATP1gbnooqSNwrGbDcTI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765152334; c=relaxed/simple;
	bh=yVxOKaP6lsYxWw46LnZgZxiXp5ozEbHFboMyVXn2Dv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibWglnwZXclund3L7KO9G5KyE5YI1+OiXcMjVnGW7vq00v4CbyzYlnkKPaWrzWiHsEWKJR31UmbtBOSDRSPOcBCXK/R9/CIpfKX80BzHfwZCc2jyAfWI/10pYR5T53hNvNZRgAZvAyxAmAlphJbfxr7qg8FgzEwjp3e/7TuhH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMBLm+zT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMBLm+zT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04715C4CEFB;
	Mon,  8 Dec 2025 00:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765152333;
	bh=yVxOKaP6lsYxWw46LnZgZxiXp5ozEbHFboMyVXn2Dv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IMBLm+zTkTXvvmQlXUOOdf3HhIWtzkxdGzk+vgcvQ3Z+oQuPsJLQ/NGJzTGSgrKt3
	 Fxcx24z7+IEx03TNUFehSIcHHyu4cKCiGODOPCGbBMrxFrTrmYw/I1n9YKmf79vfOp
	 UHLDmgIQv9bgQ3gjLkFoJtKaeE9TuYtOasWjWGFpVtHWX8Sp+B8Gl5rNCjt/O4uXTh
	 dvcAtjFOwltSFw9Vz4UhS0wiyFkc35vhSMbGiXP5soJdhksVejb2x3xKes8dnzc1Tg
	 071QrJYoshMswgrOzC17Q6jHCjRqWJXCtxdZbKoavTLv62UcPZLc2SvipkidWEA0dx
	 /JDM2vmCwkDoQ==
Message-ID: <493d44e9-6efa-4930-9712-cc9d82371408@kernel.org>
Date: Mon, 8 Dec 2025 09:01:11 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: Remove superfluous local_irq_save()
To: Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20251204131804.946417-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251204131804.946417-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/25 10:18 PM, Niklas Cassel wrote:
> Commit 28a3fc2295a7 ("libata: implement ZBC IN translation") added
> ata_scsi_report_zones_complete(). Since the beginning, this function
> has disabled IRQs on the local CPU using local_irq_save().
> 
> qc->complete_fn is always called with ap->lock held, and the ap->lock
> is always taking using spin_lock_irq*().
> 
> Thus, this local_irq_save() is superfluous and can be removed.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

I staged this in for-6.20, which I will rebase once rc1 is out.


-- 
Damien Le Moal
Western Digital Research
