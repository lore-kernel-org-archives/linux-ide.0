From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/4] hpt366: MWDMA filter for SATA cards (take 2)
Date: Tue, 2 Oct 2007 22:26:10 +0200
Message-ID: <200710022226.10687.bzolnier@gmail.com>
References: <200709300004.43335.sshtylyov@ru.mvista.com> <200710012312.45552.bzolnier@gmail.com> <470237E3.2020108@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:28741 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbXJBVTl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 17:19:41 -0400
Received: by nf-out-0910.google.com with SMTP id g13so3415441nfb
        for <linux-ide@vger.kernel.org>; Tue, 02 Oct 2007 14:19:39 -0700 (PDT)
In-Reply-To: <470237E3.2020108@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 02 October 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>The Marvell bridge chips used on HighPoint SATA cards do not seem to support
> >>the MWDMA modes (at least that caould be seen in their so-called drivers :-),
> >>so the driver needs to account for this -- to achieve this:
> 
> >>- add mdma_filter() method from the original patch by Bartlomiej Zolnierkewicz
> >> with his consent,
> 
> >> also adding the method callout to ide_rate_filter();
> 
>     Ugh, forgot to remove this part -- it's no longer true.

Thanks for the hint, I fixed it locally.

Bart
