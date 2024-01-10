Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659D15C0
	for <linux-ide@vger.kernel.org>; Wed, 10 Jan 2024 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds5MACKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37627C433C7;
	Wed, 10 Jan 2024 02:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704853152;
	bh=h1H/p1dVlZdOnD/te/UBB2zcyMPIGeD3lOqf/fEAJuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ds5MACKzQ7QyIZf2p/u4YW4bqMr+4FV17araLr3v0BBp57jO+xE3B5QWWj0KaUgFB
	 y7bFSrJVWENZopFLk/A2OcJ1YjvkoaW+1XL7JWqEvN/QqOpNkujiMbnL+p1mQPVp19
	 5fd18UxDBnmS86vvXbHVFLvvDwOgCzyRRze3GZV9EuSb4wuT7a4qOMDqv3HNcgm4el
	 +Iqvrc1gDsW6iSvO317QZLGXuVW2waEC7So8vUiGBGSGNURUYJ2bAWZavE0yTwR/wx
	 way9f5qhqi9J1EiWIpEHunXPOcql2T7egD/ovqW+9GcKZzbZcuCJ0UfDdsgCRLAA2e
	 8hQu7tCdpGp9Q==
Message-ID: <b76a1b51-7dc4-4055-b7ac-a8265a3957bc@kernel.org>
Date: Wed, 10 Jan 2024 11:19:12 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] libata: don't start PuiS disks on resume
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-4-phill@thesusis.net>
 <e6f6aebf-0566-4113-8304-bccd88926f20@kernel.org>
 <871qasuepz.fsf@vps.thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <871qasuepz.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/24 22:39, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> Please use full 72-char lines for commit messages. The commit message also does
>> not clearly describe what the patch does (completely silent on forcing the drive
>> to sleep).
> 
> It currently doesn't put it to sleep.
> 
>>> +#if 0
>>> +		ata_tf_init(dev, &tf);
>>> +		tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
>>> +		tf.protocol = ATA_PROT_NODATA;
>>> +		tf.command = ATA_CMD_SLEEP;
>>> +		err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
>>> +		ata_dev_info(dev, "PuiS detected, putting drive to sleep");
>>
>> I already commented that this is not following the ACS specifications and thus
>> should not be done. So again, nack.
> 
> It is #if 0'd out.  I also addressed this in the cover letter.  Sure,
> this shouldn't be done by default, but I don't see a problem with
> leaving it as an option that can be activated by those whose drives
> don't have a problem with this.

We never add dead code. And code under a "#if 0" is by design dead...
So please do not do that.

-- 
Damien Le Moal
Western Digital Research

