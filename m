From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Thu, 03 Apr 2008 12:04:17 -0400
Message-ID: <47F50001.50204@garzik.org>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange> <39B20DF628532344BC7A2692CB6AEE0702679018@orsmsx420.amr.corp.intel.com> <47D03272.9080209@garzik.org> <39B20DF628532344BC7A2692CB6AEE070283295C@orsmsx420.amr.corp.intel.com> <47F42862.1030406@gmail.com> <39B20DF628532344BC7A2692CB6AEE0702832B5B@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37958 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756237AbYDCQEU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Apr 2008 12:04:20 -0400
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0702832B5B@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Gaston, Jason D wrote:
> IDER is a controller, in this case, in the MCH/Northbridge that
> redirects a virtual drive across the LAN and presents it as a local IDE
> drive.  This is part of the Intel AMT managability engine.  You can
> point it to a physical drive, .iso or a .img file on the remote system.


Since this is a new, non-PATA, non-SATA controller/device setup, there 
are a few general questions,

- what to do about cable detection?  unless it matters, we could simply 
assume a fixed cable type, since its a virtual link.

- what is the proper reset method?  to kick a device (and controller) 
into action, we will COMRESET via the SATA phy, or at the very least SRST.

- is set-xfer-mode properly emulated?  normally we look at the ATA 
device's IDENTIFY DEVICE page, and choose a transfer xfer from that info.

	Jeff



