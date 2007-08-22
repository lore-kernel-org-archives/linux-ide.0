From: Jeff Garzik <jeff@garzik.org>
Subject: Re: no need to add new DID's to AHCI driver?
Date: Wed, 22 Aug 2007 15:19:13 -0400
Message-ID: <46CC8C31.3040502@garzik.org>
References: <39B20DF628532344BC7A2692CB6AEE0701AE8117@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39444 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761484AbXHVTTP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Aug 2007 15:19:15 -0400
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0701AE8117@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Gaston, Jason D wrote:
> Hello,
> 
> Now that the AHCI driver has support for all controllers with the 0x0106
> (AHCI) class code, I am not planning on adding controller DeviceID's for
> AHCI controllers.  I want to verify that this is the correct course of
> action.
> 
> Note:  I still will have to add the Intel SW "RAID" controller
> DeviceID's as they have a 0x0104 (RAID) class code.

Yep, that's fine -- and the encouraged direction.

The ideal situation for users is when new hardware is "automagically" 
supported, without needing any driver PCI ID modifications at all.

	Jeff



