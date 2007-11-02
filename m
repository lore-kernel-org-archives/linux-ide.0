From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] libata: implement dev->acpi_init_gtm
Date: Fri, 2 Nov 2007 15:44:43 +0000
Message-ID: <20071102154443.487bf550@the-village.bc.nu>
References: <472B402A.4030009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35981 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758618AbXKBPn1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 11:43:27 -0400
In-Reply-To: <472B402A.4030009@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sat, 03 Nov 2007 00:20:10 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Add dev->acpi_init_gtm and store initial GTM values on host
> initialization.  If the field is valid, ATA_PFLAG_INIT_GTM_VALID flag
> is set.  This is to remember BIOS/firmware programmed initial timing
> for later use before reset and mode configuration modify it.

Don't you need to clear this on a hotplug event ?

Alan
