From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: separate port number determination from host initialization
Date: Fri, 09 Mar 2007 09:07:05 -0500
Message-ID: <45F16A09.3040904@garzik.org>
References: <20070309104709.GF32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56453 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767301AbXCIOHI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 09:07:08 -0500
In-Reply-To: <20070309104709.GF32687@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ahci used to reset controller then fetch cap value to be used for
> configuration.  On some controller this misses some cap bits and ahci
> got modified to maintain cap and ports_impl values over reset, so
> there is no reason to reset the controller before fetching those
> register values.
> 
> Separate out ahci_determine_nr_ports() from ahci_host_init() and it
> before starting to initialize probe_ent.  This makes ahci's init_one
> more consistent to other drivers and eases conversion to new init
> model.
> 
> Also, the initialization is more robust as it doesn't depend on
> ports_impl being writeable when HONOR_PI is set but the register
> itself is zero.
> 
> Tested on ICH7 (no ports_impl) and 8 AHCI (w/ ports_impl).
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

I would rather make things explicit by creating an 
ahci_read_bios_config() function, and associated data structures, which 
reads all register values that are not preserved across reset.  This 
would also be the code point at which we would handle a 
no-BIOS/uninitialized configuration.

After such a change, this patch will look smaller and nicer.

	Jeff



