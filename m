From: Greg KH <gregkh@suse.de>
Subject: Re: Improving sata_vsc PCI ID usage...
Date: Mon, 26 Jun 2006 21:28:45 -0700
Message-ID: <20060627042845.GB1768@suse.de>
References: <44A081D5.80905@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kroah.org ([69.55.234.183]:12525 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S933368AbWF0Ea6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jun 2006 00:30:58 -0400
Content-Disposition: inline
In-Reply-To: <44A081D5.80905@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, bcasavan@sgi.com, jes@sgi.com, akpm@osdl.org

On Mon, Jun 26, 2006 at 08:54:45PM -0400, Jeff Garzik wrote:
> FYI, I just committed the attached patch to libata-dev.git...
> 
> 	Jeff
> 
> 

> commit 438bc9c3dec27ab37f0ff78471d0b8b91addd2dd
> Author: Jeff Garzik <jeff@garzik.org>
> Date:   Mon Jun 26 20:52:17 2006 -0400
> 
>     [libata] sata_vsc: partially revert a PCI ID-related commit
> 
>     Partially revert 74d0a988d3aa359b6b8a8536c8cb92cce02ca5d5:
> 
>         [PATCH] PCI: Move various PCI IDs to header file
> 
>     libata policy is to avoid use of named PCI device ID constants.
>     These are often single-use constants, which have little value over
>     direct numeric constants save for constant include/linux/pci_ids.h
>     patching/merging headaches.
> 
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

