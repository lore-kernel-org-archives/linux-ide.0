From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SAS v SATA interface performance
Date: Fri, 30 Nov 2007 23:17:05 +0000
Message-ID: <20071130231705.51e056f4@the-village.bc.nu>
References: <47506237.3000406@clear.net.nz>
	<47507F9A.3080109@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37166 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755212AbXK3XWT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 18:22:19 -0500
In-Reply-To: <47507F9A.3080109@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org

> First of all, I've yet to see a controller that is really able
> to handle multiple requests in parallel.  Usually, multiple
> I/O threads gets exactly the same summary performance as a
> single thread - UNLIKE of linux software raid which clearly

Thats usually true of hardware raid cards as they lack enough CPU power
and they are on a single PCI slot. With PCIE and things like AHCI where
the host is doing the hard work and the controller engine is doing the
NCQ low level work and channel work you've got a much better chance.

> They says that modern SATA drives has NCQ, which is "more
> advanced" than ol'good TCQ used in SCSI (and SAS) drives.
> I've no idea what's "advanced" in it, except of that it
> just does not work.  There's almost no difference with
> NCQ turned on or off, and in many cases turning NCQ ON
> actually REDUCES performance.

NCQ is straight 32 way tagged queueing. On some workloads it makes a big
difference but its dependent on controller and drive firmware.

The big big constraint on a modern drive is still ops/second. Its
mechanical and the mechanical behaviour is limited by the laws of physics
and hasn't much changed in years

If you want really high performance use multiple drives, on multiple PCIE
controllers. Just make sure your backup planning of raid 1+0 setup is
done right as many drives means a lot more drive fails.
