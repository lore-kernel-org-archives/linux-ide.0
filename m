From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 07/10] ide: add ->dma_check method
Date: Wed, 11 Mar 2009 17:36:07 +0100
Message-ID: <200903111736.08104.bzolnier@gmail.com>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain> <20090220171229.25429.16478.sendpatchset@localhost.localdomain> <49B44781.6050708@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:10201 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191AbZCKRA4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 13:00:56 -0400
In-Reply-To: <49B44781.6050708@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 08 March 2009, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Add (an optional) ->dma_check method for checking if DMA can be
> >   used for a given command and fail DMA setup in ide_dma_prepare()
> >   if necessary.
> >
> > * Convert alim15x3 and trm290 host drivers to use ->dma_check.
> >
> > * Rename ali15x3_dma_setup() to ali_dma_setup() while at it.
> >   
> 
>    ali_dma_check() you mean?

Yep, thanks for noticing (it is fixed now).

> > There should be no functional changes caused by this patch.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >   
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
