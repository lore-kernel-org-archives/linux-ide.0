From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: AHCI problem with hotplug
Date: Wed, 14 Jan 2009 22:42:00 -0600
Message-ID: <496EBE98.4040103@shaw.ca>
References: <494178E3.6030305@cybernetics.com> <49588784.4020808@kernel.org> <4958E3DC.7080009@cybernetics.com> <49591710.7040102@shaw.ca> <49596D9E.3040904@kernel.org> <495D8606.5070807@kernel.org> <4964CCBF.5030408@cybernetics.com> <49655FBA.3060005@kernel.org> <49660B9F.4010408@cybernetics.com> <496696B2.7010006@shaw.ca> <49677B8D.7060807@cybernetics.com> <496D8735.4030005@kernel.org> <496E5B6C.2020602@cybernetics.com> <496E91E9.4050403@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:63232 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694AbZAOEmE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 23:42:04 -0500
In-Reply-To: <496E91E9.4050403@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Tony Battersby <tonyb@cybernetics.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello,
> 
> Tony Battersby wrote:
>> No luck.  After "setpci -s 1f.2 92.b=7f" with the disk unplugged, lspci
>> shows register 0x92 = 0x0f.  After plugging in the disk, this changes to
>> 0x92 = 0x1f, but still no interrupt, and still no hotplug event.
> 
> Aieee... I've run out of ideas then.  :-(
> 

Tried reloading the ahci module after making that change? Maybe it needs 
an AHCI reset before it takes effect or something..
