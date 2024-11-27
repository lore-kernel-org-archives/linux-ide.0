Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5851FA24E;
	Wed, 27 Nov 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709080; cv=none; b=GMnFgA3rcBHR9SfVJ/D7h7NtfQaSGssgLb/Nx9MXD557pfDm21890DULTrWzNTHFpkX5f70Qoc8f1saIVAbMzb3mnphCemCNMHMXeg101pHBP+UplB2m7/tKrMz74eRW2kG/jwwIQF8Joq4CWmHEfVwWDLttJjOJpsx6neqbHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709080; c=relaxed/simple;
	bh=z3gJpsn1GMDxzrNhIXAa+9JbX2n+q+8Ao4Iy4g+YjV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilc0lvO5hhhta3PuqsVMYAQQUTZpuqyyOGsg3wTBJcC0lRj4S020mIxP5PmbxO8X8lyCxGdQg/hAMuQ+8hYtFlpENMCqiBvDt7UnCAPy2iK03Xwa0ivKaOmVjEQEUWdWq3lL7xCDXv+oPHsaGJ+LLbjqKxUPGdBirnVVdSfGWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j22qsVM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j22qsVM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B62AC4CECC;
	Wed, 27 Nov 2024 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732709079;
	bh=z3gJpsn1GMDxzrNhIXAa+9JbX2n+q+8Ao4Iy4g+YjV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j22qsVM4RMbJEuVxHGsUqKQgfL1NX80AAPH4HZ3i6RN2pAY6tLramRtq3SskLPRq/
	 auriauYKzc+N7aylKeJFGdhRt5PRelpXC/v7sY2XGcFRN3s0aBiA0u7V0BHTUrnUgn
	 qgxlUUi+FNx7axDqxaam+wjJsoXT6wcj+Kla4xXoBmMqMi5SQoDtkxj6eExVcTUX+N
	 rQDm5L9BP97yjmCffjl+BSs2aM0sJCXLS9qI7zV+NPhzKt/KdIcw0meSHWkHQ+kdOL
	 dgEmnVSDOU2QE3HeVAVXXgbmSlrBU1AEIiVnohaf0eZi/3HBlurncEnCJnSY5zZWzo
	 AddnYkK8da63Q==
Message-ID: <add760cc-1011-4f12-aa54-7334a2e7245d@kernel.org>
Date: Wed, 27 Nov 2024 21:04:36 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] ata: libahci_platform: support non-consecutive port
 numbers
To: Josua Mayer <josua@solid-run.com>, Niklas Cassel <cassel@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>,
 Rabeeh Khoury <rabeeh@solid-run.com>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241121-ahci-nonconsecutive-ports-v1-1-1a20f52816fb@solid-run.com>
 <e767272d-1cc4-4945-82d1-efd88c724e06@kernel.org>
 <8682b057-fc62-4491-90f9-204736fb88b4@solid-run.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <8682b057-fc62-4491-90f9-204736fb88b4@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 20:52, Josua Mayer wrote:
> Am 25.11.24 um 02:12 schrieb Damien Le Moal:
> 
>> On 11/22/24 12:05 AM, Josua Mayer wrote:
>>> So far ahci_platform relied on number of child nodes in firmware to
>>> allocate arrays and expected port numbers to start from 0 without holes.
>>> This number of ports is then set in private structure for use when
>>> configuring phys and regulators.
>>>
>>> Some platforms may not use every port of an ahci controller.
>>> E.g. SolidRUN CN9130 Clearfog uses only port 1 but not port 0, leading
>>> to the following errors during boot:
>>> [    1.719476] ahci f2540000.sata: invalid port number 1
>>> [    1.724562] ahci f2540000.sata: No port enabled
>>>
>>> Remove from ahci_host_priv the property nports which only makes sense
>>> when enabled ports are consecutive. It is replaced with AHCI_MAX_PORTS
>>> and checks for hpriv->mask_port_map, which indicates each port that is
>>> enabled.
>>>
>>> Update ahci_host_priv properties target_pwrs and phys from dynamically
>>> allocated arrays to statically allocated to size AHCI_MAX_PORTS.
>>>
>>> Update ahci_platform_get_resources to ignore holes in the port numbers
>>> and enable ports defined in firmware by their reg property only.
>>>
>>> When firmware does not define children it is assumed that there is
>>> exactly one port, using index 0.
>>>
>>> I marked this RFC because it was only tested with Linux v6.1, Marvell
>>> fork, CN9130 Clearfog Pro which has only port number 1 in device-tree.
>>> Further I am not completely sure if it has severe side-effects on
>>> other platforms.
>>> I plan to submit it again after testing on v6.13-rc1, but do welcome
>>> feedback in the meantime, particularly whether this idea of supporting
>>> non-consecutive ports is acceptable.
>>>
>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>> [...]
>>
>>
>>> @@ -539,41 +544,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  		hpriv->f_rsts = flags & AHCI_PLATFORM_RST_TRIGGER;
>>>  	}
>>>  
>>> -	/*
>>> -	 * Too many sub-nodes most likely means having something wrong with
>>> -	 * the firmware.
>>> -	 */
>>>  	child_nodes = of_get_child_count(dev->of_node);
>>> -	if (child_nodes > AHCI_MAX_PORTS) {
>>> -		rc = -EINVAL;
>>> -		goto err_out;
>>> -	}
>> Why remove this check ? Your platform may not need ti, but it is still valid
>> for others.
> The check is superfluous, since the following loop will print a warning
> and ignore any child with port number greater than AHCI_MAX_PORTS.
> The check merely protected against dynamically allocating greater than
> AHCI_MAX_PORTS.
>>
>>> -
>>> -	/*
>>> -	 * If no sub-node was found, we still need to set nports to
>>> -	 * one in order to be able to use the
>>> -	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
>>> -	 */
>>> -	if (child_nodes)
>>> -		hpriv->nports = child_nodes;
>>> -	else
>>> -		hpriv->nports = 1;
>> Same here.
> This is already handled in else case of if (child_nodes)
>>
>>> -
>>> -	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
>>> -	if (!hpriv->phys) {
>>> -		rc = -ENOMEM;
>>> -		goto err_out;
>>> -	}
>>> -	/*
>>> -	 * We cannot use devm_ here, since ahci_platform_put_resources() uses
>>> -	 * target_pwrs after devm_ have freed memory
>>> -	 */
>>> -	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
>>> -	if (!hpriv->target_pwrs) {
>>> -		rc = -ENOMEM;
>>> -		goto err_out;
>>> -	}
>> And for platforms that actually have a valid nports with no ID holes, the above
>> is OK and uses less memory...
> The port number is being used as index into the target_pwrs and phys arrays,
> which is why those arrays must allocate at least to the highest port id.
> A better way to save memory is by cleaning out this semantic,
> e.g. by dynamically allocating a structure of id, phy and supply for each port.
>>
>> Why not simply adding code that checks the ID of the child nodes ? If there are
>> no ID holes, then nothing need to change. If there are holes, then
>> hpriv->nports can be set to the highest ID + 1 and you can set
>> hpriv->mask_port_map as you go.
> This would make the already complex function more complex and less readable.
> I prefer to reduce corner cases rather than adding extras.

It would not. Simply implement a helper function that scans the OF IDs and
return a mask of ports and max ID. With that, the modifications of
ahci_platform_get_resources() would be very minimal.

>> With just that, you should get everything
>> working with far less changes than you have here.
>>
>>>  	if (child_nodes) {
>>>  		for_each_child_of_node_scoped(dev->of_node, child) {
>>>  			u32 port;
>>> @@ -587,7 +558,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  				goto err_out;
>>>  			}
>>>  
>>> -			if (port >= hpriv->nports) {
>>> +			if (port >= AHCI_MAX_PORTS) {
>>>  				dev_warn(dev, "invalid port number %d\n", port);
>>>  				continue;
>>>  			}
>>> @@ -625,6 +596,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  		 * If no sub-node was found, keep this for device tree
>>>  		 * compatibility
>>>  		 */
>>> +		hpriv->mask_port_map |= BIT(0);
>>> +
>>>  		rc = ahci_platform_get_phy(hpriv, 0, dev, dev->of_node);
>>>  		if (rc)
>>>  			goto err_out;
>>>
>>> ---
>>> base-commit: adc218676eef25575469234709c2d87185ca223a
>>> change-id: 20241121-ahci-nonconsecutive-ports-a8911b3255a7
>>>
>>> Best regards,
>>


-- 
Damien Le Moal
Western Digital Research
