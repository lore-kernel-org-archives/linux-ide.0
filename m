From: Tony Battersby <tonyb@cybernetics.com>
Subject: Re: AHCI problem with hotplug
Date: Thu, 08 Jan 2009 09:20:15 -0500
Message-ID: <49660B9F.4010408@cybernetics.com>
References: <494178E3.6030305@cybernetics.com> <49588784.4020808@kernel.org> <4958E3DC.7080009@cybernetics.com> <49591710.7040102@shaw.ca> <49596D9E.3040904@kernel.org> <495D8606.5070807@kernel.org> <4964CCBF.5030408@cybernetics.com> <49655FBA.3060005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host64.cybernetics.com ([98.174.209.230]:2977 "EHLO
	mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZAHOUV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2009 09:20:21 -0500
In-Reply-To: <49655FBA.3060005@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello,
>
> Tony Battersby wrote:
>   
>> Sorry it took so long.  I have attached the output of lspci when booting
>> without a SATA disk attached, and also when booting with a SATA disk
>> attached.
>>     
>
> 00:1f.2 SATA controller [0106]: Intel Corporation 82801GR/GH (ICH7 Family) SATA AHCI Controller [8086:27c1] (rev 01) (prog-if 01 [AHCI 1.0])
> ...
> 90: 40 00 11 10 80 01 00 40 00 00 00 00 00 00 00 00
>           ^^^^^
> 	  PCS 0x1011
>
> Port 0 and 4 enabled and 4 present.  Does "setpci -s 1f.2 93b=f" fix
> hotplugging?
>
>   
setpci gives the following error:

pcilib: sysfs_write: tried to write 1 bytes at 2363, but only 0 succeeded

lspci shows no difference before and after.

Tony
