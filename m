From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Subject: Re: Sil3114 and Hitachi disks
Date: Mon, 27 Dec 2004 15:22:31 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0412271513420.31364@dingo.iwr.uni-heidelberg.de>
References: <Pine.LNX.4.44.0412241621210.16199-100000@kenzo.iwr.uni-heidelberg.de>
 <Pine.LNX.4.44.0412241822560.16199-100000@kenzo.iwr.uni-heidelberg.de>
 <20041225044658.GB25088@havoc.gtf.org> <Pine.LNX.4.58.0412271405410.31364@dingo.iwr.uni-heidelberg.de>
 <20041227133150.GA18020@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.uni-heidelberg.de ([129.206.100.212]:13731 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261451AbUL0OWh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Dec 2004 09:22:37 -0500
In-Reply-To: <20041227133150.GA18020@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Mon, 27 Dec 2004, Jeff Garzik wrote:

> RHEL3 is a bit behind the times.

That's not always a bad thing ;-)

> In particular it needs one hotfix for all swiotlb platforms
> (includes Intel's EM64T).  The next update will have it, but the
> current one does not.

Is there some patch that I can test ? I tried to comb through Red
Hat's Bugzilla, but I didn't find anything related.
Does this fix exist in vanilla 2.4.29-pre3 ?

> Lack-of-an-IOMMU problem actually :)

The hardware is AMD Opteron with an AMD chipset, so IOMMU should
exist. It might be that for some reason is not working properly, I
already found some bug reports about the Tyan boards' BIOS, but this
is the latest BIOS version (beta actually 2.03I, the stable 2.03
behaved the same). I have again tried to activate IOMMU in BIOS and
gave it 64Mb, but even the FC3 kernels are misdetecting it:

Checking aperture...
CPU 0: aperture @ 1ee0000000 size 64 MB
Aperture from northbridge cpu 0 beyond 4GB. Ignoring.
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
...
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture

But this is no longer SATA related, so I'll stop this thread here.

--
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
