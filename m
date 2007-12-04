From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 06/14] libata: improve ATAPI draining
Date: Tue, 04 Dec 2007 18:06:37 +0800
Message-ID: <475526AD.3090406@tw.ibm.com>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468192463-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:36007 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbXLDKHA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 05:07:00 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB495Kr8023389
	for <linux-ide@vger.kernel.org>; Tue, 4 Dec 2007 04:05:20 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id lB4A6n19057456
	for <linux-ide@vger.kernel.org>; Tue, 4 Dec 2007 03:06:49 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lB4A6m6h002073
	for <linux-ide@vger.kernel.org>; Tue, 4 Dec 2007 03:06:49 -0700
In-Reply-To: <11963468192463-git-send-email-htejun@gmail.com>
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
> * Properly calculate the number of bytes to be drained considering
>   actual number of consumed bytes for partial draining.
> 
> * Add and use ata_drain_page for draining.  This change fixes the
>   problem where LLDs which do 32bit IOs consumes 4 bytes on each 2
>   byte draining resulting in draining twice more data than requested.
> 
> This patch fixes ATAPI regressions introduced by setting transfer
> chunk size to allocation size.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Albert Lee <albertcc@tw.ibm.com>

Sorry for the late reply. The new patch looks good.

However, I am a little worried about the following code segment in 
__atapi_pio_bytes():

next_sg:
	if (!bytes)
		return 0;


Maybe we should add an additional check to atapi_pio_bytes() such
that "DRQ asserted with bytes = 0" is considered as AC_ERR_HSM?
(patch attached below.) Otherwise the device might keep interruping us
with DRQ asserted + zero byte count, and we are in infinite loop...

--
albert


diff -Nrup 00_libata-dev/drivers/ata/libata-core.c 07_more_check/drivers/ata/libata-core.c
--- 00_libata-dev/drivers/ata/libata-core.c	2007-11-14 10:08:36.000000000 +0800
+++ 07_more_check/drivers/ata/libata-core.c	2007-12-04 18:03:48.000000000 +0800
@@ -5341,6 +5341,9 @@ static void atapi_pio_bytes(struct ata_q
 	if (do_write != i_write)
 		goto err_out;
 
+	if (!bytes)
+		goto err_out;
+
 	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
 
 	__atapi_pio_bytes(qc, bytes);

