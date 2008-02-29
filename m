From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: Unknown SATA PIIX PCI device ID 0x29b6
Date: Thu, 28 Feb 2008 19:50:07 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE070263AABB@orsmsx420.amr.corp.intel.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <47C75069.5010006@ij.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64006 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbYB2EAc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 23:00:32 -0500
Content-class: urn:content-classes:message
In-Reply-To: <47C75069.5010006@ij.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Miata <mrmazda@ij.net>, linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

>> is the device in AHCI mode or PIIX mode ?
>
>How does one tell for sure? BIOS typically only say things 
>like "compatible"
>or "enhanced".

29b6 is the IDER, IDE Redirection, network device.  There there will not
be anything "locally" attached to that network device.  I have not been
adding the IDER Management devices to the ata_piix driver, perhaps I
should?   

When in doubt, about an unknown device, check the latest pci.ids file on
http://pciids.sf.net.  We try to keep it up to date.

Thanks,

Jason

