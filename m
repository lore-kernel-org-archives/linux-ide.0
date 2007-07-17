From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] PCI: rename and export __pci_reenable_device()
Date: Tue, 17 Jul 2007 10:05:38 -0700
Message-ID: <20070717170538.GA2281@kroah.com>
References: <20070710063605.GA21994@htj.dyndns.org> <20070710161709.GB5421@kroah.com> <20070711103204.GE23568@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:52894 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbXGQRJy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jul 2007 13:09:54 -0400
Content-Disposition: inline
In-Reply-To: <20070711103204.GE23568@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

On Wed, Jul 11, 2007 at 07:32:04PM +0900, Tejun Heo wrote:
> Some odd ACPI implementations choke if certain controller is disabled
> when ACPI suspend is invoked but we still need to make sure the PCI
> device is enabled during resume.  Simply using pci_enable_device()
> unbalances device enable count.
> 
> Drop leading underscores from __pci_reenable_device() and export it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Jeff, I'm guessing this will go through your tree as the ata patch after
this needs this change.

If so, feel free to add my:

	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

to the patch, I have no objection to it.

thanks,

greg k-h
