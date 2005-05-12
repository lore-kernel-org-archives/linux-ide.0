From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: non-PCI libata
Date: Thu, 12 May 2005 17:23:21 -0400
Message-ID: <4283C949.3050503@pobox.com>
References: <FC3C0DD86B79DF4FA423AF0379A54761029DD0EA@mailguy2.nuvation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:43984 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262131AbVELVXb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 May 2005 17:23:31 -0400
In-Reply-To: <FC3C0DD86B79DF4FA423AF0379A54761029DD0EA@mailguy2.nuvation.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Istead <jistead@nuvation.com>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Joe Istead wrote:
> Hello,
> 
> I have a question related to an LKML post on April 5, 2005:
> 
> http://lkml.org/lkml/2005/4/5/210
> 
> Preamble:
> I'm developing a low level driver for a non-PCI AHCI controller.  In
> particular, I'm using uClinux (2.6.x kernel) on a Nios II processor (Avalon
> bus, etc etc).  
> 
> It looks like porting "drivers/scsi/ahci.c" to uClinux is the easiest way to
> do this.  However, ahci.c depends on libata, and both of these are littered
> with PCI-specific calls.
> 
> Question:
> Is there a non-PCI libata (or, are there plans to make one)?

libata already supports non-PCI.  Another engineer is already using 
libata on his embedded non-PCI hardware.

You'll just have to modify AHCI to support non-PCI.

	Jeff


