From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming
Date: Mon, 28 May 2007 09:02:31 -0400
Message-ID: <465AD2E7.2080600@garzik.org>
References: <20070202151856.GD1625@htj.dyndns.org> <20070430182939.GD4156@artsapartment.org> <4636ADBE.8080508@gmail.com> <20070524195943.GC7734@artsapartment.org> <4655FBA4.9050702@garzik.org> <4655FDBF.3000401@gmail.com> <46571A0A.2030305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45696 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753610AbXE1NCg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 May 2007 09:02:36 -0400
In-Reply-To: <46571A0A.2030305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Art Haas <ahaas@airmail.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Fix various bugs in pio/mwdma mode programming.
> 
> * Control bits in the timing register wasn't cleared properly while
>   programming PIO mode.
> 
> * MWDMA mode programming cleared the wrong part of control bits.
> 
> * MWDMA mode programming cleared udma_mask even when the controller
>   doesn't support UDMA.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Art Haas <ahaas@airmail.net>
> ---
> Patch is against libata-dev#upstream.  Thanks.
> 
>  drivers/ata/ata_piix.c |   23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

applied to #upstream


