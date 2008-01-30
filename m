From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 09/13] sata_mv ncq Use DMA memory pools for hardware memory
 tables
Date: Wed, 30 Jan 2008 11:40:21 -0500
Message-ID: <47A0A875.1070203@rtr.ca>
References: <479BC217.60709@rtr.ca> <479BC31D.1050206@rtr.ca> <479F5E1F.8030508@pobox.com> <479F6F40.7040401@rtr.ca> <47A04954.7010306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2900 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762669AbYA3QkX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jan 2008 11:40:23 -0500
In-Reply-To: <47A04954.7010306@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> 
> Nope, not corrupted in transit or on this side.  It falls into a 
> familiar pattern:
> 
> * git-am(1) fails
> * patch(1) succeeds
> * when applying patch, patch(1) drops a .orig turd
..

Okay, I figured it out.  There's a 1-line offset difference
between what is used in patch 10, and where stuff actually
is/was in sata_mv.c .

I probably changed an unrelated line and rediff'd an earlier patch
without rediff'ing everything that followed.

Because patch is smart and can handle it.

But since git-am plays dumb (both good and bad), I'll be more careful
about rediffing the entire series next time round.

Meanwhile, no further action required here.

Cheers
