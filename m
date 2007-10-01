From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/4] hpt366: MWDMA filter for SATA cards (take 2)
Date: Mon, 1 Oct 2007 23:12:45 +0200
Message-ID: <200710012312.45552.bzolnier@gmail.com>
References: <200709300004.43335.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:61479 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbXJAVje (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:34 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977012ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:33 -0700 (PDT)
In-Reply-To: <200709300004.43335.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 29 September 2007, Sergei Shtylyov wrote:
> The Marvell bridge chips used on HighPoint SATA cards do not seem to support
> the MWDMA modes (at least that caould be seen in their so-called drivers :-),
> so the driver needs to account for this -- to achieve this:
> 
> - add mdma_filter() method from the original patch by Bartlomiej Zolnierkewicz
>   with his consent, also adding the method callout to ide_rate_filter();
> 
> - install the method for all chips to only return empty mask if a SATA drive
>   is detected on HPT372{AN]/374 chips...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
