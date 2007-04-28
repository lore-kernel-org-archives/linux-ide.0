From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 02/10] sata_nv: add back some verbosity into ADMA error_handler
Date: Sat, 28 Apr 2007 15:11:31 -0400
Message-ID: <46339C63.1020206@garzik.org>
References: <200704260719.l3Q7JMhB023682@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53653 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782AbXD1TLg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 15:11:36 -0400
In-Reply-To: <200704260719.l3Q7JMhB023682@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hancockr@shaw.ca
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: Robert Hancock <hancockr@shaw.ca>
> 
> Some debug output in the ADMA error_handler function was removed recently,
> but it may be useful in certain cases, like NCQ commands timing out.  Add
> it back in, but make it a bit more intelligent so that it only prints if
> command(s) are active and only prints the CPBs for those commands.  That
> way it won't spew at inappropriate times like suspend/resume.
> 
> [akpm@osdl.org: cleanup]
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/sata_nv.c |   31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)

Robert, is this patch still wanted?

It looks OK; I've held because I thought it was created to debug a 
special situation.

But I might be mistaken...

	Jeff


