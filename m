From: Ming Zhang <mingz@ele.uri.edu>
Subject: Re: hotplug works, but newly plug not
Date: Thu, 25 May 2006 12:15:51 -0400
Message-ID: <1148573752.2956.75.camel@localhost.localdomain>
References: <1148484316.26093.72.camel@localhost.localdomain>
	 <4474C737.9000600@gmail.com>
	 <1148504987.26093.177.camel@localhost.localdomain>
	 <1148569743.2956.51.camel@localhost.localdomain> <4475C9D6.70904@pobox.com>
Reply-To: mingz@ele.uri.edu
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orca.ele.uri.edu ([131.128.51.63]:8391 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S1030249AbWEYQaW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 May 2006 12:30:22 -0400
In-Reply-To: <4475C9D6.70904@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide-list <linux-ide@vger.kernel.org>

also I downloaded Intel ICH7 Data sheet which contains all pci
configuration registers defines. thx for pointing out this.

also i saw that ahci_host_init() will set low 4 bits to 0xF anyway for
intel chip, and high 4 bits are RO. so the patch set 0xf or 0xFF make no
sense here.

so what can i do now? thx!


Ming



On Thu, 2006-05-25 at 11:14 -0400, Jeff Garzik wrote:
> Ming Zhang wrote:
> > I read the whole AHCI but I still could not find out what is the magic
> > number 0x92. Is this in some Intel doc?
> 
> AHCI spec only documents generic PCI config registers.  Each vendor has 
> their own vendor-specific registers.  Intel's are documented publicly on 
> the developer website.
> 
> 	Jeff
> 
> 
> 

