From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] libata: HPA support
Date: Tue, 17 Apr 2007 18:05:46 -0400
Message-ID: <20070417220546.GE24014@athena.road.mcmartin.ca>
References: <20070411002313.29069ca5@the-village.bc.nu> <46251CCB.9040906@pobox.com> <20070417193057.GB22688@redhat.com> <200704171534.56685.jkeating@redhat.com> <46253141.80509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:56335 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031280AbXDQWHw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 18:07:52 -0400
Content-Disposition: inline
In-Reply-To: <46253141.80509@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jesse Keating <jkeating@redhat.com>, Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Tue, Apr 17, 2007 at 04:42:41PM -0400, Jeff Garzik wrote:
> Jesse Keating wrote:
> >On Tuesday 17 April 2007 15:30:57 Dave Jones wrote:
> >>jesse, wanna give that a shot? booting with the installer with
> >>sata_nv.adma=0 should do the trick.
> >
> >That didn't effect anything.  I still saw a message about "using ADMA 
> >mode" right before the panic(s).
> >
> >I added "sata_nv.adma=0" to the kernel arguments.
> 
> If you still saw ADMA mode, then it's not seeing the module parameter.
> 
> It sounds like putting sata_nv.adma on the kernel command line didn't do 
> the trick?
> 

If it's a module, putting it on the kernel command line won't fix it, you
have to break into the initramfs and add the module param.

I've got a patch to send out later to apply saved_command_line[] checking
to modules that I really wish I had been able to get into feisty.

Cheers,
	Kyle
