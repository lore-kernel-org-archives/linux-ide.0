From: Jeff Garzik <jeff@garzik.org>
Subject: Re: use_clustering (sht) bit set to 0 in AHCI ?
Date: Thu, 24 May 2007 23:06:04 -0400
Message-ID: <4656529C.4050701@garzik.org>
References: <35f686220704252249y6d4fe0c3y1a772119c7b6657f@mail.gmail.com> <20070521121726.GT14746@kernel.dk> <46520C68.7090105@garzik.org> <20070522074538.GP4705@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50683 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291AbXEYDGJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 23:06:09 -0400
In-Reply-To: <20070522074538.GP4705@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alok kataria <alokkataria1@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Mon, May 21 2007, Jeff Garzik wrote:
>> Jens Axboe wrote:
>>> ahci has always had clustering disabled, perhaps Jeff can expand on why?
>>
>> Just historical reasons.  libata had clustering disabled by default in 
>> the beginning, for all drivers.  Then we enabled it globally by changing 
>> the value of ATA_SHT_USE_CLUSTERING...  but apparently forgot to change 
>> drivers which use their own value rather than ATA_SHT_USE_CLUSTERING.
>>
>> Feel free to submit a patch turning it on...
> 
> The below works for me, but it's only lightly tested. I booted it up and
> ran some large IO tests, I've verified really large IO sizes as well
> (using blktrace, I've verified ios up to 9216KiB being accepted and
> completed by the drive).
> 
> -----
> 
> From: Jens Axboe <jens.axboe@oracle.com>
> 
> ahci: enable sg segment clustering
> 
> The specification states that ahci supports segments up to 4MiB in size,
> so enable clustering.
> 
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

applied


