From: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
Date: Mon, 10 Nov 2014 21:55:18 +0100
Message-ID: <20141110205518.GY20170@rric.localhost>
References: <1415597417-10547-1-git-send-email-rric@kernel.org>
 <5460D100.90403@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:59300 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbaKJUzY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Nov 2014 15:55:24 -0500
Content-Disposition: inline
In-Reply-To: <5460D100.90403@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Sunil Goutham <sgoutham@cavium.com>, Robert Richter <rrichter@cavium.com>

On 10.11.14 22:51:44, Jiang Liu wrote:
> On 2014/11/10 13:30, Robert Richter wrote:
> > From: Sunil Goutham <sgoutham@cavium.com>

> > +   /* only enable the first entry (entry.entry = 0) */
> > +   rc = pci_enable_msix_exact(pdev, &entry, 1);
> > +   if (rc < 0)
> > +           return rc;
> > +
> > +   pdev->irq = entry.vector;

>       You can't overwrite pci_dev->irq for MSI-X, it's no way to
> recover original irq for INTx after unbinding ahci driver. Instead,
> you may access msi_desc->irq when requesting irq.

Right, I have a version now that determines the irq vector from
pdev->msi_list.

-Robert
