From: Jeff Garzik <jeff@garzik.org>
Subject: Re: use_clustering (sht) bit set to 0 in AHCI ?
Date: Mon, 21 May 2007 17:17:28 -0400
Message-ID: <46520C68.7090105@garzik.org>
References: <35f686220704252249y6d4fe0c3y1a772119c7b6657f@mail.gmail.com> <20070521121726.GT14746@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45406 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755610AbXEUVRd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 May 2007 17:17:33 -0400
In-Reply-To: <20070521121726.GT14746@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alok kataria <alokkataria1@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> ahci has always had clustering disabled, perhaps Jeff can expand on why?


Just historical reasons.  libata had clustering disabled by default in 
the beginning, for all drivers.  Then we enabled it globally by changing 
the value of ATA_SHT_USE_CLUSTERING...  but apparently forgot to change 
drivers which use their own value rather than ATA_SHT_USE_CLUSTERING.

Feel free to submit a patch turning it on...

	Jeff


