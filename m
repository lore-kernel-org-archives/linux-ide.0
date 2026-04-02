Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2648318EDA;
	Thu,  2 Apr 2026 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115507; cv=none; b=o5flKc9654Xmt3iTONV/QLvsb1oIcRQ4m2VjTlQhzAj+64inMPfaeU1NFP2ALKdxwZxKg1BQLDv7uSM19DRpc0KCWY0ST9IultuN4BrAskiiObRBY/r15+u3d0dItnZJWAGTcMVLuBfslbSH5Jp4h3UxZqYzrtrXToWw+3nbllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115507; c=relaxed/simple;
	bh=mL7lx+hoLdoIv2XGM7SNQFXRZDju0/FBqL86HMqrsMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUvC5qcg2EA7JRiKkDhuTtputJYM0+7shpRA4oC02EBae9vcBcKrylez2Gp427bILBtDkiDeVd5WQIu2pWiUsVuK8+2Vkz37mcU1SBCtO7+fmZLd4PrpXwR5ovd7euNLpfVHfegWx5Oco5JRej0cvSGlUQ3C5mX3C2vJ8/5Zns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CndR2eK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CndR2eK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB71C19423;
	Thu,  2 Apr 2026 07:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775115507;
	bh=mL7lx+hoLdoIv2XGM7SNQFXRZDju0/FBqL86HMqrsMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CndR2eK/ZJPZXDxopsGVgOjnWZ7XDfukWY3SRtMn1Ys64wA4HIFqvXNHnGVlheLp5
	 +x5Q9RCrSW0Ur/REtEUIE6SOpORo40F55lOFY5NBKyXeWwimd//Wwtz46cLgKiHNLW
	 ZAlPiZKSJE/1vKnFYUL9dByK47JyXxCQRBCKfsvfP4Q1HCBX03fsaXah2AxXx2r7gg
	 siBoMdUAZlRF1I7QfSeKdL6vQwSE7/sAIB/RfLIBZbwivtvQ5c+Io303YjtENF10tZ
	 OCkXpcEkm9gE5YZvAvz10h5pTpTYhdyMH7A3nPaSva+kOvdBIr3bOomrth+nwoyejq
	 6zvObYHYXIeoQ==
Message-ID: <87f5a30f-0b81-4c88-bd33-c89970021ec5@kernel.org>
Date: Thu, 2 Apr 2026 16:38:20 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_arasan_cf: fix missing newline in dev_err
 messages
To: Owens James <hechushiguitu666@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260402021027.56-1-hechushiguitu666@gmail.com>
 <403a9722-02b8-463b-9980-e7de32e30008@kernel.org>
 <CAEZ4rQ8QMQ8q0ev2oSmVUoFw=02Sp5BEqTjzr_=Y+pv8Uk8osw@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAEZ4rQ8QMQ8q0ev2oSmVUoFw=02Sp5BEqTjzr_=Y+pv8Uk8osw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/04/02 16:11, Owens James wrote:
> Hi Damien,
> 
> Thank you for checking!
> The function arasan_cf_xfer() does exist in the mainline kernel at
> drivers/ata/pata_arasan_cf.c around line 380.

Nope...

378 static inline int wait4buf(struct arasan_cf_dev *acdev)
379 {
380         if (!wait_for_completion_timeout(&acdev->cf_completion, TIMEOUT)) {
381                 u32 rw = acdev->qc->tf.flags & ATA_TFLAG_WRITE;
382
383                 dev_err(acdev->host->dev, "%s TimeOut\n", rw ? "write" :
"read");
384                 return -ETIMEDOUT;
385         }
386
387         /* Check if PIO Error interrupt has occurred */
388         if (acdev->dma_status & ATA_DMA_ERR)
389                 return -EAGAIN;
390
391         return 0;
392 }

And "git grep arasan_cf_xfer" gives nothing.

So still not sure which kernel you are looking at.

> This patch is based on the latest upstream mainline branch.
> Please let me know if you need anything else.

Patches for libata should be based off libata/for-next or libata/for-7.1.


-- 
Damien Le Moal
Western Digital Research
