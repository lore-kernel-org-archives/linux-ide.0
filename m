From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Wed, 23 Apr 2008 15:37:02 +0900
Message-ID: <480ED90E.1080300@gmail.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange> <39B20DF628532344BC7A2692CB6AEE0702679018@orsmsx420.amr.corp.intel.com> <47D03272.9080209@garzik.org> <39B20DF628532344BC7A2692CB6AEE070283295C@orsmsx420.amr.corp.intel.com> <47F42862.1030406@gmail.com> <39B20DF628532344BC7A2692CB6AEE0702832B5B@orsmsx420.amr.corp.intel.com> <47F4FFBE.8050800@gmail.com> <39B20DF628532344BC7A2692CB6AEE070294E62F@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.153]:22931 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbYDWGhJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 02:37:09 -0400
Received: by po-out-1718.google.com with SMTP id y22so168241pof.1
        for <linux-ide@vger.kernel.org>; Tue, 22 Apr 2008 23:37:09 -0700 (PDT)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE070294E62F@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Gaston, Jason D wrote:
>>> IDER is a controller, in this case, in the MCH/Northbridge that
>>> redirects a virtual drive across the LAN and presents it as 
>> a local IDE
>>> drive.  This is part of the Intel AMT manageability engine.  You can
>>> point it to a physical drive, .iso or a .img file on the 
>> remote system.
>>
>> Ah... fancy.  You can just make it PATA if doesn't have SCR access and 
>> supports slave device and use ata_cable_unknown() for ->cbl_detect.
>>
>> -- 
>> tejun
>>
> 
> After messing around for a bit, what I came up with that worked, was
> very similar to what it set for ich8_sata_ahci.  So, I tried just adding
> the new DeviceID as an ich8_sata_ahci and it seems to work fine.  Do you
> see anything wrong with just doing this?  I'm not sure that the port map
> is relevant for a virtual device?  I have attached the dmesg output for
> your review.

Things look fine to me but I think it's probably best to create a 
separate port info entry for it.  Is SIDPR available for IDER too?

-- 
tejun
