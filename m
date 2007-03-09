From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2.6.22] remove Intel combined mode quirk
Date: Fri, 9 Mar 2007 11:56:01 -0800
Message-ID: <200703091156.02955.jbarnes@virtuousgeek.org>
References: <20070309160127.GA10226@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-mail-14.bluehost.com ([69.89.18.114]:45230 "HELO
	outbound-mail-14.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1767519AbXCIUDU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 15:03:20 -0500
In-Reply-To: <20070309160127.GA10226@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Friday, March 9, 2007 8:01 am Jeff Garzik wrote:
> Discussed for 2.6.21, but pushed back because the current SATA code
> had enough fun stuff to debug already.  Thus, just queued the
> following for 2.6.22 in libata-dev.git#upstream.
>
> The nasty ____request_resource hack is finally gone.
>
> In practical terms, this usually means that some combined mode users
> will have their SATA devices driven by the old-IDE driver rather than
> libata (because old-IDE is often non-modular, and thus probes first).
>
> But really, these same users will IMO cheer the removal of the
> performance-killing split-driver configuration, so its a net win.
> And the code is smaller and more clean, with one less special case
> hack.
>
>     libata/IDE: remove combined mode quirk
>
>     Both old-IDE and libata should be able handle all controllers and
>     devices found using normal resource reservation methods.
>
>     This eliminates the awful, low-performing split-driver
> configuration where old-IDE drove the PATA portion of a PCI device,
> in PIO-only mode, and libata drove the SATA portion of the /same/ PCI
> device, in DMA mode. Typically vendors would ship SATA hard drive /
> PATA optical configuration, which would lend itself to slow
> (PIO-only) CD-ROM performance.
>
>     For Intel users running in combined mode, it is now wholly
> dependent on your driver choice (potentially link order, if you
> compile both drivers in) whether old-IDE or libata will drive your
> hardware.
>
>     In either case, you will get full performance from both SATA and
> PATA ports now, without having to pass a kernel command line
> parameter.
>
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>

Yay!  I'm glad we can finally get rid of this in favor of the new pata 
drivers.  Don't forget to kill the stuff in 
Documentation/kernel-parameters.txt though.

Acked-by:  Jesse Barnes <jbarnes@virtuousgeek.org>

Jesse
