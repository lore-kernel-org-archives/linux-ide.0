From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA status report updated
Date: Mon, 15 May 2006 14:17:16 -0400
Message-ID: <4468C5AC.5020103@garzik.org>
References: <44689C39.70902@garzik.org> <Pine.LNX.4.64.0605151901060.25784@mercury.sdinet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31940 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965038AbWEOSRT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 14:17:19 -0400
In-Reply-To: <Pine.LNX.4.64.0605151901060.25784@mercury.sdinet.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sven-Haegar Koch <haegar@sdinet.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Sven-Haegar Koch wrote:
> On Mon, 15 May 2006, Jeff Garzik wrote:
> 
>> I've updated the http://linux-ata.org/ status pages with the recent 
>> work by Tejun Heo and others.
> 
> Thanks for your list, but I'm missing the SATA chipset that our 
> Asus-Boxes got:
> 
> 0000:00:14.1 IDE interface: ATI Technologies Inc ATI Dual Channel Bus 
> Master PCI IDE Controller
> (PCI-ID 1002:4349)
> 
> Or is this something different like an IDE chipset with included SATA 
> bridges or so?
> 
> It is supported through the atiixp ide driver, but only really slow 
> (10mb/s) - the same disks attached to an Intel SATA port give 30-40mb/s.

Should be ahci or sata_sil driver?

	Jeff



