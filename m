From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: 65fe1f0 (ahci: implement aggressive SATA...) fail to boot
Date: Mon, 22 Oct 2012 04:52:26 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E107EAB746@SCYBEXDAG03.amd.com>
References: <20121021175717.GA3543@bill-the-cat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:30286 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750828Ab2JVEwh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2012 00:52:37 -0400
In-Reply-To: <20121021175717.GA3543@bill-the-cat>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Rini <tom.rini@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Aaron Lu <aaron.lwe@gmail.com>, Jeff Garzik <jgarzik@redhat.com>, "Huang, Shane" <Shane.Huang@amd.com>

Tom,

> I've got an Asus motherboard with:
> 00:11.0 SATA controller: Advanced Micro Devices [AMD] nee ATI
> SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
> ...
> 02:00.0 SCSI storage controller: OCZ Technology Group, Inc. RevoDrive 3
> X2 PCI-Express SSD 240 GB (Marvell Controller) (rev 02)
> 
> And with 65fe1f0 merged I no longer see all devices on the RevoDrive.
> Happy to provide whatever further information might be helpful.

Can you give me the motherboard name and dmesg?

Thanks
Shane

