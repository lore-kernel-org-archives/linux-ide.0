Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01F44B662
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905750; cv=none; b=PBH5/d1S7In9xbYqgzfwiyxofzp6/DhE9qtJpIuA/TW3Rxtl4Vmp5Sw985Xf9W/BClnON1rSgabiVT0O9uq7Kepl0wT3fCeFk0JjVjMlp+WgG5akivhiX+Y5YLr0KAMiOYxJY2MM96Iem1dP/GlaA7VISOFXWKSdTnPaQmUBHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905750; c=relaxed/simple;
	bh=j0pxhamw7PruY0FAkQecTJcnG1F9XLV5rvlkOSPgnvw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=X32+/rrvfDD1aNtGWdQySVAHhvuvtxZyLvpijjgefBValpXJcc3jB6zAFxhRX0HxaJA21PK6Kro1/G82y6aVf1zvN+1CS3WKXJZZdl5R5PUZ/VcqmHrtaeg2eZTDHu/3H/Ql5qLRo3sp7v62VCh64FbWQw/37hqXqthbhkNUx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1wmVugW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1wmVugW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A621F000E9;
	Wed, 27 May 2026 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905749;
	bh=c6r7bsdYfYgYC7lg/KSTG5WJI5KruPrNd3P3tMd42rQ=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=o1wmVugWBt/DJnO9Wj96anLyWdERmp1zvosgYKHyjoTqgRWznVrBhGmZBCtzwq3zp
	 Nnpi1XyTPlXrL5HxpwP0gs7ketU+7BNJ5gqRK9UFT4l8wsx5wXLBNyLab5o/5LN4LZ
	 p9zpQcIiJP4JoyQe5RWvkAXBNLdvmhDfvv3qyQ4YORKYW+adbKdV9t4TGreLXO4YBZ
	 vBcdYKBG2xG40oaoJ9adT0UhACiErH+3JSXxUXIC3JbmXmXKlcpWH4wuoaiTNFyyoO
	 WDAFyfmu2aa0OiEVTVmmU21wqQJ3HeMA2HGlHyM4Ej5bilJiZ+ZrhcFKRByWAWg9QK
	 Ry4wUo0yiIFMw==
Message-ID: <d069d5c1-6b6a-4be6-a1e3-a875fe5c6eb5@kernel.org>
Date: Thu, 28 May 2026 03:15:47 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] libata/ahci: three MMIO trust boundary issues under hostile
 hardware model
From: Damien Le Moal <dlemoal@kernel.org>
To: Michael Lazin <microlaser@gmail.com>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <CALdcr8dMyX+ZRj3ARv6iFkLKXL2+onQbhCkX+=rnXKX3o4SDUw@mail.gmail.com>
 <6c4af01f-f57c-4b40-bd99-9746bb062bcf@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <6c4af01f-f57c-4b40-bd99-9746bb062bcf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/05/27 17:27, Damien Le Moal wrote:
> On 5/27/26 12:38 PM, Michael Lazin wrote:
>> To the linux-ide maintainers and list,
>>
>> Apologies in advance if this hits a moderation queue — I am sending
>> from Gmail and am in the process of subscribing to the list. I am a
>> Debian developer (debian-devel) with a background in network security.
>> I would ask that you judge the technical content on its merits rather
>> than the sending domain.
>>
>> I have been auditing the AHCI driver against a zero-trust hardware
>> model — specifically the threat of malicious or malfunctioning PCIe
>> peripherals. I have mapped three issues I believe warrant discussion.
>> I can send patches for issues 1 and 2; issue 3 requires broader IOMMU
>> policy discussion. All references are against drivers/ata/ in the
>> current mainline tree.
>>
>> ---
>>
>> ISSUE 1: Port map not bounded against cap.np (libahci.c,
>> ahci_save_initial_config)
>>
>> The driver reads HOST_CAP and HOST_PORTS_IMPL as independent MMIO
>> values without enforcing consistency between them. A hostile device
>> returning HOST_CAP.np = 0 (implying 1 port) alongside HOST_PORTS_IMPL
>> = 0xFFFFFFFF (32 ports asserted) causes the host struct to be
>> allocated for one port while the activation loop walks 32, producing
>> out-of-bounds reads and writes into adjacent kernel heap objects.
>>
>> Proposed fix: after reading both registers, clamp port_map to the
>> range implied by cap.np before any allocation or iteration depends on
>> it:
>>
>>     u32 cap_ports = min((cap & 0x1f) + 1, AHCI_MAX_PORTS);
>>     port_map &= GENMASK(cap_ports - 1, 0);
>>     if (hweight32(port_map) > cap_ports)
>>         port_map = (1U << cap_ports) - 1;
> 
> Looks sensible, but we should WARN about a device that has a weird port_map
> that shows ports beyond the number of ports.
> Note that the reverse is common: number of ports is high, but the port_map is
> only a small subset of the max ports.

Checking the code again, ahci_save_initial_config() has the following code:


/* If PI has more ports than n_ports, whine, clear
 * port_map and let it be generated from n_ports.
 */
if (map_ports > ahci_nr_ports(cap)) {
	dev_warn(dev,
		 "implemented port map (0x%lx) contains more ports than nr_ports (%u), using
nr_ports\n",
		 port_map, ahci_nr_ports(cap));
	port_map = 0;
}

So this issue #1 cannot happen I think.

-- 
Damien Le Moal
Western Digital Research
