From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: Unknown SATA PIIX PCI device ID 0x29b6
Date: Thu, 3 Apr 2008 11:01:31 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0702832D5D@orsmsx420.amr.corp.intel.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange> <39B20DF628532344BC7A2692CB6AEE0702679018@orsmsx420.amr.corp.intel.com> <47D03272.9080209@garzik.org> <39B20DF628532344BC7A2692CB6AEE070283295C@orsmsx420.amr.corp.intel.com> <47F42862.1030406@gmail.com> <39B20DF628532344BC7A2692CB6AEE0702832B5B@orsmsx420.amr.corp.intel.com> <47F50001.50204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15224 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754663AbYDCSLj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2008 14:11:39 -0400
Content-class: urn:content-classes:message
In-Reply-To: <47F50001.50204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

>Gaston, Jason D wrote:
>> IDER is a controller, in this case, in the MCH/Northbridge that
>> redirects a virtual drive across the LAN and presents it as 
>a local IDE
>> drive.  This is part of the Intel AMT managability engine.  You can
>> point it to a physical drive, .iso or a .img file on the 
>remote system.
>
>
>Since this is a new, non-PATA, non-SATA controller/device setup, there 
>are a few general questions,
>
>- what to do about cable detection?  unless it matters, we 
>could simply 
>assume a fixed cable type, since its a virtual link.
>
>- what is the proper reset method?  to kick a device (and controller) 
>into action, we will COMRESET via the SATA phy, or at the very 
>least SRST.
>
>- is set-xfer-mode properly emulated?  normally we look at the ATA 
>device's IDENTIFY DEVICE page, and choose a transfer xfer from 
>that info.
>
>	Jeff

The datasheet for the Intel(3) 3 Series Chipset Family is up on
intel.com.  
Here is a direct link:
http://download.intel.com/design/chipsets/datashts/31696602.pdf  
It looks like section 9.3 has the details for the IDER.  This is
somewhat over my head, can you help me with this?

Thanks,

Jason
