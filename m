From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATCH 2/2] at91_ide: turn on PIO 6 support
Date: Tue, 7 Apr 2009 20:35:55 +0200
Message-ID: <200904072035.56253.bzolnier@gmail.com>
References: <200904062342.11437.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47557 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761626AbZDGVk4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 17:40:56 -0400
Received: by fxm2 with SMTP id 2so2531307fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2009 14:40:55 -0700 (PDT)
In-Reply-To: <200904062342.11437.stf_xl@wp.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Steve Wootton <swootton@esi-estech.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Tuesday 07 April 2009 05:42:11 Stanislaw Gruszka wrote:
> As we have already PIO 6 transfer mode supported in IDE layer, we can turn
> it on in the driver.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

applied

> ---
> Patch is against pata-2.6. Steve (CCed) tested on real hardware that PIO6
> works with at91_ide .

Thanks, I added appropriate "Tested-by:" entry to the patch description.
