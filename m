From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] hpt366: simplify UltraDMA filtering
Date: Sat, 5 May 2007 21:30:17 +0200
Message-ID: <200705052130.17317.bzolnier@gmail.com>
References: <200705010039.44580.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:43555 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbXEEUH7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 16:07:59 -0400
Received: by ik-out-1112.google.com with SMTP id b35so1108189ika
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 13:07:58 -0700 (PDT)
In-Reply-To: <200705010039.44580.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Monday 30 April 2007, Sergei Shtylyov wrote:
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

applied

I needed to fix some rejects because of the
"hpt366: don't check enablebits for HPT36x" patch
- please verify that I haven't broken anything.

Thanks,
Bart
