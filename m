From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Unable to complete boot with pata_sis
Date: Wed, 30 Jul 2014 15:57:35 +0100
Message-ID: <20140730155735.20b6d12c@alan.etchedpixels.co.uk>
References: <CAN_we7P6RF_OnBivLYqnpeftJH64st3msX-dJROetz1UxpDLjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:38915 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbaG3O6L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2014 10:58:11 -0400
In-Reply-To: <CAN_we7P6RF_OnBivLYqnpeftJH64st3msX-dJROetz1UxpDLjw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniele Forsi <dforsi@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, 26 Jul 2014 09:45:22 +0200
Daniele Forsi <dforsi@gmail.com> wrote:

> Hello,
> 
> I have a computer with an integrated SiS 5513 IDE Controller that can
> read GRUB, the kernel and initrd from disk but then is not able to
> finish booting; this is the first error
> 
> [   36.883578] ata1: lost interrupt (Status 0x58)
> [   36.930523] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [   36.937694] ata1.00: failed command: READ DMA
> [   36.942177] ata1.00: cmd c8/00:f0:20:b0:5e/00:00:00:00:00/e0 tag 0
> dma 122880 in
> [   36.942177]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [   36.957097] ata1.00: status: { DRDY }
> [   36.960983] ata1: soft resetting link
> [   37.143899] ata1.00: configured for UDMA/33
> [   37.148216] ata1.00: device reported invalid CHS sector 0
> [   37.153753] ata1: EH complete
> 
> full boot log with kernel 3.16.0-rc6+ is attached.

I've had a couple of other reports like this from ages ago and never got
to the bottom of it (in both cases because the reporter decided it was
far simpler to find a PCI controller instead)

Somewhere there is a subtle behavioural difference between pata_sis and
the ancient sis5513 driver. About the only way to find it would be to
boot both the old and new kernels and log every single access to the disk
controller to the point of failure (or some short way into booting) in
both cases somewhere (eg over the network) then compare them.

Alan
