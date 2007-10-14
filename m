From: "Kuan Luo" <kluo@nvidia.com>
Subject: RE: [patch 05/25] ata: add the SW NCQ support to sata_nv for MCP51/MCP55/MCP61
Date: Sun, 14 Oct 2007 20:29:50 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B059FE1C5@hkemmail01.nvidia.com>
References: <200708102059.l7AKxYVQ008581@imap1.linux-foundation.org> <46F2F6E5.3010406@garzik.org> <46F35C7F.20400@dunaweb.hu> <46F9D6A8.8010809@garzik.org> <46F9EFC9.9030209@dunaweb.hu> <46F9F05F.40905@garzik.org> <46F9F223.4000406@dunaweb.hu> <15F501D1A78BD343BE8F4D8DB854566B059FE1AB@hkemmail01.nvidia.com> <46FB4B75.9030407@garzik.org> <15F501D1A78BD343BE8F4D8DB854566B059FE1AC@hkemmail01.nvidia.com> <46FB577D.6000006@garzik.org> <15F501D1A78BD343BE8F4D8DB854566B059FE1AE@hkemmail01.nvidia.com> <470FE402.8080105@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.145]:3510 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbXJNMaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Oct 2007 08:30:03 -0400
In-Reply-To: <470FE402.8080105@garzik.org>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Zoltan Boszormenyi <zboszor@dunaweb.hu>, akpm@linux-foundation.org, Peer Chen <pchen@nvidia.com>, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

Jeff wrote:
> Kuan Luo wrote:
> > One idea,  only simply adding 
> > 	if (!swncq_enabled) 
> > 		nv_port_info[SWNCQ].flags &= ~ATA_FLAG_NCQ;
> > 	
> > 	ppi[0] = &nv_port_info[type];
> > 	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
> > 
> > I don't know if this is appropriate
> 
> 
> As long as the structure is not read-only ('const'), that is OK.
> 
> And just for future reference, make sure you're aware of the 
> implications of this applying to all sata_nv-aware PCI IDs.  If you 
> present multiple SATA devices on a PCI bus, or have multiple 
> PCI cards 
> (rare in NV's case, I guess) the probe function will be 
> called multiple 
> times.  You might even want to put that code into the module init 
> function, rather than the probe function.
> 
> 	Jeff
> 
> 
My idea is not comprehensive.
Your analysis are reasonable.
Then you may apply either method in previous mail.

Jeff wrote
>	if (type == SWNCQ && !swncq_enabled)
>		type = GENERIC;
>
>Or, if you prefer, we could take the opposite route, _not_ set SWNCQ in

>the pci_device_id table, and instead do something like
>
>	if (type >= MCP65 && swncq_enabled)
>		type = SWNCQ;
>
>(MCP65 is just a pulled-out-of-thin-air example)
>
>Regards,
>
>	Jeff
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
