Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53754ED9;
	Fri,  5 Jul 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720138855; cv=none; b=C8HXHbjLOPd5NR4HWL2o9e+EWoIYCy0ubNIk2hOA25lU0r5wixOJ0TYdpbitn8qUFS8DC5crpbtGGt61r56dAq+G79Usype9ZqhEnculbY6h4bISDMYPWi+6laqt+lGTssfTDzQcreLEdGfCtAIpOgLs62bdeFfXSanlQxMcWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720138855; c=relaxed/simple;
	bh=Oq0qSOcFVxMRjjIYivTKOa/gblUHRyuTwRuZfJl9GqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5zr49c/6i+FEG21/hqjHw+TCQDhybQHYkz+tPzcwHYYv0+gvrFdGKP+UDoOh8JQIUPQbZ9PjnejO39RXgzzF4cJRatRW7TyAWfc77sPBbkESFCkoagxb41o14Kwu/tycgDAyDZdefvhlGzdbL4bzttW8w5663RCN9dK/Dx7MZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeLQxX93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeLQxX93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF29C3277B;
	Fri,  5 Jul 2024 00:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720138854;
	bh=Oq0qSOcFVxMRjjIYivTKOa/gblUHRyuTwRuZfJl9GqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EeLQxX93ulsLzM58FwsZoR5u7Zu5hZQBo784+Ywo5+WFRErNTJf7Hw3nZkzmSDTmP
	 pmIfezJ86yDA73T627vkl3zroPqfH8JLv2tbjEvQAzGzjLSlCdVsjhJkMdV932qBXC
	 A3VYbSDFWgWzHHmubdPekhNQ3UQ4rTbgTq7ue5YpCl/0wy6lK/xMZ2Uire3wflddky
	 MierFDA6f8x94B+14E6P8kHo8YfJ1O/cf13fJG+1800kz/dLY8Sgn5r30nKTx0ysDH
	 uNpUOHHVXdSpE0nF7kzSHOUmcmP33aOv2QPJn3ctVZnDmX0OntQu8XQUkwkUc32SjS
	 w+w5O9gQC+Kaw==
Message-ID: <cce2627f-c02f-4699-81a2-3cd9a1f2d74b@kernel.org>
Date: Fri, 5 Jul 2024 09:20:52 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
To: Frank Li <Frank.li@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev
References: <20240625205752.4007067-1-Frank.Li@nxp.com>
 <327d6dd1-3f31-4b49-96f0-afd754eae086@kernel.org>
 <ZoRm/Lwqb4KGCeUx@lizhi-Precision-Tower-5810>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZoRm/Lwqb4KGCeUx@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/24 05:45, Frank Li wrote:
> On Wed, Jun 26, 2024 at 10:17:55AM +0200, Krzysztof Kozlowski wrote:
>> On 25/06/2024 22:57, Frank Li wrote:
>>> Add compatible string 'fsl,ls1046a-ahci' and 'fsl,ls1012a-ahci' compatible
>>> string. Allow 'fsl,ls1012a-ahci' fallback to 'fsl,ls1043a-ahci'.
>>>
>>> ls1046a ahci ecc disable bit is difference with other chips.
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>  .../devicetree/bindings/ata/fsl,ahci.yaml     | 19 ++++++++++++-------
>>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
>>> index 162b3bb5427ed..a244bc603549d 100644
>>> --- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
>>> +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
>>> @@ -11,13 +11,18 @@ maintainers:
>>>  
>>>  properties:
>>>    compatible:
>>> -    enum:
>>> -      - fsl,ls1021a-ahci
>>> -      - fsl,ls1043a-ahci
>>> -      - fsl,ls1028a-ahci
>>> -      - fsl,ls1088a-ahci
>>> -      - fsl,ls2080a-ahci
>>> -      - fsl,lx2160a-ahci
>>> +    oneOf:
>>> +      - items:
>>> +          - const: fsl,ls1012a-ahci
>>> +          - const: fsl,ls1043a-ahci
>>> +      - enum:
>>> +          - fsl,ls1021a-ahci
>>> +          - fsl,ls1043a-ahci
>>> +          - fsl,ls1046a-ahci
>>
>> Where is the driver change for this?
>>
>> Your commit does not explain why you are doing it and without driver
>> change adding new support it is not obvious. This probably applies to
>> all your patches.
> 
> I think I missed ls1012a and ls1021a.  Commit message is wrong. This is
> for legancy platorm. 
> 
> Basic try to eliminate the CHECK_DTBS warning. ls1012a use
> 
> "fsl,ls1012a-ahci", "fsl,ls1043a-ahci". There are two methods, 
> 1. change binding doc to allow "fsl,ls1012a-ahci", "fsl,ls1043a-ahci"

But then shouldn't you also change the drivers/ata/ahci_qoriq.c to add ls1012a
as a compatible ?

> 2. remove "fsl,ls1012a-ahci".

I am not sure if that is acceptable since there is one device tree using it out
there already.

I am no DT expert, but I think (1) with the driver change is the right approach.
Krzysztof ?

-- 
Damien Le Moal
Western Digital Research

