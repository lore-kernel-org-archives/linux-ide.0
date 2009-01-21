From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] sata_nv: sgpio for nvidia mcp55 -v2
Date: Wed, 21 Jan 2009 10:48:27 -0800
Message-ID: <49776DFB.8090506@kernel.org>
References: <20061031104055.GA8898@infradead.org>	 <15F501D1A78BD343BE8F4D8DB854566B0C8DDCF5@hkemmail01.nvidia.com>	 <86802c440711062009t7e98d27fqdfb466b9843da060@mail.gmail.com> <86802c440901180120u3e60e73dm53a37b7cd9034915@mail.gmail.com> <4972F4E5.3030203@kernel.org> <49768355.4040301@kernel.org> <49773189.6050009@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39948 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbZAUStB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jan 2009 13:49:01 -0500
In-Reply-To: <49773189.6050009@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: Peer Chen <pchen@nvidia.com>, linux-ide@vger.kernel.org

Yan Seiner wrote:
> Yinghai Lu wrote:
>> Impact: new features
>>
>> based on patch on
>>     http://marc.info/?l=linux-ide&m=116289338705418&w=2
>>
>> 1. update the patch for 2.6.19 to latest upstream ( 2.6.28?)
>> 2. fix shared sgpio to support several mcp55 + io55, so every mcp55 have
>>    seperate spinlock
>> 3. use scratch_source as numbering of sgpio instead of address of struct,
>>    so could go through kexec/kdump
>>
>> v2: revert NV_ON and NV_OFF, so turn on Activity LED all the time when
>> disk is idle.
>>   
> I've tried both this patch and the previous version; neither does
> anything for me.  I am patching a vanilla 2.6.28.1 kernel.  :-(
> 
> I am running an Asus M2N-SLI Deluxe:
> 
> 00:04.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1)
> 00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
> 00:05.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
> 00:05.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
> 
> All 6 channels are in use.  All of the drive activity lights are lit all
> the time.

can you boot with "debug" in command line?

wonder if your system has SGPIO etc backplane.

YH
