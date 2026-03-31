Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5EF38F93D
	for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2026 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987790; cv=none; b=tmxZDKAopAUFw53/7yUzxN/hoQ9cvCovE618LYdYPupN0KALComz1ZE9+6r+MERJHf0m+Jrb3BmxCBvCSEZhg1v0UEUCm0d+vfWowXamYSAD694JHowcAiWQER04drLdHLhcz6PDw7HRq9C1KLwkFwoaJDeb7ScyNi0kXU6LxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987790; c=relaxed/simple;
	bh=Hx+riTK0Ch2jajHHa2lAnuETCYjG8hF0TZeIi0q88ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7yv7WeKS8UfVIa1+fE0kax5X2OMTNNdHPhrMecGCUJFr6BkGA6p21soxWNWW33NxfbHYJKWaW1iJR2mWSwZ824VSw9kLJ/ln8W2NfikDvTy5QyJp1g91mC3NOfOeKbR7Ekpnv2xtQvw0sj2cFtQoLUlsYafYk7i6igOtQEhgHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJIcwkb6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJIcwkb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39730C19423;
	Tue, 31 Mar 2026 20:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987789;
	bh=Hx+riTK0Ch2jajHHa2lAnuETCYjG8hF0TZeIi0q88ek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fJIcwkb6ku2PuxKp8Pdj+nQDVMp4Krm+aQnbMEAK+n6EAatQhiQrshQ3++nfA8POy
	 EOJ69yybe0Vr4ry1woQ+vn9b7NwfxiUIUP45UGfEjjzQnjdXw6Wu7DfI5sJOnEMi9U
	 hNmi/sd9vxFSa4z93iJvnGDU7b3oavCwwlJlcKJEstVNhIBh5KzEyenhXDBXm7OQOb
	 cjFYif9ImeyFRH6jqe2wf8bkSed8aeZGjKmRTAcy05rVApBtzzgJkIik78hvoRiiFp
	 XshQOwGx0ujuKhkCY8YVA2AlNuVKPgwOlqxFL7Z3CVStkbvqAFJCT0bQUe8BdKt9YG
	 X+YECih/R7FdA==
Message-ID: <c119c322-d59e-40a0-93c0-f1a4b0da6f56@kernel.org>
Date: Wed, 1 Apr 2026 05:09:47 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ata: libata-transport: remove static variable
 ata_scsi_transport_template
To: Sergey Shtylyov <sergei.shtylyov@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <c23f827a-2ff9-4a6d-afcb-fce83fda4899@gmail.com>
 <6a02ae15-bc91-4a4d-be2d-87e311584ba5@kernel.org>
 <172bb3e2-03fd-4440-9a5c-a3b4b174c0a0@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <172bb3e2-03fd-4440-9a5c-a3b4b174c0a0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 20:41, Sergey Shtylyov wrote:
> On 3/31/26 4:42 AM, Damien Le Moal wrote:
> [...]
>>> Simplify the code by making struct ata_scsi_transportt public, instead
>>> of using separate variable ata_scsi_transport_template.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>
>> One nit below. With that fixed,
>>
>> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>>
>>> diff --git a/drivers/ata/libata-transport.h b/drivers/ata/libata-transport.h
>>> index fe5ca66fc..629ac843a 100644
>>> --- a/drivers/ata/libata-transport.h
>>> +++ b/drivers/ata/libata-transport.h
>>> @@ -3,7 +3,7 @@
>>>  #define _LIBATA_TRANSPORT_H
>>>  
>>>  
>>> -extern struct scsi_transport_template *ata_scsi_transport_template;
>>> +extern struct scsi_transport_template ata_scsi_transportt;
>>
>> Drop the extern please.
> 
>    I'm afraid this will turn the variable declaration into definition,
> and I don't think we want that in a header file... Unlike the functions,
> *extern* with variable declarations is not implied, IIRC.

Arg... You are of course absolutely right. I was thinking "function" and
overlooked that it is a variable. Apologies for the noise.

> 
> [...]
> 
> MBR, Sergey
> 


-- 
Damien Le Moal
Western Digital Research
