From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: set IRQF_SHARED for legacy PCI IDE IRQs
Date: Tue, 28 Nov 2006 04:04:29 -0500
Message-ID: <456BFB9D.2050706@pobox.com>
References: <20061117072227.GG2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:5251 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935729AbWK1JEb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:04:31 -0500
In-Reply-To: <20061117072227.GG2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Tejun Heo wrote:
> There are machines out there which share legacy PCI IDE IRQs w/ other
> devices.  libata SFF interrupt/HSM code is ready for shared IRQ and
> has been setting IRQF_SHARED for devices in native PCI mode.  Device
> in legacy mode is still a PCI device and thus supposedly uses
> active-low level triggered IRQ.
> 
> Machines with such setup should be quite rare and w/o this flag libata
> is likely to fail loading and render the system unuseable.  Also, IDE
> driver has been setting IRQF_SHARED for devices in legacy mode for a
> looooong time.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> 
> Jeff, I couldn't find a generic way to check whether an IRQ is
> confiured as level or edge.  All these legacy mess are pretty much for
> the BIOS to figure out, so let's just do what IDE has been doing.
> 
> Thanks.

ACK

probably appropriate for #upstream-fixes, but IMO it's too late into -rc 
to apply such a change without wide testing


