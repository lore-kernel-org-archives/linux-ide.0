From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] alim15x3: PIO mode setup fixes
Date: Sun, 22 Jul 2007 20:47:52 +0200
Message-ID: <200707222047.52273.bzolnier@gmail.com>
References: <200707201224.33356.bzolnier@gmail.com> <46A0AF9A.3060401@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:53923 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759016AbXGVS32 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:29:28 -0400
Received: by nf-out-0910.google.com with SMTP id g13so97997nfb
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:29:27 -0700 (PDT)
In-Reply-To: <46A0AF9A.3060401@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 20 July 2007, Sergei Shtylyov wrote:
> Hi.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Return failure in ->speedproc method for unsupported/invalid transfer
> >   modes passed from user-space (fixes theoretical OOPS in ali_tune_pio()
> >   and/or setting random PIO timings on host controller + disabling UDMA
> >   bit + setting unsupported/invalid transfer mode on the device).
> 
> > * Don't disable UDMA bit when programming PIO modes.
> 
>     Not an issue per se sice ide_config_drive_speed() will turn DMA off anyway 
> (unless a drive denies to set a given xfer mode).

Yep but it is needed for patch #4/4.

> > * Add FIXME about DMA timings never being set.
> 
> > * Bump driver version.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
