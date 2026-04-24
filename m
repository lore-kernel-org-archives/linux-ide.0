Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400DB5C613;
	Fri, 24 Apr 2026 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776998595; cv=none; b=AqCBa8j0xHNXrVSpwnj9vhVCD4DvH35j9uQNFsAh0n8OO3Wg787Ag58GstgmtrhgiIhExvc0s5zqb37eJSWQ8vwDaQFjSYyPablmm+Dji0SRTTFAUSrqZM8uOudrL1z8+yyYqFSBMVwebEG5XwPf/RrtAf2eTSn93HG2RZ3CHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776998595; c=relaxed/simple;
	bh=9rN1jtzFO06UrpxbNa4Qq6Q8jPuEbRlHbTyf6EgcvDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyIEfTPw3R4lQsN7RdohvoAYvT4VgJwZLe1AvVzha3AwJdOYJcaGpI55KDsNgFdnmp3NDooKlPhMrOx1ZdzcHd6lcBk/HmtQ6tzn8vGAmyeKgZYrlKU0HRIFexmN4RHTUN5RPW89ekw9GUPhjPuS2nGSXLY1l+weC7RZPuA3ljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/VOOqR5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/VOOqR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0268AC2BCB3;
	Fri, 24 Apr 2026 02:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776998594;
	bh=9rN1jtzFO06UrpxbNa4Qq6Q8jPuEbRlHbTyf6EgcvDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P/VOOqR5my4aJi+h8xNCbrLjXq4pDniQmZ7Z6zPoATYnxvulPgCUsf/CoaxYc97PX
	 PdGsmPsizFDEOvmKRpUccigF0hFSQoHehc6GRUPTRbJ1BUDFGRbG3DEYdIl6L5G2LJ
	 16SuDwotIVdPR/Ng4fhSsNlQlIs7nK9MLpzjJqSDOUMZW/GedwLTZolu4iEnw4chyT
	 hj459K9ecRETSnf4S686wPHzPyb2X4+HDEcJNt4XqGjxKZWFrbMWsWYnf+oPvk52D1
	 Ar+14+h1X586/0wolmkqvmkwh3bEm+RHSqsKQ8Sr3ScVR6hUw55ECpMNormpQQoWQX
	 FWsy5DO9+YjOw==
Message-ID: <e4280e3b-b02a-4c4d-97dd-1bd49daad2fd@kernel.org>
Date: Fri, 24 Apr 2026 11:43:11 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libahci: fix panic when accessing ports beyond MMIO
 region
To: Niklas Cassel <cassel@kernel.org>, =?UTF-8?B?5p2O5L2R6bi/?=
 <dayou5941@163.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 liyouhong@kylinos.cn
References: <20260422080322.1006592-1-dayou5941@163.com>
 <aejc_kqSuU60oRka@ryzen>
 <55809835.8838.19db9be1205.Coremail.dayou5941@163.com>
 <aepUh_p0Jkw0XQ7N@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aepUh_p0Jkw0XQ7N@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/24/26 02:19, Niklas Cassel wrote:
> Hello liyouhong,
> 
> On Thu, Apr 23, 2026 at 05:48:54PM +0800, 李佑鸿  wrote:
>> However, I have already confirmed with the BIOS supplier that when the 
>> BIOS disables all SATA ports, it does indeed initialize the values of 
>> the HOST_CAP and HOSTPorts_IMPL registers in accordance with the specifications.
>>
>>
>> /* Register values after disabling SATA in BIOS */
>> HOST_CAP (0x00) = 0xffffffff
>> HOST_PORTS_IMPL (0x0c) = 0xffffffff
>> HOST_VERSION (0x10) = 0xffffffff
>> MMIO_SIZE = 4096
> 
> I am actually very surprised to see e.g. CAP (0x00) and AHCI VERSION (0x10)
> being uninitialized.

What I am surprised of here is that we even see that device on the PCI bus at
all when it is disabled in the BIOs. If that device is disabled, why are we even
seeing it by scanning the PCI ports ? The adapter should simply not be visible
at all.

Trying to debug register values when we should not even be seeing the device in
the first place does not make sense to me. If anything, I would take a really
big hammer here and try to completely ignore that adapter if we can somehow
detect that it has been in fact disabled in the BIOS. But that detection may be
challenging to do since it seems we are dealing with a very buggy BIOS.

So maybe we should simply warn and exit probe early if we see a PCI BAR size
that is broken.

-- 
Damien Le Moal
Western Digital Research
