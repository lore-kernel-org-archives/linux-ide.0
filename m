From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] hpt366: simplify UltraDMA filtering (take 3)
Date: Fri, 8 Jun 2007 14:42:54 +0200
Message-ID: <200706081442.54937.bzolnier@gmail.com>
References: <200706062357.42432.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:48482 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968434AbXFHNJV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 09:09:21 -0400
Received: by ug-out-1314.google.com with SMTP id j3so950408ugf
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 06:09:19 -0700 (PDT)
In-Reply-To: <200706062357.42432.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 06 June 2007, Sergei Shtylyov wrote:
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
> 
> ---
> This patch is against the top of the pata-2.6. I had to change it a bit due to
> a fixes going in ahead. Tested on HPT370, will try to test on HPT371N later...

applied
