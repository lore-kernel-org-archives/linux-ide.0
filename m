From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-sff: Don't call bmdma_stop on non DMA capable
 controllers
Date: Thu, 25 Jan 2007 18:36:18 -0500
Message-ID: <45B93EF2.3030706@pobox.com>
References: <20070125150905.652f9ce2@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40918 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965273AbXAYXgW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 18:36:22 -0500
In-Reply-To: <20070125150905.652f9ce2@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Alan wrote:
> Fixes bogus accesses to ports 0-15 with a non DMA capable controller.
> This I think should go in for 2.6.20

applied to #upstream-fixes, but it's a hack based on a misunderstanding. 
  See comments below for further work needed.


> Arguably it shouldn't be called for PIO commands at all but thats a
> matter for Jeff to decide 

You are getting misled by the function name.

ata_bmdma_post_internal_cmd() is the common ->post_internal_cmd() hook 
for BMDMA-like (SFF-like) controllers.  ->post_internal_cmd() hook will 
always be called, for all commands, when present.

For PIO-only controllers, simply delete the post_internal_cmd hook from 
that specific driver's ata_port_operations.  (assuming no other cleanup 
is needed)

For other SFF controllers, perhaps ata_bmdma_post_internal_cmd() should 
be revised to check the taskfile protocol (PIO, DMA, ...)?

I leave that up to your judgement, to figure out what's best.  I 
certainly AGREE that an unconditional ata_bmdma_stop() for all commands, 
for all taskfile protocols, sounds wrong.

	Jeff



