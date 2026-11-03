Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737506;
	b=I9RuDzBsRB9MWb5Sky6siKrNadfsNLcPFdoECpP5HEaR4G+Ki/dgx8DZq+9B8AKupEMP
	 e8CagqxUlQREnPTSSR0s5Kf35kkzwljp3Tn/wghkRT+EvxNVinNPaCe0BKbsOEoAX1ASL
	 /FEVsOXHgDQiBC6QhEwgl8x4GYMTHAGpjM2bpGiHNgy9EMEUziROjHB0C1FnA5lVSCUQx
	 SuMP1qWNu892Tj5cla2v0FrbMFnsGMvVbtAsc4Wr/dmkKaFrZxwTbe/El2f6rMIufrykF
	 4mXV3JRJ/txzOMiw7NMvn+J8JYms271etzH4OzLAganmCl4ulUBAD/JicPUiaifdF3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737506;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ey3bmLuO/tccwPs6bses4tdGWflrXeb+2JX3HuYScV4=;
	b=so4uPWZ6PptUph0sHBgfQB0UkTKKYBIS5NL7Yjup1vwhmV74Na6hRxuzhgdj4pTvmaOX
	 LOWhdxepZbSKMhfrM1aTLlwxaeAfNkwY2Hm3rKdtmsYPII7inLckLNZm5iyd/Tdy3jxoW
	 UgxdKu/oeAcrB8iOFzprfXwDwJ8u9iREc1LfVgOYKXiDKe6PjO6fyH/mEiM97iF5G2JcV
	 Kt00Uk5cv7c48QuQ9LjDvBYeIgugwc0thE3oO5l7ASB5SR7SNwxbvbEqXHymmd6mB0OUf
	 EkG1sdWvEia/tQ92yEeioU5B/L8Brlqsdd24FG+lz2R+g2p2kPTbnTKAIxSa17h+NlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5ssbrCV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE431606A31B;
	Tue,  3 Nov 2026 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5ssbrCV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21D21F000C1;
	Tue,  3 Nov 2026 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793737505;
	bh=ey3bmLuO/tccwPs6bses4tdGWflrXeb+2JX3HuYScV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P5ssbrCVpBBYTmauqrVaBiDJEvktbbY3AHI740ST8cI80wQGavxxiKa+nooMEATRM
	 eb+x8qWnvDiBDzKQqAEkckVPb55a0wbVtSTOTmgATo95zdHWFr2u/szy1NnV/DILke
	 qb5+6RmUplemGrSjMO57a7YgiQbSXvbWiKKnasCZ+hOAh+0F22xgwavgwKbLaQCjbe
	 0cyJq/eeJtzT57YExAprUOdYuuSh9L4bwPwdwJEn18tpJHV9pBKQ9qrKym22HgUq45
	 Z/DC3+B5fGmmD1trrkD7HTXwDeFYsyAAGwu8OqzO1ZjislP5EOGxe0pEtxfA8eAs9/
	 LoLsy+ATgqQgQ==
Message-ID: <f72d88e0-553d-4cc9-af38-9cca183cb814@kernel.org>
Date: Wed, 4 Nov 2026 05:25:03 +0900
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
Subject: Re: [PATCH v2] ata: libata-scsi: reject data-in commands with a
 data-out buffer
To: Zhao Gongyi <zhaogongyi@bytedance.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261027090809.94126-1-zhaogongyi@bytedance.com>
 <20261028113903.19569-1-zhaogongyi@bytedance.com>
 <8ec9e401-4c00-42fe-b997-228e05ed9c2a@kernel.org>
 <36648b88-c295-4acb-8b6e-25d742d50946@bytedance.com>
 <2def2444-0b73-4371-9ba2-78af235e64cb@kernel.org>
 <0a4822fe-f283-4cac-8ca3-91f4e8f017e2@bytedance.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <0a4822fe-f283-4cac-8ca3-91f4e8f017e2@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 12:19, Zhao Gongyi wrote:
> On 10/30/26 9:18 AM, Damien Le Moal wrote:
>> Yep, these are the only ones we can catch easily. Other commands we do not look
>> at/know about will keep potentially triggering iommu page faults, but that is
>> fine as that is not a crash. However, ideally, that should lead to the command
>> being failed, which it seems we are unable to do... Did you check if we can
>> propagate the fault into a the request to indicate a failure?
>>
> 
> Hi Damien,
> 
> I checked the DMA mapping and IOMMU fault paths.
> 
> For DMA commands, ata_sg_setup() calls dma_map_sg() using qc->dma_dir,
> which is derived from the direction supplied with the SG_IO request.
> Therefore, for a request declared as DMA_TO_DEVICE, the mapping itself
> succeeds with device-read permissions.
> 
> If the device subsequently attempts to write through that mapping, the
> permission violation is reported asynchronously by the IOMMU. I could
> not find a generic mechanism that associates such a fault with the
> corresponding ata_queued_cmd or scsi_cmnd and turns it into a
> per-command failure.
> 
> Some host controllers may also report a host-bus or interface error for
> the command, but that appears to be controller-specific and cannot be
> relied upon by libata.
> 
> Therefore, for the mismatches that libata can identify, rejecting the
> command before issuing it still seems necessary. For arbitrary ATAPI or
> vendor-specific CDBs whose actual direction libata does not know, I do
> not think the generic IOMMU fault can be reliably propagated to the
> request.
> 
> I will wait for your guidance on the appropriate sense code before
> posting v3.

Looking at the list of scsi sense code, I think the data phase may be most
appropriate, but with a qualifier. So why not use: DATA_IN_BUFFER_ERROR (0x4B0A).

The other one that I like would be SCSI_TO_HOST_SYSTEM_INTERFACE_FAILURE
(0x5400), but the DATA IN BUFFER ERROR may be clearer.

-- 
Damien Le Moal
Western Digital Research
