From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_rdc: driver for RDC ATA devices
Date: Wed, 24 Jun 2009 15:35:41 -0400
Message-ID: <4A42800D.6020202@garzik.org>
References: <20090624172930.24354.80799.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44656 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbZFXTfH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jun 2009 15:35:07 -0400
In-Reply-To: <20090624172930.24354.80799.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, kevin.huang@rdc.com.tw, greg@kroah.com, Linux IDE mailing list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> Try this version instead - forgot to refresh the patch before sending
> 
> From: Alan Cox <alan@linux.intel.com>
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/ata/Kconfig    |   10 +
>  drivers/ata/Makefile   |    1 
>  drivers/ata/pata_rdc.c |  400 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 411 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/pata_rdc.c

Requesting that linux-ide be CC'd in the future, for this driver...

Seems fine and fairly straightforward to me.  My lone comment -- go 
through and replace magic numbers with named constants, for e.g. the PCI 
config registers that program timings...

	Jeff



