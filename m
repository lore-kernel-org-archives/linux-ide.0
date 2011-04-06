From: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
Date: Wed, 6 Apr 2011 12:48:27 -0500
Message-ID: <C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from slb-smtpout-01.boeing.com ([130.76.64.48]:53758 "EHLO
	slb-smtpout-01.boeing.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756405Ab1DFSnA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Apr 2011 14:43:00 -0400
In-Reply-To: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>

On Apr 06, 2011, at 13:00, Leon Woestenberg wrote:
> after investigating problems with sata_sil24.c on a freescale p2020
> soc, I wonder if this driver works on powerpc at all?
> 
> Does anyone know of a working setup of sata_sil24 on a big endian
> powerpc system?

Our P2020 boards work fine with legacy PCI interrupts (I think it's a sil3124 over PCI-E); the only deficiency is that MSI does not seem to work.

I know our MSI *does* work in general because we have an Intel 82571EB chipset also attached via PCI-E with working MSI.

Cheers,
Kyle Moffett


