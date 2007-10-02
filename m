From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 3
Date: Tue, 2 Oct 2007 19:46:22 +0100
Message-ID: <20071002184622.GB31251@srcf.ucam.org>
References: <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com> <20070924231436.GA32119@srcf.ucam.org> <47025E09.1030803@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:47630 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbXJBSqm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 14:46:42 -0400
Content-Disposition: inline
In-Reply-To: <47025E09.1030803@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kristen.c.accardi@intel.com

On Tue, Oct 02, 2007 at 11:04:41AM -0400, Jeff Garzik wrote:

> 1) Check dev->sdev for NULL

Ok.

> 2) remove the unnecessary ata_device loop.  If you know the ata_device 
> pointer, you should not throw it away and then do a search to find it again.
> 
> You need two functions, ata_acpi_ap_notify() and ata_acpi_dev_notify(). 
>  Pass 'ap' to the former, and 'dev' to the latter.
> 
> Both functions should marshal their arguments, then call a common 
> function (presumably what 95% of current ata_acpi_notify does).

Sure.

> 3) Won't this result in a single hotplug event calling 
> ata_ehi_hotplugged() multiple times -- once for the port, and once for 
> each device attached to the port?

No - the platform will either send an event for the port or for an 
individual device. It'll never simultaneously send one for both the port 
and a device. Semantically the one from the port is a "check all 
children" request and the one from the device a "check this individual 
device", but I believe these are both equivalent in the current hotswap 
implementation.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
