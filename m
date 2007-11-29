From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 05/13] libata: improve ATAPI draining
Date: Thu, 29 Nov 2007 14:28:50 +0800
Message-ID: <474E5C22.7010405@tw.ibm.com>
References: <11961764391983-git-send-email-htejun@gmail.com> <11961764403671-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:35339 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbXK2G3Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 01:29:24 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAT5RihX031413
	for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 00:27:44 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id lAT6T29J121210
	for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 23:29:02 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lAT6T1wT002250
	for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 23:29:02 -0700
In-Reply-To: <11961764403671-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> For misc ATAPI commands which transfer variable length data to the
> host, overflow can occur due to application or hardware bug.  Such
> overflows can be ignored safely as long as overflow data is properly
> drained.  libata HSM implementation has this implemented in
> __atapi_pio_bytes() but it isn't enough.  Improve drain logic such
> that...
> 
> * Multiple PIO data phases are allowed.  Not allowing this used to be
>   okay when transfer chunk size was set to 8k unconditionally but with
>   transfer hcunk size set to allocation size, treating extra PIO data
>   phases as HSM violations cause a lot of trouble.
> 
> * Limit the amount of draining to ATAPI_MAX_DRAIN (16k currently).
> 
> * Don't whine if overflow is allowed and safe.  When unexpected
>   overflow occurs, trigger HSM violation and report the problem using
>   ehi error description.
> 
> * If the device indicates that it wants to transfer odd number of
>   bytes, it should be rounded up not down.
> 

If the trailing data is odd-lengthed, normally the situation is that
we have odd-lengthed real data before the trailing data. e.g. The real
data is 9 bytes, but the drive returns 10 bytes (so, the trailing data
is 1 byte).

In ata_data_xfer(), we have the following code:

    /* Transfer trailing 1 byte, if any. */
    ... (for write case) ...
    iowrite16(le16_to_cpu(align_buf[0]), ap->ioaddr.data_addr);  or

    ... (for read case) ...
    ioread16(ap->ioaddr.data_addr)

The PATA bus is actually 16-bit wide. So, ata_data_xfer() actually
implicitly transfers one more byte than we see if it's odd-lengthed.

That's why in atapi_pio_bytes(), the trailing length was round down
instead round up.

--
albert




