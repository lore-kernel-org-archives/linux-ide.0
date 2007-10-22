From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AHCI with ATA/IDE Drives
Date: Mon, 22 Oct 2007 11:17:34 +0100
Message-ID: <20071022111734.23b59a5f@the-village.bc.nu>
References: <a14fb1800710200440hbcb0438sf2b0ee627e6e8209@mail.gmail.com>
	<471A09B8.2040708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40702 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750891AbXJVKPm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2007 06:15:42 -0400
In-Reply-To: <471A09B8.2040708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Girish Shirasat <girish.shirasat@googlemail.com>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>

On Sat, 20 Oct 2007 09:59:20 -0400
Mark Lord <liml@rtr.ca> wrote:

> Alan / Tejun,
> 
> Another case of MDMA2 not working through a SATA->PATA bridge.
> Do we have an easy way yet, for Girish to force non-MDMA2 modes?


I sent Jeff a patch a while back to allow libata DMA to be enabled
seperately for disk, atapi and CF. So yes.
