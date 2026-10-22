Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661596;
	b=IQzSwbQT3vNLtEYXs2QnvalwpC6f9eqHCK4iPHK5a/xBVJq3+uKQ21G9VMRixGbTKAhB
	 1+vvovZzQ06zxhfzPRn/OWz6pEZONMgOAKC5ne613FnzCBKAQTibf5Jh84p23TVMIOnF3
	 /VI+cpe57PgYXCzQaVgh8WvIdDKfjoe1cKd0+wuF26myXuSWMgDJC57Jm5O9Kugepe5MJ
	 T3kJWlQvNHkR7TYLeKc9nOyw2+1RZgLmR2uabx8LqyAdyrRDGgLnReL08sLd5W1ASEhri
	 V2fZ9aDTKMdyZn0YpohFe2SqOaVNluXHUQlqAWd48AbSXtxAVN0G+oXJTRBo3WsPlkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661596;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=M0opiqtE+upay0JHDbLV2w3rm0WshmNfUYFNrui+nFg=;
	b=f5FNQHDDHh/WD+eJi7woxXjUcUxn0U2PZhuofdWX6cXAogkF6PwCosNZOuk8LpFOLDKy
	 u7+NSLp3uPfqWJU8m4WeOTJqnkAAzO0cj6vBDuo/XfhCcu2m8VAxoIrtLO9iTWvg/X7qH
	 29ayV7yvrBvOB9x/uiZOhvCILHlFXNB8POjFo7+vtpG3B+6nQXQPPJI2vecxKjmSdFN3I
	 6dc/beTH+mhwbSrGWYhfn9QWCYpGccj86JS1Xd8RhunP7x3aci0YQ/g0dYGDnBcaWq43i
	 Ugt5l759DWlxQ4NHHWJapP0ppkMgzgIz8DIxvl8oLEn1/bViJjok2cp6JsMrPad7uGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAF4J4tV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F4606A31A;
	Thu, 22 Oct 2026 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAF4J4tV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9447A1F000C7;
	Thu, 22 Oct 2026 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792661596;
	bh=M0opiqtE+upay0JHDbLV2w3rm0WshmNfUYFNrui+nFg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fAF4J4tVJ/qE4wZXkG+nyun3bgHsPoUNJVxjmHL9kuexldr/guK0kGmzQplj9z/fp
	 Dz2B3NVYFTSjUDb4pxTbeqDhBKYRA2scbLzTHkq5M8duT4yIWamtBmxVqt0cbcbk7/
	 u3w4B6ktBdTqujgIQuK9FH7Jstr3VCFGsMSxFyGfan0gkF+YR1kBFfiZe/mt2s/pu+
	 jKYLNEeL8on94wTbkq/Ot5QZNDMK8PDppDEPqs2h+pxr2P5hBgjjHnOv2Q5+25Glma
	 KS8gdLd1QVvuNOIl3Z3yy+SKbY5fAr1wB25OirsRQXwMejtnxxUigWRT/45UOWWnoU
	 aoasEYg5oX28g==
Message-ID: <db1f6641-9700-43b3-b091-e736c8ef88f5@kernel.org>
Date: Thu, 22 Oct 2026 11:33:12 +0200
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: pata_artop: read the ATP865 mode register
 through pci_iomap
To: Daniel Palmer <daniel@0x0f.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
 glaubitz@physik.fu-berlin.de, cassel@kernel.org, linux-sh@vger.kernel.org,
 linux-ide@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org
References: <20261017041419.311921-1-daniel@0x0f.com>
 <20261017041419.311921-2-daniel@0x0f.com>
 <3f657b75-64c9-442b-a609-987cc16f5501@kernel.org>
 <CAFr9PXnNKfZtXpBe2OVZvu=rf+fsx5NEp7tSGS_FxRKsL3+wQw@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAFr9PXnNKfZtXpBe2OVZvu=rf+fsx5NEp7tSGS_FxRKsL3+wQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/22 11:17, Daniel Palmer wrote:
> Hi Damien,
> 
> On Thu, 22 Oct 2026 at 16:01, Damien Le Moal <dlemoal@kernel.org> wrote:
>>> +     case 2: {       /* 6280 or 6280 + fast */
>>> +             void __iomem *bmdma = pci_iomap(pdev, 4, 1);
>>> +             u8 cfg;
>>> +
>>> +             if (!bmdma)
>>> +                     return -ENOMEM;
>>> +             cfg = ioread8(bmdma);
>>> +             pci_iounmap(pdev, bmdma);
>>> +             if (cfg & 0x10)
>>>                       ppi[0] = &info_628x_fast;
>>>               else
>>>                       ppi[0] = &info_628x;
>>>               break;
>>>       }
>>> +     }
>>
>> This is really ugly... Please move the "case 2" variable declarations to the top
>> of the function so that you do not have to do something like this.
> 
> That's fair. I'll fix that up.
> 
>> Of note also is that this switch does not have a "default" case, which is really
>> bad practice, even though in this case, we should never hit unknown values.
>> But I would still prefer seeing something like:
>>
>>         default:
>>                 pr_warn("Invalid driver data\n");
>>                 pci_disable_device(pdev);
>>                 return -ENODEV;
>>         }
> 
> Can we fix that later or should I roll it into this patch? Being an
> old driver I think it probably has a bunch of preexisting style issues
> that need to be fixed but that seems like a separate issue from making
> it functional again.

Later is fine.

> 
> Cheers,
> 
> Daniel


-- 
Damien Le Moal
Western Digital Research
