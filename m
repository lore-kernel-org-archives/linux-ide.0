From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_promise: SATA hotplug support, take 2
Date: Tue, 10 Jul 2007 21:14:42 -0400
Message-ID: <46942F02.2020204@garzik.org>
References: <200707022309.l62N9597007667@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37437 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759653AbXGKBOr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:14:47 -0400
In-Reply-To: <200707022309.l62N9597007667@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch enables hotplugging of SATA devices in the
> sata_promise driver. It's been tested successfully on
> both first- and second-generation Promise SATA chips:
> SATA150 TX2plus, SATAII150 TX2plus, SATAII150 TX4,
> SATA300 TX2plus, and SATA300 TX4.
> 
> The only quirk I've seen is that hotplugging (insertion)
> on the first-generation SATA150 TX2plus requires a lengthier
> EH sequence than on the second-generation chips.
> On the second-generation chips a simple soft reset seems
> to suffice, but on the first-generation chip there's a
> "port is slow to respond" after the initial soft reset,
> after which libata issues a hard reset, and then the
> device is recognised.
> 
> The hotplug checks are high up in the interrupt handling
> path, not deep down in error_intr as in ahci/sata_sil24.
> That's because the chip doesn't signal hotplug status changes
> in the per-port status register: instead a global register
> contains hotplug control and status flags for all ports.
> I considered following the ahci/sata_sil24 structure, but
> that would have required non-trivial changes to the interrupt
> handling path, so I chose to keep the hotplug changes simple
> and unobtrusive.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> --
> This patch depends on the "sata_promise: cleanups" patch.
> 
> Changes since the previous version (posted June 19):
> - Correct pdc_interrupt() to increment 'handled' also in
>   the hotplug case. This prevents IRQ_NONE from being
>   returned when an interrupt only has hotplug events to
>   handle, which could confuse the kernel's IRQ machinery.
> - Added testing on the SATAII150 TX4.
> 
>  drivers/ata/sata_promise.c |   41 ++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 36 insertions(+), 5 deletions(-)

applied


