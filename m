From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 25/25] ata_piix: disallow UDMA 133 on ICH5 & ICH7
Date: Wed, 15 Aug 2007 04:25:08 -0400
Message-ID: <46C2B864.9060101@garzik.org>
References: <200708102059.l7AKxpv1008645@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59345 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754426AbXHOIZL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 04:25:11 -0400
In-Reply-To: <200708102059.l7AKxpv1008645@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, chunkeey@web.de, alan@lxorguk.ukuu.org.uk, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: Christian Lamparter <chunkeey@web.de>
> 
> There is another outstanding issue with ata_piix.c.  Intel has never
> officially supported anything faster than PATA 100MB/s.
> 
> But, the ata_piix.c driver "define" the ICH5 & ICH7 as UDMA6 (aka 133MB/s)
> capable.  [ Well, no one has probably noticed it before, because there is bug
> in do_pata_set_dmamode...  Just look at
> libata_atapiix_enable_real_udma133.patch and you'll see what wrong with it.  ]
> 
> 
> Here are Intel's datasheets for the affected chipsets: ICH5 Datasheet:
> http://www.intel.com/design/chipsets/datashts/252516.htm (See note on page
> 183: "...  the ICH5 supports reads at the maximum rate of 100MB/s.")
> 
> ICH7 Datasheet: http://www.intel.com/design/chipsets/datashts/307013.htm (See
> first note on page 190: "...  the ICH7 supports reads at the maximum rate of
> 100MB/s.")
> 
> They are two different ways to deal with it:
> 
> - Either -
> 
> 1. replace all ich_pata_133 with ich_pata_100. 
>    (libata_atapiix_disable_udma6.diff - diff from 2.6.22 )
> 
> - Or -
> 
> 2. keep all ich_pata_133 and fix the bug in "do_pata_set_dmamode". 
>    (libata_atapiix_enable_real_udma133.patch - diff from 2.6.22) If there are
>    any concerns about the safety of the patch patch:
>    http://lkml.org/lkml/2007/7/6/292 (It was already tested by an Intel
>    employee, but I guess a bit more user input is necessary here...  )
> 
> This patch implements 1.
> 
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Christian Lamparter <chunkeey@web.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/ata_piix.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

applied


