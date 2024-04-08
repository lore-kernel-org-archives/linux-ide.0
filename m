Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B676394
	for <linux-ide@vger.kernel.org>; Mon,  8 Apr 2024 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712537243; cv=none; b=EMuqyeqxLUE6iegMiVMcEuWOZYo6MJWx9BPWXNaFm8o6j9QKiLKgnnc+4m4+briOWPIBFDhUPF+21sMZDDcf81B7OKpg6Q3jpV3FhkKH11+tQR3vQ93PEeSsyhyfSDf2aNJYAToW+jEuu/MqKiZMJwyWQ6MZq69PD6bGAj9SfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712537243; c=relaxed/simple;
	bh=c9XYQCfdX1rg9wMeSS0yfW2hCwPydiTYgGWPqEJWWF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUh+DUHF8XisFC03o9f/3I9nMy+DHaQI4OvbPQSJ4lXSx8N5orbHfJtC52sTDJVTPYCVw3CFPN8+0+Zxi4q4mVOr01mqAU6ftmGTRx2/LTUWm6eeCxnNwlNkrpRW3IwoJGfPFJETXnQth/6urH97nVeUNYRAUJUvJBtu4DtZpA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnHhBvKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnHhBvKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645F8C433F1;
	Mon,  8 Apr 2024 00:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712537242;
	bh=c9XYQCfdX1rg9wMeSS0yfW2hCwPydiTYgGWPqEJWWF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CnHhBvKmtZnoGUSwI+6FvPME+UqJJIXdkvSO1VIPjEgOU6YjITwOonBaCE+zMWVli
	 HyqXV6JrV/qy1VMpu9tC8jAkko5rDOunqQx6on0ptFXFQ+vCq44pYD+E40wqvVhoc/
	 Vkeoz+ahhhUj9oYeZbnpa6QhKVjp5qSTriR76jOCsetBHLDgTTvlY6fX/MaPLSQXrX
	 DqhrYZraDH0yp94imV8R9eLt/TI4OrzCugLs5i/Q0n3ApvrLyWW3ZkfV+2FTvAfpZ+
	 /uiSHBNoHfwtxCpu6xRfDjoPmKJmkKVS3//85OsQisIInLSBv74B6E6P0TVZyCICYy
	 K5ZgrL66i0R9Q==
Message-ID: <698695fa-4f2a-41f7-8f61-c5c8a81f349f@kernel.org>
Date: Mon, 8 Apr 2024 09:47:20 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: Add mask_port_map module parameter
To: Conrad Kostecki <conikost@gentoo.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
References: <20240405125143.1134539-1-dlemoal@kernel.org>
 <em6045942b-7739-40b7-8c9d-ad047918cdb8@a351f4b0.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <em6045942b-7739-40b7-8c9d-ad047918cdb8@a351f4b0.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/6/24 07:53, Conrad Kostecki wrote:
> Hi Damien,
> 
> Am 05.04.2024 14:51:43, "Damien Le Moal" <dlemoal@kernel.org> schrieb:
> 
>> <PATCH v2>
> i did run a test on my hardware.
> It seems to work and adjusting the port_map. But I noticed a difference, that
> those virtual hostXY ports are not marked as DUMMY.
> With the previous patch, only six ports reported "ahci" and rest "DUMMY".
> I am not sure, if that should also not happen with your patch?

Let me check again.

> Conrad
> [   13.365573] ahci 0000:09:00.0: masking port_map 0xffffff3f -> 0x3f
> [   13.376511] ahci 0000:09:00.0: SSS flag set, parallel bus scan disabled
> [   13.395670] ahci 0000:09:00.0: AHCI 0001.0301 32 slots 32 ports 6 Gbps 0x3f
> impl SATA mode
> [   13.397111] ahci 0000:09:00.0: flags: 64bit ncq sntf stag pm led only pio
> sxs deso sadm sds apst
> [   13.593757] scsi host9: ahci
> [   13.597362] scsi host10: ahci
> [   13.600949] scsi host11: ahci
> [   13.604548] scsi host12: ahci
> [   13.612459] scsi host13: ahci
> [   13.616027] scsi host14: ahci
> [   13.616437] scsi host15: ahci
> [   13.616745] scsi host16: ahci
> [   13.617039] scsi host17: ahci
> [   13.617415] scsi host18: ahci
> [   13.617723] scsi host19: ahci
> [   13.637158] scsi host20: ahci
> [   13.640666] scsi host21: ahci
> [   13.651760] scsi host22: ahci
> [   13.652311] scsi host23: ahci
> [   13.652850] scsi host24: ahci
> [   13.656374] scsi host25: ahci
> [   13.664120] scsi host26: ahci
> [   13.664570] scsi host27: ahci
> [   13.686567] scsi host28: ahci
> [   13.690179] scsi host29: ahci
> [   13.697603] scsi host30: ahci
> [   13.698083] scsi host31: ahci
> [   13.698518] scsi host32: ahci
> [   13.701855] scsi host33: ahci
> [   13.702323] scsi host34: ahci
> [   13.702745] scsi host35: ahci
> [   13.721520] scsi host36: ahci
> [   13.725157] scsi host37: ahci
> [   13.736948] scsi host38: ahci
> [   13.737383] scsi host39: ahci
> [   13.748518] scsi host40: ahci

-- 
Damien Le Moal
Western Digital Research

