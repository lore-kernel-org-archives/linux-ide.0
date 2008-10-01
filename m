From: Tejun Heo <tj@kernel.org>
Subject: Re: Interoperability problem with Quantum CD72SH SATA tape drive
 and libata
Date: Wed, 01 Oct 2008 12:21:12 +0900
Message-ID: <48E2ECA8.8060808@kernel.org>
References: <48DE96AF.6090301@runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47853 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401AbYJADXR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Sep 2008 23:23:17 -0400
In-Reply-To: <48DE96AF.6090301@runbox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Clark <clarkjc@runbox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

John Clark wrote:
> Hello,
> 
> I've discovered an issue with the Quantum CD72SH SATA tape drive.  I set
> it to variable block size, try to write a 5317 byte block with an ATAPI
> issued WRITE(6), and it hangs.  The drive is connected to an Intel ICH9R
> in AHCI mode.
> 
> My debugging efforts have determined that it's a problem with the
> drive's firmware.  It does not like ATAPI CDBs with odd (& 1) transfer
> lengths with PIO.  If I let it use DMA, even if it's not a multiple of
> 16 bytes, then it seems to work:
> 
> --- libata-core.c.orig    2008-09-27 16:12:46.000000000 -0400
> +++ libata-core.c    2008-09-27 16:11:29.000000000 -0400
> @@ -4669,8 +4669,8 @@
>     /* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
>      * few ATAPI devices choke on such DMA requests.
>      */
> -    if (unlikely(qc->nbytes & 15))
> -        return 1;
> +    // if (unlikely(qc->nbytes & 15))
> +    //     return 1;
> 
>     if (ap->ops->check_atapi_dma)
>         return ap->ops->check_atapi_dma(qc);
> 
> 
> 
> This is an acceptable solution for my limited use, but I'd like to see
> it work out of the box.  It seems frightening that there are ATAPI
> devices out there that choke on PIO requests.  What would you like to do?

We can create a HORKAGE for it.  Can you please post the result of
"hdparm -I" of the device?

-- 
tejun
