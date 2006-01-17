From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Tue, 17 Jan 2006 17:03:42 +0100
Message-ID: <200601171703.42509.pvrusb2@toplitzer.net>
References: <200601131909.07981.pvrusb2@toplitzer.net> <58cb370e0601170517v6fe68992ma5bdc67d5eb1e6f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:24995 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S1751285AbWAQQDx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 11:03:53 -0500
In-Reply-To: <58cb370e0601170517v6fe68992ma5bdc67d5eb1e6f1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

Hi!

> >
> > 37MB/s with CPU not utilized
> > 55MB/s with CPU 100% utilized
>
> I can't reproduce this locally, please send me your kernel
> config.  Although I have Intel chipset it is still worth a try
> if it is generic kernel bug.  I don't remember seeing anything
> like that on my old VIA system which also had VT8235
> southbridge - if somebody has similar machine to Helmut's
> please try to reproduce this behavior (thanks!).
>

Ok. I made one more test: disabling all usb in the bios.
(Sorry, can not unplug. It's onboard.)
Booting to init 1 without loading the usb-drivers.
Same results. 37MB/s initial, 55MB/s after loading the
burnK7 programm in background. Unloading bunrK7 and
transfer-rate is back to 37.
So this time no USB-device is connected and no driver
loaded. USB-ports disabled selected in the bios.

If you still think this is a usb-thingy I will shift
my communication to linux-usb-devel.

Helmut

-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656
