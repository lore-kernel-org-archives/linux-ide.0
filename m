From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] fix issues with loading PCI ide drivers as modules (linux 2.6.0)
Date: Sun, 4 Jan 2004 02:56:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200401040256.57419.bzolnier@elka.pw.edu.pl>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
Content-Disposition: inline
To: Davin McCall <davmac@ozonline.com.au>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Saturday 03 of January 2004 05:28, Davin McCall wrote:
> Hi,

Hi,

> When loading the piix.ko module (generic IDE support is compiled in) I get
> error messages- the ports are already in use, the block devices are already
> registered.
>
> The problems seem to be:
>
> 1) the hwif structures aren't getting marked as being used if the generic
> IDE layer is controlling them (->chipset is left as "ide_unknown" instead
> of "ide_generic")

Are you aware that your change brakes "idex=base", "idex=base,ctl"
and "idex=base,ctl,irq" kernel parameters?  If these parameters are used
hwif->chipset is also set to ide_generic.  Now if controller is a PCI one
and PCI IDE support is compiled in hwif->chipset will be set to
ide_pci_takeover and drives won't be probed.

> 2) if the pci module is granted control of an already initialized hwif, the
> drive probing etc. (including I/O port allocation) is re-run. When it
> fails, the drives are marked as not-present which doesn't appear to cause
> any problems but seems dangerous.

When it fails controller+drives are not being programmed correctly
(because probe_hwif() returns early).  "takeover" is not supported because
you need to reprogram controller/drive to do DMA, but probing code
(which does also reprogramming) can race with actual data transfer.

> Patch below fixes this and allows a chipset-specific module to take over
> the primary IDE interface correctly. Comments welcome.

I think proper fix is to add IDE generic host driver and make it modular.

--bart
