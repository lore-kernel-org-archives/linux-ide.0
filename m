From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] ata_piix: fix suspend/resume for some TOSHIBA laptops
Date: Tue, 24 Jul 2007 16:59:46 -0400
Message-ID: <46A66842.6040803@garzik.org>
References: <20070710063605.GA21994@htj.dyndns.org> <20070710065543.GA23568@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59279 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757374AbXGXU7u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jul 2007 16:59:50 -0400
In-Reply-To: <20070710065543.GA23568@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: greg@kroah.com, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

Tejun Heo wrote:
> +	/* Some braindamaged ACPI suspend implementations expect the
> +	 * controller to be awake on entry; otherwise, it burns cpu
> +	 * cycles and power trying to do something to the sleeping
> +	 * beauty.
> +	 */


applied 1-2... HOWEVER...

I would not classify this as braindead.  I have applied these patches, 
but it must be emphasized that this is a temporary fix only.

Overall, it is unfortunately but libata must be aware of the state the 
controller should be in, for suspend and resume.  I bet some more 
suspend/resume problems can be isolated to a hardware state mismatch, 
where BIOS expects one thing but Linux has configured the hardware 
differently.

A more generalized rule to consider for the future would be to ensure 
that ALL suspend routines put the hardware back into its pre-Linux init 
mode before suspending.  i.e. that means if we turned on some enhanced 
mode, we must switch back to legacy mode before calling pci_xxx to 
suspend our device.

	Jeff




