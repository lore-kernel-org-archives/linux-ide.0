From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: fix PCI must_checks
Date: Thu, 5 Apr 2007 12:13:02 +0100
Message-ID: <20070405121302.1206e748@the-village.bc.nu>
References: <20070404213704.224128ec.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52317 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992481AbXDELKN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Apr 2007 07:10:13 -0400
In-Reply-To: <20070404213704.224128ec.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>, bzolnier@gmail.com, akpm <akpm@linux-foundation.org>

On Wed, 4 Apr 2007 21:37:04 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Check PCI interface function results for errors in drivers/ide/pci.
> 
> drivers/ide/pci/cs5530.c:244: warning: ignoring return value of 'pci_set_mwi', declared with attribute warn_unused_result

NAK (again) 

The bug is in pci_set_mwi, it should not force return value checking.
Please fix that instead.
