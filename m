Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBC33C7;
	Fri,  5 Jul 2024 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159584; cv=none; b=FtnDrXWgprZBlK/dJeiyogqrV1d1f2tTR/qujFySMO8tTYjnBQBV2Zupums6iwl3D1XsOeQZsHeLwMlayMQpCTvGEdluhSS2wgNTYrwOG5R0Zhsz5GgPfaoyXs8xeo3O8aQ7qGB3xjFjJUXDSA3OMOetG/Eu5tOWmTyOLD9oVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159584; c=relaxed/simple;
	bh=JHjJXgeFD4Xw598iJ1pU814GZrbgzmFYVDC3qSP0ffg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uzr0IWXbVQdo3JnA2UEqq7Ktwjaz28JRGfDFaI7h8oj0nN0PyNCN9ZQ/jTpU23RPVA2taY+Q9aY5B5mR4ePyHR1rzmOiKkc2n5tmU1R9V5jNaWHV0iqBPeI5NzkMRR9uqGoNmFEEGHS8cG1JvgZnfTCc8zCMm5g/lxCwPDu+3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM+/1P+V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM+/1P+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44DFC116B1;
	Fri,  5 Jul 2024 06:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720159584;
	bh=JHjJXgeFD4Xw598iJ1pU814GZrbgzmFYVDC3qSP0ffg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TM+/1P+V9EVr2L1mvrYPYWC1z9d5FYFHJ6t6FHHRcx8z9gEILMAakenipcWOR5Z1Z
	 MFkw/L1IS7WiZ4js8WDKWGOjuxR0Yw33cORIE8R0u6dSUDf/ZtEs2pemXUGGMJ/Mjl
	 Gv698Ao1Bbq+ukWDh7zAZfZqd0YGrDHsmM2ISq9feoCkE0jGbOF8syzUqdXIRRBOCr
	 BO8+zBCJXXelrrjhwhO/WuLrn5DnyWKjtiM7moyDmQ+kBDDuMTQ212ociGTNUFfS8k
	 rCH2KzCTOmAUiuXQ/BJ0wxOSu9kJTuCSyZK7Dpjw2G2X1j/1uLtUK5vcJHh4iWDpRG
	 +01ynyGcxHllw==
Message-ID: <e6e72e16-9304-40f3-99b2-cd4a53e5f8f3@kernel.org>
Date: Fri, 5 Jul 2024 08:06:18 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
To: Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.li@nxp.com>
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
 <cce2627f-c02f-4699-81a2-3cd9a1f2d74b@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <cce2627f-c02f-4699-81a2-3cd9a1f2d74b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 02:20, Damien Le Moal wrote:
> On 7/3/24 05:45, Frank Li wrote:
>> On Wed, Jun 26, 2024 at 10:17:55AM +0200, Krzysztof Kozlowski wrote:
>>> On 25/06/2024 22:57, Frank Li wrote:
>>>> Add compatible string 'fsl,ls1046a-ahci' and 'fsl,ls1012a-ahci' compatible
>>>> string. Allow 'fsl,ls1012a-ahci' fallback to 'fsl,ls1043a-ahci'.
>>>>
>>>> ls1046a ahci ecc disable bit is difference with other chips.
>>>>
>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>> ---
>>>>  .../devicetree/bindings/ata/fsl,ahci.yaml     | 19 ++++++++++++-------
>>>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
>>>> index 162b3bb5427ed..a244bc603549d 100644
>>>> --- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
>>>> +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
>>>> @@ -11,13 +11,18 @@ maintainers:
>>>>  
>>>>  properties:
>>>>    compatible:
>>>> -    enum:
>>>> -      - fsl,ls1021a-ahci
>>>> -      - fsl,ls1043a-ahci
>>>> -      - fsl,ls1028a-ahci
>>>> -      - fsl,ls1088a-ahci
>>>> -      - fsl,ls2080a-ahci
>>>> -      - fsl,lx2160a-ahci
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - const: fsl,ls1012a-ahci
>>>> +          - const: fsl,ls1043a-ahci
>>>> +      - enum:
>>>> +          - fsl,ls1021a-ahci
>>>> +          - fsl,ls1043a-ahci
>>>> +          - fsl,ls1046a-ahci
>>>
>>> Where is the driver change for this?
>>>
>>> Your commit does not explain why you are doing it and without driver
>>> change adding new support it is not obvious. This probably applies to
>>> all your patches.
>>
>> I think I missed ls1012a and ls1021a.  Commit message is wrong. This is
>> for legancy platorm. 
>>
>> Basic try to eliminate the CHECK_DTBS warning. ls1012a use
>>
>> "fsl,ls1012a-ahci", "fsl,ls1043a-ahci". There are two methods, 
>> 1. change binding doc to allow "fsl,ls1012a-ahci", "fsl,ls1043a-ahci"
> 
> But then shouldn't you also change the drivers/ata/ahci_qoriq.c to add ls1012a
> as a compatible ?

The fallback will be used by the driver, so there is no need to add
front compatibles to of_device_id table.

> 
>> 2. remove "fsl,ls1012a-ahci".
> 
> I am not sure if that is acceptable since there is one device tree using it out
> there already.
> 
> I am no DT expert, but I think (1) with the driver change is the right approach.
> Krzysztof ?

Yep, this cannot be removed.

Best regards,
Krzysztof

