Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7F17C;
	Fri, 21 Jun 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718928337; cv=none; b=aa7RNG15NFqYvtDxyVAQWUXz/66YaCL0c/BeT3g05Wq2g6j55+TV+uaLkmzr7TwDYSPaQuYvtyMC9n1sNBZ9vAbRvBSSitt27eltbw7vpHnBy4VOs5bJI9A7cmOTMdGlE+Ou9sCWx6SFTU0ZfhHAvrBdb7UIz3SKvKWyG0+0ihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718928337; c=relaxed/simple;
	bh=fJPlLHdMqCmgtQq/twO+a2QC2xncnSMWw9IGmj20ENw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjPwN27m28rIa2PfLxuw+Pyh9OZTzlnDFUPwRymmcjLTGCBOTBDl2fvGHl5zKEb5uyvLf+KDo/RUhOwNL5eX+xyCA+ht2LOjYkUx8tKlvUtTu7Zhyb9O9mb8eOET8E9WYdNYNHnVeOWl37F8nPGxa9WKQ4siZqS1bZMNNM96Jyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8C2s4Bb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8C2s4Bb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B27C2BD10;
	Fri, 21 Jun 2024 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718928336;
	bh=fJPlLHdMqCmgtQq/twO+a2QC2xncnSMWw9IGmj20ENw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o8C2s4BbJyisd0IM/JcnEhu3RJKkogMRaeHD5G2yUWSOM4S0MB18zltnpnJmbIrsW
	 DuPxJ+Zuy1FLOyTixepK+xYMLFrw3dOZipT2DnEhfSxtrIq4aHEuCkf7NRE3pnMSK4
	 4Z5m7n4MOujfDptBewZogGsApitfiLAP5aar2z00aVzxT8W04uC4RDG5OmkG9JDYJT
	 FbRpQQIqNJwDNd4Qkx7o9WHA958ibgGcf+XgQgn4qqb06K68Mg6Eqxg8wg/SfW6yca
	 Vkg77+kcc7Qba23+amlfV+mPrLhQRAiXehj5Fvl9E19ezomoDwqtUziIamPq+FyBfJ
	 nCHGnweXvE9wQ==
Message-ID: <e25962a1-cd0c-47c9-9e10-008c475f22cb@kernel.org>
Date: Fri, 21 Jun 2024 09:05:33 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when
 ATA ERR/DF are set
To: Niklas Cassel <cassel@kernel.org>, Igor Pylypiv <ipylypiv@google.com>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-3-ipylypiv@google.com> <ZnAeFbdt02zge2my@ryzen.lan>
 <ZnIBdj02yKFz4sK8@google.com> <ZnQm3-OL95x_Z_VP@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZnQm3-OL95x_Z_VP@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 21:55, Niklas Cassel wrote:
>> Thanks for pointing this out! Looks like ATA PASS-TRHOUGH case is fine
>> since the flag is always set by ata_scsi_pass_thru() as you pointed out.
>> Do we still want to add the check even though we know that it is always
>> set by ata_scsi_pass_thru()?
>>
>> If the answer is "yes", I wonder if we should use the ATA_QCFLAG_RTF_FILLED
>> flag instead? Currently it is used for ahci only but looks like it can be
>> expanded to other drivers. inic_qc_fill_rtf() will benefit from this change
>> because it is not always setting the status/error values:
>> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/sata_inic162x.c#L583-L586
>>
>> For the non passthough case qc->result_tf in ata_gen_ata_sense() is also valid
>> because fill_result_tf() is being called for failed commands regardless of
>> the ATA_QCFLAG_RESULT_TF flag:
>> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/libata-core.c#L4856-L4873
>>
>> In this case using ATA_QCFLAG_RTF_FILLED will be more accurate because
>> fill_result_tf() is being called even when ATA_QCFLAG_RESULT_TF is not set.
>>
>> With that said I'm not sure if it makes sense to update all of the ATA
>> error handling to start checking for the ATA_QCFLAG_RTF_FILLED flag.
>>
>> What are your thoughts on this?
> 
> I see your point, we will fill the result if there is an error,
> even if ATA_QCFLAG_RESULT_TF wasn't set.
> 
> Perhaps we should modify fill_result_tf() to set ATA_QCFLAG_RTF_FILLED,
> after it has called ap->ops->qc_fill_rtf(qc);

Yes, let's do that.

> Then this code can check if ATA_QCFLAG_RTF_FILLED is set, like you suggested.

And I wonder if we should not just drop ATA_QCFLAG_RESULT_TF and *always* set
the result tf for all commands. I fail to see why this is conditional to that flag.


-- 
Damien Le Moal
Western Digital Research

