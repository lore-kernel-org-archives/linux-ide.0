Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0979DA6
	for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702978; cv=none; b=OWGUU3xDDJsJK3ljpdCxr7PgmtUldJCCw1RoUtMbF6HsFvY9jOH6ZDPcrX3qTudmF99iiXE+JLvjRznWFxNKFfJFPRn98mO2yGrhOuIQLBkrRLJZq2xP2k/tGhBYOEzPGXwH3ktp1lQh102UlVgNpzF9fcfwy8qLSGhX0AbT/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702978; c=relaxed/simple;
	bh=w4G8MW0rx43Lop+ejKG/yfh5pmb+qmERPU2sWqE8hjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5FBY3IoyB6Ek8ks/lkEHZ2mkHVr+C7Dz+0RCCCDQHHuP5wQj5tfGPnAP1Bir0p4LEkI6y2zxnLWmY3o+Oa3urfnpEq5X4jMH3+z/LxkN081z5LAgQIDDVKL3yKIP/O6iP4+rbb8VJrKFS1s1WxUZL4L05+5IUPztaB0+s3g31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no92R8Ji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no92R8Ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF83C43390;
	Wed, 31 Jan 2024 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706702977;
	bh=w4G8MW0rx43Lop+ejKG/yfh5pmb+qmERPU2sWqE8hjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=no92R8JiPwx2fv+q6nB1uxQN+Kd10TehEp7DhdtWQB4PqP3JgOIpzTPgeuc8PYLWf
	 koE6M6A6akWyqHBSqsKYw480OV0nx0EfLh00hevBe4+d9ZhSTh+KByen/0/eb5LMS5
	 I59MIEzM39xlLExvkXdNGySlaElzV46fwJ1t/NBjJFRaEFEV9p/4PnNwC/givqkuDI
	 5ckv+AJvzCj+2ZqsSK6KTYmvrFE4nvkPM4rCWqyocN3Rruc8H5VgQnRoqpDpJ169wI
	 I41dSuJAvDb/09djoI0MemOxhJ6o90Jal/ltg3s3JFn9dJYFcc+kdac7mXfRcoTuia
	 AdNOlhLEwautg==
Message-ID: <1a7f5f79-95d2-4efb-a76a-6b7cd0cfe006@kernel.org>
Date: Wed, 31 Jan 2024 21:09:35 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: Re: Re: [PATCH 0/2] Power management fixes
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>, linux-ide@vger.kernel.org
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
 <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
 <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
 <ZboztvrqKKdLQ1mt@x1-carbon>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZboztvrqKKdLQ1mt@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/24 20:49, Niklas Cassel wrote:
> On Wed, Jan 31, 2024 at 04:38:28PM +0900, Damien Le Moal wrote:
>> On 1/31/24 16:29, Dieter Mummenschanz wrote:
>>> Damien,
>>> so I've applied the patch to 6.8-rc2. Interesting thing is that the behaviour is 
>>> exactly the same as before (w/o the patch). Besides not 
>>> honoring CONFIG_SATA_MOBILE_LPM_POLICY=3 after boot my system refuses to 
>>> transition into lower power states > pc2 after resume even after letting it sit 
>>> idle for 10 minutes. Transition is only reached after issuing hdparm -Y. So if 
>>> the patch restores the original behaviour then why did it stop working?!
> 
> Hello Dieter,
> 
> Just to confirm,
> while testing Damien's patch on top of 6.8-rc2,
> did you still do:
> 
> for foo in /sys/class/scsi_host/host*/link_power_management_policy;
>   do echo med_power_with_dipm > $foo;
> done
> 
> It should be needed until we add (or modify the existing entry, if any)
> your PCI vendor and device id to use "board_ahci_low_power" instead of
> "board_ahci", see e.g.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata/ahci.c?id=b8b8b4e0c052b2c06e1c4820a8001f4e0f77900f

Indeed. What is the AHCI adapter here ?
It would be interesting if it is a Tiger Lake :)

-- 
Damien Le Moal
Western Digital Research

