From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH] drivers/ata: PATA driver for Celleb
Date: Tue, 12 Dec 2006 17:34:21 -0600
Message-ID: <20061212233421.GM4329@austin.ibm.com>
References: <200612120206.kBC26wHr022838@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:57068 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbWLLXeb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Dec 2006 18:34:31 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBCNYMRY030897
	for <linux-ide@vger.kernel.org>; Tue, 12 Dec 2006 18:34:22 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBCNYMMG548298
	for <linux-ide@vger.kernel.org>; Tue, 12 Dec 2006 16:34:22 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBCNYLXL029357
	for <linux-ide@vger.kernel.org>; Tue, 12 Dec 2006 16:34:22 -0700
Content-Disposition: inline
In-Reply-To: <200612120206.kBC26wHr022838@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de

On Tue, Dec 12, 2006 at 11:08:24AM +0900, Akira Iguchi wrote:
> 
> I use some static functions in libata-core.c because it makes

You will want to split this patch into several pars, and submit the 
changes to libata-core.c separately.

> --- linux-2.6.19/drivers/ata/libata-core.c	Wed Dec  6 12:00:47 2006
> ***************
> *** 600,606 ****
>    *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
>    */
>   
> ! static unsigned int
>   ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
>   {
>   	struct ata_taskfile tf;
> --- 600,606 ----
>    *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
>    */
>   
> ! unsigned int
>   ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)

Please generate unified diffs (diff -pu) or use quilt,
this makes the patches easier to read. (and smaller)

--linas

