From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_atiixp: fix slave device support
Date: Wed, 12 Aug 2009 06:25:58 -0400
Message-ID: <4A8298B6.4060608@garzik.org>
References: <200908061740.15902.bzolnier@gmail.com> <200908061747.05944.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932481AbZHLK0V@vger.kernel.org>
In-Reply-To: <200908061747.05944.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Krystian Juskowiak <jusko@tlen.pl>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bbpetkov@yahoo.de>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Thursday 06 August 2009 17:40:15 Bartlomiej Zolnierkiewicz wrote:
>> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> Subject: [PATCH] pata_atiixp: fix slave device support
> 
> Argh, I pushed the "Send" button too quick..
> 
> Below version with the correct patch description
> (I doubt that this fix will help with bug #13921)..
> 
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH v2] pata_atiixp: fix second channel support
> 
> PIO and MWDMA timings are never programmed for the second channel
> because timing registers are treated as 16-bit long ones.
> 
> The bug is an attixp -> pata_atiixp regression and goes back to:
> 
> 	commit 669a5db411d85a14f86cd92bc16bf7ab5b8aa235
> 	Author: Jeff Garzik <jeff@garzik.org>
> 	Date:   Tue Aug 29 18:12:40 2006 -0400
> 
> 	    [libata] Add a bunch of PATA drivers.
> 
> Cc: Krystian Juskowiak <jusko@tlen.pl>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Borislav Petkov <bbpetkov@yahoo.de>
> Cc: Robert Hancock <hancockrwd@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> After this patch pata_atiixp still have two bugs (+ few superfluous oddities)
> not present in atiixp (although not as severe as this one)..
> 
>  drivers/ata/pata_atiixp.c |   19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

applied
