From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 08/15] libata: improve ATAPI draining
Date: Thu, 06 Dec 2007 14:47:14 +0800
Message-ID: <47579AF2.5030005@tw.ibm.com>
References: <11968405951262-git-send-email-htejun@gmail.com> <11968405973998-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:39350 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbXLFGrZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Dec 2007 01:47:25 -0500
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB66lJwF025664
	for <linux-ide@vger.kernel.org>; Thu, 6 Dec 2007 01:47:19 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id lB66lJsw081210
	for <linux-ide@vger.kernel.org>; Wed, 5 Dec 2007 23:47:19 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lB66lIus014960
	for <linux-ide@vger.kernel.org>; Wed, 5 Dec 2007 23:47:19 -0700
In-Reply-To: <11968405973998-git-send-email-htejun@gmail.com>
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

Acked-by: Albert Lee <albertcc@tw.ibm.com>

