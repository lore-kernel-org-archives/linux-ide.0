Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859A155CBE;
	Tue, 18 Jun 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702044; cv=none; b=fN+NZsb4HuODlP40DUCEmcn1f3N2r+61HDjSNVfhR2CUeayhIKDZkhRkg/RlUWgGLZbBOuQK3hAAqkFGjhcX4wjE9KU99r0n5X28sLYjpFYuz9ELI7+qtu2qCuJeeny4dLdXXsL+owRWsqsYzXWJO/TthuSZsis1s70nupSzNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702044; c=relaxed/simple;
	bh=ttYN9V7Bv0xdEUu9yvXJ2Kb1OFzdBlAYZwrbDTsO7FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQl1Fl/vziVpGdP4oAdkKMwYwub10OsKdb1b5+6QocBrlLwTHhyxoMR79byjuAQ/3bSGyhGaGsNcdajJFL1vxI8wPRo7M1BvMczGIO6UkYblZP+l0cWKosERUo6DN4rpTEK4ApcnbZjDp9xTR3k/EBA7ytgxCYRJNBnx+7KcoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+D8twzo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+D8twzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C196C3277B;
	Tue, 18 Jun 2024 09:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718702043;
	bh=ttYN9V7Bv0xdEUu9yvXJ2Kb1OFzdBlAYZwrbDTsO7FI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C+D8twzoSvvGoWOZwivYtyP5feM5zLG61KgFlipYdDyKEU8NLYzTatHWDSpxYHf3S
	 3kEvuMJ19ajA2An6lx+jDXSFsnb2EDI1Q6WSj4Qeo230r7R7w2lUmRpuFUbuBqko7I
	 e2h/hRuz7y4t/uVkTPkqE5yi/X7tUzVcJzeXNa9OrZ2ZCRiSqJEtnHE0SEl2PQr3uK
	 1xlgWUMGfDrK+lP6CYeu98f4LrdJ3l8quXoD3asIdQ5PYQ4dS2beKnBerTy+s5W6/i
	 0M6uxuJmAVzVlX+QzIuPudK2RkNejBIKyzJOu5UQ4rd379w2RLrT0EMAbsI+yltSG7
	 qoX/xmI+iit5Q==
Message-ID: <bfda328d-572e-4eca-b451-8e7a112c2f48@kernel.org>
Date: Tue, 18 Jun 2024 11:13:54 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: ata: ahci-fsl-qoriq: convert to yaml
 format
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev
References: <20240617180241.901377-1-Frank.Li@nxp.com>
 <ZnCKlj_Gp60_2otI@ryzen.lan>
 <09fad8cc-ff9e-48b4-b954-4f84c61f3ffc@kernel.org>
 <ZnFJINOphiD1BWyR@ryzen.lan>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZnFJINOphiD1BWyR@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2024 10:45, Niklas Cassel wrote:
> On Tue, Jun 18, 2024 at 09:42:03AM +0200, Krzysztof Kozlowski wrote:
>> On 17/06/2024 21:12, Niklas Cassel wrote:
>>> On Mon, Jun 17, 2024 at 02:02:40PM -0400, Frank Li wrote:
>>>> Convert ahci-fsl-qoirq DT binding to yaml format.
>>>>
>>>> Additional changes:
>>>> - Add reg-names list, ahci and sata-ecc
>>>> - Add fsl,ls1028a-ahci and fsl,lx2060a-ahci
>>>>
>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>> ---
>>>>  .../bindings/ata/ahci-fsl-qoriq.txt           | 21 -------
>>>>  .../devicetree/bindings/ata/fsl,ahci.yaml     | 58 +++++++++++++++++++
>>>>  2 files changed, 58 insertions(+), 21 deletions(-)
>>>>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
>>>>  create mode 100644 Documentation/devicetree/bindings/ata/fsl,ahci.yaml
>>>
>>> Should this file perhaps be called:
>>> fsl,qoriq-ahci.yaml ?
>>>
>>> Would be nice with some input from DT maintainers on this.
>>
>> This should be rather compatible.
> 
> Considering that you gave your Reviewed-by tag, I interpret this sentence
> as that you are happy with the filename used (fsl,ahci.yaml) in this patch.
> 

Yes, maybe indeed fsl,qoriq-ahci or compatible-based would be better,
but probably I provided a bit different review on other patch, so don't
want to block useful conversion.

Best regards,
Krzysztof

