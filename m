From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata #promise-sata-pata] sata_promise: 2037x PATAPI
 support
Date: Mon, 8 Jan 2007 10:30:26 +0000
Message-ID: <20070108103026.230470a8@localhost.localdomain>
References: <200701072239.l07Mdju7028895@harpo.it.uu.se>
	<45A1A2B7.8000601@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47335 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161212AbXAHKTl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jan 2007 05:19:41 -0500
In-Reply-To: <45A1A2B7.8000601@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> IMO creating a new check_atapi_dma function for first-gen chips would be 
> the preferred way to add this check.

A mode filter would be even better, that will mean the list of modes on
the device is correct and ATAPI devices are shown as PIO on such a
controller.
