From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Subject: Re: Sil3114 and Hitachi disks
Date: Fri, 24 Dec 2004 18:49:42 +0100 (CET)
Message-ID: <Pine.LNX.4.44.0412241822560.16199-100000@kenzo.iwr.uni-heidelberg.de>
References: <Pine.LNX.4.44.0412241621210.16199-100000@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.uni-heidelberg.de ([129.206.100.212]:43908 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261404AbULXRtp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Dec 2004 12:49:45 -0500
Received: from mail.iwr.uni-heidelberg.de (mail.iwr.uni-heidelberg.de [129.206.104.30])
	by relay.uni-heidelberg.de (8.12.10/8.12.10) with ESMTP id iBOHo7fK008960
	for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2004 18:50:07 +0100 (MET)
Received: from kenzo.iwr.uni-heidelberg.de (IDENT:Bdu8udlg4Si0aKf5W+o0GD8cRzTPrsj7@kenzo.iwr.uni-heidelberg.de [129.206.120.29])
	by mail.iwr.uni-heidelberg.de (8.12.11/8.12.11) with ESMTP id iBOHngFM026218
	for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2004 18:49:42 +0100 (MET)
Received: from kenzo.iwr.uni-heidelberg.de (localhost.localdomain [127.0.0.1])
	by kenzo.iwr.uni-heidelberg.de (8.12.11/8.12.11) with ESMTP id iBOHng1s017097
	for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2004 18:49:42 +0100
Received: from localhost (bogdan@localhost)
	by kenzo.iwr.uni-heidelberg.de (8.12.11/8.12.11/Submit) with ESMTP id iBOHngjR017093
	for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2004 18:49:42 +0100
In-Reply-To: <Pine.LNX.4.44.0412241621210.16199-100000@kenzo.iwr.uni-heidelberg.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Fri, 24 Dec 2004, Bogdan Costescu wrote:

> - the combination of x86_64 kernel, sata_sil and the Hitachi disks is
> not good; the corruption seems to appear while writting to disk.  

I've gotten some more inspiration just after I sent the message...

The Sil3114 appears on the PCI bus as a 32-bit 66MHz device, therefore
it should use IOMMU with >4Gb RAM. Booting the x86_64 kernel with
"mem=2048m" makes the corruption go away; the difference is that the
IOMMU is automatically disabled by the kernel:

PCI-DMA: Disabling IOMMU.

With 8Gb, there is an error related to IOMMU:

Checking aperture...
CPU 0: aperture @ 1ee0000000 size 32768 KB
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
Mapping aperture over 65536 KB of RAM @ 8000000

The IOMMU was indeed disabled in BIOS. I enabled it and gave the
aperture several sizes, but the IOMMU message from the kernel is the
same. Checking back logs backups, I have always obtained this message
related to IOMMU, while the non-lba48 Maxtor disk worked fine for
several months and still works.

So, is there any link between IOMMU and lba48 ?

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

