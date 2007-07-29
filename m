From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] amd74xx/via82cxxx: check ide_config_drive_speed() return value
Date: Sun, 29 Jul 2007 16:31:58 +0200
Message-ID: <200707291631.58875.bzolnier@gmail.com>
References: <200707262156.00679.bzolnier@gmail.com> <46AC6CED.4090601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:59697 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764995AbXG2SFJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:09 -0400
Received: by ug-out-1314.google.com with SMTP id j3so945455ugf
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:07 -0700 (PDT)
In-Reply-To: <46AC6CED.4090601@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Sunday 29 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Check ide_config_drive_speed() return value.
> 
> > * While at also call ide_config_drive_speed() if the transfer mode is
> >   XFER_PIO_SLOW (this case happens iff the transfer mode has already been
> >   set on the device by ide-proc.c::set_xfer_rate()) and remove redundant
> >   setting of ->{init,current}_speed.
> 
> > * Bump driver version.
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> MBR, Sergei
> 
> PS: There's no need to notify about Acked-by: addition I think -- would save 
> everyone a keystroke or two... ;-)

OK, just assume that they are added and complain in PM if they are not. :)

Bart
