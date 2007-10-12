From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 05/25] ata: add the SW NCQ support to sata_nv for MCP51/MCP55/MCP61
Date: Fri, 12 Oct 2007 17:15:46 -0400
Message-ID: <470FE402.8080105@garzik.org>
References: <200708102059.l7AKxYVQ008581@imap1.linux-foundation.org> <46F2F6E5.3010406@garzik.org> <46F35C7F.20400@dunaweb.hu> <46F9D6A8.8010809@garzik.org> <46F9EFC9.9030209@dunaweb.hu> <46F9F05F.40905@garzik.org> <46F9F223.4000406@dunaweb.hu> <15F501D1A78BD343BE8F4D8DB854566B059FE1AB@hkemmail01.nvidia.com> <46FB4B75.9030407@garzik.org> <15F501D1A78BD343BE8F4D8DB854566B059FE1AC@hkemmail01.nvidia.com> <46FB577D.6000006@garzik.org> <15F501D1A78BD343BE8F4D8DB854566B059FE1AE@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33043 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755032AbXJLVPy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Oct 2007 17:15:54 -0400
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B059FE1AE@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: Zoltan Boszormenyi <zboszor@dunaweb.hu>, akpm@linux-foundation.org, Peer Chen <pchen@nvidia.com>, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

Kuan Luo wrote:
> One idea,  only simply adding 
> 	if (!swncq_enabled) 
> 		nv_port_info[SWNCQ].flags &= ~ATA_FLAG_NCQ;
> 	
> 	ppi[0] = &nv_port_info[type];
> 	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
> 
> I don't know if this is appropriate


As long as the structure is not read-only ('const'), that is OK.

And just for future reference, make sure you're aware of the 
implications of this applying to all sata_nv-aware PCI IDs.  If you 
present multiple SATA devices on a PCI bus, or have multiple PCI cards 
(rare in NV's case, I guess) the probe function will be called multiple 
times.  You might even want to put that code into the module init 
function, rather than the probe function.

	Jeff


