From: shyam_iyer@dell.com
Subject: Re: Re: [PROBLEM + PATCH] Sata port disabled by BIOS gets initialized
Date: Mon, 11 Jun 2007 09:32:32 -0400
Message-ID: <20056641.1181568752111.JavaMail.root@wombat.diezmil.com>
References: <466A3FF7.4090302@gmail.com>
Reply-To: shyam_iyer@dell.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wombat.diezmil.com ([209.190.27.106]:59171 "EHLO
	wombat.diezmil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbXFKNcd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 09:32:33 -0400
Received: from wombat.diezmil.com (wombat.diezmil.com [127.0.0.1])
	by wombat.diezmil.com (8.13.8/8.13.8) with ESMTP id l5BDWWxj018277
	for <linux-ide@vger.kernel.org>; Mon, 11 Jun 2007 09:32:32 -0400
In-Reply-To: <466A3FF7.4090302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>> Problem Sata disks are connected to onboard sata ports of PowerEdge  
>> 1900 (ESB2 southbridge chipset). If one of the port is disabled in  
>> the bios then they get enabled again by the ata_piix driver because  
>> of a default port map being written to the Port control and status  
>> register(0x91-93). Instead the driver should preserve the bios  
>> setting by way of a fix like this.  
 
>What happens if the port is enabled by the kernel?  
The BIOS tests for the device will not be performed for the port since it is disabled by the BIOS, and there is a potential security problem here if they get reenabled in the kernel.

If the user decides to disable the port through the BIOS, the driver needs to respect the user's wish to not use the port and carry on. Here the end result is a forceful reinitialization of the port by the driver against the user's wishes.
 
>> Fix: The BIOS configured PCS value must be anded logically with the  
>> default port map for the chipset. This way the BIOS information will  
>> not be lost by the reinitialization of the config space by the  
>> ata_piix driver. The below patch is against 2.6.21 kernel.  
 
>I'm not sure whether this is a good idea and it has potential to break a  
>lot of other configurations.  That part of code is used for *all*  
>ata_piix out there, so we need a really really good reason to change  
>that.  So, please explain what you're trying to fix better.  
If the fix has a potential to break other things then there could be a module parameter that would let the driver accept the bios configuration for the pcs register and not modify the config space through the driver.
 
--
Shyam

--
This message was sent on behalf of shyam_iyer@dell.com at openSubscriber.com
http://www.opensubscriber.com/message/linux-ide@vger.kernel.org/6886790.html
