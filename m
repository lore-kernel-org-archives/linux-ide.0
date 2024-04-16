Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0A13A86C
	for <linux-ide@vger.kernel.org>; Tue, 16 Apr 2024 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309195; cv=none; b=ODuobNaLgp2JqH5xGz3HSwipSKJvyhkdP76TEtQ+dxjrvmDhL7MMYgonsk3txZ7Qy2Q/rKWsVnmXVsrE9CQhdOpQBiGQ/0kPyInoWg9JOAnuqzdhcEMbzIFalqxcsWXXIIscjABU124820oyJEw5kUre1XXQ+RwwPhkw12+HkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309195; c=relaxed/simple;
	bh=bUwK08HOLLlGwkk94ieXnC4sjNs7nO9zlrv9DAuCmO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VV2Tom4IPaweJz54G5dp5DK6DQaR9sryQgF5zNWgnziGXs2ijrhF2BmT+EyaP4GIW9vse6S/iq6GQwp8qnFonYyD7fQo8U95g5ntGavplPAOXzkjnsif9lyEb9ieCkITjVNSna3s5Enw4DgUAuuXdVw23d+dAR39N2LMFkAIqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx3rYJVC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx3rYJVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8107FC113CE;
	Tue, 16 Apr 2024 23:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713309194;
	bh=bUwK08HOLLlGwkk94ieXnC4sjNs7nO9zlrv9DAuCmO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xx3rYJVC75l/ikvx0tW8ZRckmyLucvOe9kFd01yHFkNdGJhqPckQ48yc2xG9+J2Az
	 evhmLahUI6RjNwHg/SDo9zUr1EsNjePdaRIksgW78Ml6AFyajHVZRxPhgYm7cWUrt7
	 1kFuK2DLW8+q78k+UXj0QTKl4Sd1dqZCrLnXbogQp473TtWa3kCjysfoi+UHXi1WWC
	 dqp3pEoWLvEUN6d28OFWkSe0MgOEVCj6li5n4xBLul5IjMDsvNHSvBdCVbsGsMoal9
	 zUM4pxF2CE57pNhNgAEv0OIxHoaAdfOiX3YzEqCc4j/1xnZgSJeBPztpwEFdYx48s4
	 Zi6hAcVFe9DPw==
Message-ID: <5fdd9099-61e4-44c0-acb2-72f766f0e87f@kernel.org>
Date: Wed, 17 Apr 2024 09:13:08 +1000
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
 <33e81fd6-2d0d-4d23-9cab-fed775917bc0@kernel.org>
 <em46c5a70c-ff8b-415d-918e-fb53baf8fd68@5422b68e.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <em46c5a70c-ff8b-415d-918e-fb53baf8fd68@5422b68e.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/14 23:14, Conrad Kostecki wrote:
> Hello Damien,
> please apologize, I wasn't able to answer earlier, but I had some health 
> issues.
> 
> 
> Am 08.04.2024 04:26:06, "Damien Le Moal" <dlemoal@kernel.org> schrieb:
> 
>> On 4/6/24 07:53, Conrad Kostecki wrote:
>>>  Hi Damien,
>>>
>>>  Am 05.04.2024 14:51:43, "Damien Le Moal" <dlemoal@kernel.org> schrieb:
>>>
>>>>  <PATCH v2>
>>>  i did run a test on my hardware.
>>>  It seems to work and adjusting the port_map. But I noticed a difference, that
>>>  those virtual hostXY ports are not marked as DUMMY.
>>>  With the previous patch, only six ports reported "ahci" and rest "DUMMY".
>>>  I am not sure, if that should also not happen with your patch?
>>>  Conrad
>>>  [   13.365573] ahci 0000:09:00.0: masking port_map 0xffffff3f -> 0x3f
>>>  [   13.376511] ahci 0000:09:00.0: SSS flag set, parallel bus scan disabled
>>>  [   13.395670] ahci 0000:09:00.0: AHCI 0001.0301 32 slots 32 ports 6 Gbps 0x3f
>>>  impl SATA mode
>>>  [   13.397111] ahci 0000:09:00.0: flags: 64bit ncq sntf stag pm led only pio
>>>  sxs deso sadm sds apst
>>>  [   13.593757] scsi host9: ahci
>>>  [   13.597362] scsi host10: ahci
>>>  [   13.600949] scsi host11: ahci
>>>  [   13.604548] scsi host12: ahci
>>>  [   13.612459] scsi host13: ahci
>>>  [   13.616027] scsi host14: ahci
>>>  [   13.616437] scsi host15: ahci
>>>  [   13.616745] scsi host16: ahci
>>>  [   13.617039] scsi host17: ahci
>>>  [   13.617415] scsi host18: ahci
>>>  [   13.617723] scsi host19: ahci
>>>  [   13.637158] scsi host20: ahci
>>>  [   13.640666] scsi host21: ahci
>>>  [   13.651760] scsi host22: ahci
>>>  [   13.652311] scsi host23: ahci
>>>  [   13.652850] scsi host24: ahci
>>>  [   13.656374] scsi host25: ahci
>>>  [   13.664120] scsi host26: ahci
>>>  [   13.664570] scsi host27: ahci
>>>  [   13.686567] scsi host28: ahci
>>>  [   13.690179] scsi host29: ahci
>>>  [   13.697603] scsi host30: ahci
>>>  [   13.698083] scsi host31: ahci
>>>  [   13.698518] scsi host32: ahci
>>>  [   13.701855] scsi host33: ahci
>>>  [   13.702323] scsi host34: ahci
>>>  [   13.702745] scsi host35: ahci
>>>  [   13.721520] scsi host36: ahci
>>>  [   13.725157] scsi host37: ahci
>>>  [   13.736948] scsi host38: ahci
>>>  [   13.737383] scsi host39: ahci
>>>  [   13.748518] scsi host40: ahci
>>
>> These messages are normal. ata port stucture which leads to a scsi host are
>> still created for dummy ports. So seeing all ports here as scsi hosts is
>> normal. However, after these messages, you should see a "ataX: DUMMY" message.
> 
> That's what I mean. My asm1166 controller has only six ports. So for the 
> list, most of them should been listed as DUMMY, but they are not.
> With my previous patch for asm1066, this was the case.

OK. So despite what I thought, it seems that the mask should be applied to
saved_port_map to modified that value permanently instead of using the mask to
set ->port_map. I do not really understand why that would be needed. It seems
that saved_port_map is being reused without the mask applied somewhere, which
should not happen. I need to dig further into this.

In the meantime, can you try to add this patch:

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 83431aae74d8..830a59f68620 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -546,6 +546,7 @@ void ahci_save_initial_config(struct device *dev, struct
ahci_host_priv *hpriv)
                        port_map,
                        port_map & hpriv->mask_port_map);
                port_map &= hpriv->mask_port_map;
+               hpriv->saved_port_map = port_map;
        }

        /* cross check port_map and cap.n_ports */

And test again ?

> 
>> Can you confirm that you see this please ? Also, please confirm that boot time
>> is OK and faster with the port map mask.
> No, I am currently not able to confirm. It looks like, that's is still 
> slow for me. Maybe a little bit faster, but I may be wrong.
> The main difference here is, that none of the asm1066 ports is being 
> listed as DUMMY with your patch.
> 
> As my "ahci" module is build into the kernel, I added to my kernel 
> arguments:
> ahci.mask_port_map=0000:09:00.0=0x3f
> 
> Based on the dmesg output, this should be correct?

Yes, this is correct and for your adapter with 6 ports, the mask 0x3f is correct
as well, assuming that the 6 physical ports are the first ones (ports 0 to 5).

> 
> Cheers
> Conrad
> 

-- 
Damien Le Moal
Western Digital Research

