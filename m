From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) sl82c105: rework PIO support
Date: Wed, 14 Feb 2007 20:48:00 +0100
Message-ID: <200702142048.00786.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:32143 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbXBNTmb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Feb 2007 14:42:31 -0500
Received: by wx-out-0506.google.com with SMTP id h31so332058wxd
        for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2007 11:42:31 -0800 (PST)
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org


On Tuesday 13 February 2007 23:01, Sergei Shtylyov wrote:
> Get rid of the 'pio_speed' member of 'ide_drive_t' that was only used by this
> driver by storing the PIO mode timings in the 'drive_data' instead -- this
> allows us to greatly simplify the process  of "reloading" of the chip's timing
> register and do in right in the ide_dma_off_quietly() and to turn the former
> config_for_pio() into the tuneproc() method.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This patch has also been actually tested at last. :-)

applied
