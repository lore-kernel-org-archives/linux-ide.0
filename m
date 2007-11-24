From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] ahci: update PCS programming
Date: Fri, 23 Nov 2007 19:57:01 -0500
Message-ID: <474776DD.4090201@garzik.org>
References: <20071119070344.GD30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34657 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbXKXA5D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:57:03 -0500
In-Reply-To: <20071119070344.GD30919@htj.mynetwork.cxm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> For intel ones, ahci unconditionally OR'd 0xf to PCS.  This isn't
> correct for the following cases.
> 
> * ich6/7m's which only implement P0 and P2 (0xf works fine tho)
> 
> * ich8/9's which have six ports and needs 0x3f to enable all ports
> 
> This patch updates PCS programming such that...
> 
> * port_map determined by ahci_save_initial_config() is OR'd instead of 0xf
> 
> * PCS is updated only if necessary (there are turned off enable bits)
> 
> port_map is determined from PORTS_IMPL PCI register which is
> implemented as write or write-once register.  If the register isn't
> programmed, ahci automatically generates it from number of ports,
> which is good enough for PCS programming.  ICH6/7M are probably the
> only ones where non-contiguous enable bits are necessary && PORTS_IMPL
> isn't programmed properly but they're proven to work reliably with 0xf
> anyway.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> As there hasn't been any report of brokeness due to this, I think this
> change can wait and get tested till the next merge cycle.  The reason
> why this doesn't really break anything (yet) is that BIOS programs PCS
> correctly during boot and the value is preserved over suspend-to-ram,
> which is interesting considering the default value for PCS is zero.
> Maybe SMM code reprograms it while resuming?
> 
>  drivers/ata/ahci.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

applied


