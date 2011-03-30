From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA_ARTOP reads byte from PCI IO port without mapping it to
 the right address.
Date: Wed, 30 Mar 2011 20:26:28 +0100
Message-ID: <20110330202628.5dc8db5f@lxorguk.ukuu.org.uk>
References: <4D937FDC.4090607@danielpalmer.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44859 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932783Ab1C3TZ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Mar 2011 15:25:56 -0400
In-Reply-To: <4D937FDC.4090607@danielpalmer.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Palmer <me@danielpalmer.co.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> unsigned long io = pci_resource_start(pdev, 4);           // This 
> returns 0x1400 on my machine

That is the PCI port address.

>                  u8 reg;
> 
>                  ppi[0] = &info_628x;
>                  if (inb(io) & 0x10)                                    
>          // This reads from 0x1400, which isn't were the port actually 
> is in the processors address                                             

This reads from I/O port 0x1400 - your inb logic and I/O port mapping on
the platform is responsible for making that work.



