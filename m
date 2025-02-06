Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5214286;
	Thu,  6 Feb 2025 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805759; cv=none; b=HV+Y7cZ6xUnZ2e6F+Ht0bX1HiVZXJabolbG57oFWmIK8OX/7dNoyNseYVApt/uzFGBa7IxmaMJRtKr4njSTnuSU2kvCUNkMtgqBhwnoYA7njx4GDwsIIbHTzY9IdfGQhrH5MlqqYa1ijfVjg5d8KWxyxZBdtgok7tguxgsFZO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805759; c=relaxed/simple;
	bh=Q4HZdbCcFW4AQEovlCAaAVzNXUQINEtWCnz78X28Sx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMO+gKnEcdKDg7oXZNyA05COXYXdEFGzydVKgN0ydBwi6nszuY5V3c5JOVDYv5gOe+2V1CvDkT2z7MI4W3YW5668NG83PVTDb+b+p8aLDnZjT9cMjn5nSCaQXsigcg1Jwi9AiwhjnmB9iXS2jdd4Wh3/BxYgj7kSUorSqiOhV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxVZoZov; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxVZoZov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF07C4CEDD;
	Thu,  6 Feb 2025 01:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738805758;
	bh=Q4HZdbCcFW4AQEovlCAaAVzNXUQINEtWCnz78X28Sx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lxVZoZovRsjVLxMvu190nbANVY20g3GPuLMXGaOqRLlnJpS+r+lHkQZOtUEwh7dPn
	 tP3HFnwrYcULRk5cgcy5/EkyJLtcPTeWJk3HR45f1FgANhyo2WBpuD8JVq28pBo8Yk
	 grdyB0eqQ4okADAe/GMCTFVamhmOYSq4Mxagl2dZ7bMptv52of1uRl21FDW4RBJ+yT
	 j8YULjoCqlm7QLQgwpuIsDOovIhTdT7OsMyRGoQeLD9IS0TbjBJDaY8u5raFP2ygNm
	 311iY6SFyL7LdKsrQ4I1rbfn1W+9lA5dDtaqRC6LqAUuE0YaivP9PmgRfAj3tUYcov
	 a85wubjW9NZ1w==
Message-ID: <fa54a148-6016-429b-b494-490041564e51@kernel.org>
Date: Thu, 6 Feb 2025 10:34:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libahci_platform: support non-consecutive port
 numbers
To: Klaus Kudielka <klaus.kudielka@gmail.com>,
 Josua Mayer <josua@solid-run.com>, Niklas Cassel <cassel@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>,
 Rabeeh Khoury <rabeeh@solid-run.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
 <bcfa145c3227b13e7b9d8bb3b0f92c678464cfdc.camel@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <bcfa145c3227b13e7b9d8bb3b0f92c678464cfdc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/6/25 3:03 AM, Klaus Kudielka wrote:
> On Wed, 2025-01-01 at 13:13 +0100, Josua Mayer wrote:
>> So far ahci_platform relied on number of child nodes in firmware to
>> allocate arrays and expected port numbers to start from 0 without holes.
>> This number of ports is then set in private structure for use when
>> configuring phys and regulators.
>>
>> Some platforms may not use every port of an ahci controller.
>> E.g. SolidRUN CN9130 Clearfog uses only port 1 but not port 0, leading
>> to the following errors during boot:
>> [    1.719476] ahci f2540000.sata: invalid port number 1
>> [    1.724562] ahci f2540000.sata: No port enabled
>>
>> Update all accessesors of ahci_host_priv phys and target_pwrs arrays to
>> support holes. Access is gated by hpriv->mask_port_map which has a bit
>> set for each enabled port.
>>
>> Update ahci_platform_get_resources to ignore holes in the port numbers
>> and enable ports defined in firmware by their reg property only.
>>
>> When firmware does not define children it is assumed that there is
>> exactly one port, using index 0.
>>
> 
> [...]
> 
>> @@ -625,6 +651,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>  		 * If no sub-node was found, keep this for device tree
>>  		 * compatibility
>>  		 */
>> +		hpriv->mask_port_map |= BIT(0);
>> +
>>  		rc = ahci_platform_get_phy(hpriv, 0, dev, dev->of_node);
>>  		if (rc)
>>  			goto err_out;
>>
> 
> This very last hunk (when firmware does not define children...) causes some change in behaviour on my Turris Omnia
> (Armada 385):
> 
> 6.13.0 bootlog
> ==============
> 
> Feb 05 18:30:45 xxxx kernel: ahci-mvebu f10a8000.sata: AHCI vers 0001.0000, 32 command slots, 6 Gbps, platform mode
> Feb 05 18:30:45 xxxx kernel: ahci-mvebu f10a8000.sata: 2/2 ports implemented (port mask 0x3)
> Feb 05 18:30:45 xxxx kernel: ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
> Feb 05 18:30:45 xxxx kernel: scsi host0: ahci-mvebu
> Feb 05 18:30:45 xxxx kernel: scsi host1: ahci-mvebu
> Feb 05 18:30:45 xxxx kernel: ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 40 lpm-pol 0
> Feb 05 18:30:45 xxxx kernel: ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x180 irq 40 lpm-pol 0
> 
> Previously, both detected ports were automatically used, and no warning was emitted.
> (hpriv->mask_port_map was 0x0)
> 
> 
> 6.14.0-rc1 bootlog
> ==================
> 
> Feb 05 18:36:40 xxxx kernel: ahci-mvebu f10a8000.sata: masking port_map 0x3 -> 0x1
> Feb 05 18:36:40 xxxx kernel: ahci-mvebu f10a8000.sata: AHCI vers 0001.0000, 32 command slots, 6 Gbps, platform mode
> Feb 05 18:36:40 xxxx kernel: ahci-mvebu f10a8000.sata: 1/2 ports implemented (port mask 0x1)
> Feb 05 18:36:40 xxxx kernel: ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
> Feb 05 18:36:40 xxxx kernel: scsi host0: ahci-mvebu
> Feb 05 18:36:40 xxxx kernel: scsi host1: ahci-mvebu
> Feb 05 18:36:40 xxxx kernel: ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 40 lpm-pol 0
> Feb 05 18:36:40 xxxx kernel: ata2: DUMMY
> 
> Now, hpriv->mask_port_map is forced to 0x1, resulting in a kernel warning, and no more ata2 available.
> In my particular case it is not a big deal, since nothing is connected to the 2nd port, and I can live with this obscure warning.
> 
> But that might not be the case for everybody?

Can you try this to see if it restores the probe for the second port:

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 53b2c7719dc5..91d44302eac9 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -651,8 +651,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct
platform_device *pdev,
                 * If no sub-node was found, keep this for device tree
                 * compatibility
                 */
-               hpriv->mask_port_map |= BIT(0);
-
                rc = ahci_platform_get_phy(hpriv, 0, dev, dev->of_node);
                if (rc)
                        goto err_out;


-- 
Damien Le Moal
Western Digital Research
