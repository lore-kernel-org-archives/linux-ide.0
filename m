From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Subject: Re: Sil3114 and Hitachi disks
Date: Mon, 27 Dec 2004 14:23:56 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0412271405410.31364@dingo.iwr.uni-heidelberg.de>
References: <Pine.LNX.4.44.0412241621210.16199-100000@kenzo.iwr.uni-heidelberg.de>
 <Pine.LNX.4.44.0412241822560.16199-100000@kenzo.iwr.uni-heidelberg.de>
 <20041225044658.GB25088@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.uni-heidelberg.de ([129.206.100.212]:50420 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261893AbUL0NYE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Dec 2004 08:24:04 -0500
In-Reply-To: <20041225044658.GB25088@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


On Fri, 24 Dec 2004, Jeff Garzik wrote:

> > The Sil3114 appears on the PCI bus as a 32-bit 66MHz device, therefore
> > it should use IOMMU with >4Gb RAM. Booting the x86_64 kernel with
> > "mem=2048m" makes the corruption go away; the difference is that the
> > IOMMU is automatically disabled by the kernel:
> 
> Does 2.4.29-pre3 or 2.6.10 work for you?

Due to the userland not being able to cope easily with any of these
(2.4 due to NPTL and 2.6 due to modutils), I installed the x86_64
Fedora Core 3. It seems that its kernel works fine. I've tried both
the original (2.6.9-1.667) and the latest update (2.6.9-1.681_FC3) and
they both behaved well. I haven't made any modification to BIOS
settings or hardware in the mean time.

Do you want me to still try the vanilla kernels that you asked about ?

I would like to get the RHEL3 kernels to behave. Both libata and
sata_sil seem to be the same version in the RHEL3 and FC3 kernels, so
I gather this would be more of a IOMMU problem than a SATA problem. Am
I interpreting things correctly ? If so, I'll file a report in Red
Hat's buzgilla.

--
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
