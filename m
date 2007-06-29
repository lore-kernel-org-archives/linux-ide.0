From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] hpt366: simplify UltraDMA filtering (take 4)
Date: Fri, 29 Jun 2007 23:12:24 +0200
Message-ID: <200706292312.24936.bzolnier@gmail.com>
References: <200706300008.49077.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:62712 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbXF2WBL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 18:01:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1453298mue
        for <linux-ide@vger.kernel.org>; Fri, 29 Jun 2007 15:01:10 -0700 (PDT)
In-Reply-To: <200706300008.49077.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 29 June 2007, Sergei Shtylyov wrote:
> Simplify UltraDMA mode filtering in the driver:
> 
> - make use of the newly introduced 'udma_mask' field of 'ide_pci_device_t' to
>   set the correct hwif->ultra_mask, modifying init_setup_hpt366() to select
>   the correct mask based on the chip revision;
> 
> - replace 'max_mode' field of the 'struct hpt_info' with 'max_ultra' specifying
>   the maximum UltraDMA mode allowed;
> 
> - rewrite hpt3xx_udma_filter() to differ the filters based on the 'chip_type'
>   field, and only use it for HPT366 and HPT370[A] where it's really necessary.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

applied
