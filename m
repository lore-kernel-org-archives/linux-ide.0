From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] PCI: amd74xx patch for new NVIDIA device IDs
Date: Wed, 01 Jun 2005 03:32:15 -0400
Message-ID: <429D647F.5020701@pobox.com>
References: <111760252426@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:56965 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261309AbVFAHcV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jun 2005 03:32:21 -0400
In-Reply-To: <111760252426@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, acurrid@nvidia.com

Greg KH wrote:
> [PATCH] PCI: amd74xx patch for new NVIDIA device IDs
> 
> Here's the 2.6 amd74xx patch for NVIDIA MCP51.
> 
> Signed-off-by: Andy Currid <acurrid@nvidia.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
> commit af00f9811e0ccbd3db84ddc4cffb0da942653393
> tree 5a9c3b7f7d61d96d3624ad130b173a761cb7dac2
> parent 2ac2610b26c9da72820443328ff2c56c7b8c87b8
> author Andy Currid <acurrid@nvidia.com> Mon, 23 May 2005 08:55:45 -0700
> committer Greg KH <gregkh@suse.de> Tue, 31 May 2005 14:26:38 -0700
> 
>  drivers/ide/pci/amd74xx.c |    3 +++
>  include/linux/pci_ids.h   |    6 ++++++


This is hardly a PCI patch.

Has Bart, the IDE maintainer, acked this?

	Jeff


