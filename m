From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Wed, 18 Jan 2006 11:27:53 +0100
Message-ID: <58cb370e0601180227q4807c531pc2319ff569d9e449@mail.gmail.com>
References: <200601131909.07981.pvrusb2@toplitzer.net>
	 <58cb370e0601170517v6fe68992ma5bdc67d5eb1e6f1@mail.gmail.com>
	 <200601171703.42509.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.204]:26952 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932342AbWARK14 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jan 2006 05:27:56 -0500
Received: by uproxy.gmail.com with SMTP id s2so239486uge
        for <linux-ide@vger.kernel.org>; Wed, 18 Jan 2006 02:27:54 -0800 (PST)
In-Reply-To: <200601171703.42509.pvrusb2@toplitzer.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helmut Toplitzer <pvrusb2@toplitzer.net>
Cc: linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

On 1/17/06, Helmut Toplitzer <pvrusb2@toplitzer.net> wrote:
> Hi!
>
> > >
> > > 37MB/s with CPU not utilized
> > > 55MB/s with CPU 100% utilized
> >
> > I can't reproduce this locally, please send me your kernel
> > config.  Although I have Intel chipset it is still worth a try
> > if it is generic kernel bug.  I don't remember seeing anything
> > like that on my old VIA system which also had VT8235
> > southbridge - if somebody has similar machine to Helmut's
> > please try to reproduce this behavior (thanks!).
> >
>
> Ok. I made one more test: disabling all usb in the bios.
> (Sorry, can not unplug. It's onboard.)
> Booting to init 1 without loading the usb-drivers.
> Same results. 37MB/s initial, 55MB/s after loading the
> burnK7 programm in background. Unloading bunrK7 and
> transfer-rate is back to 37.
> So this time no USB-device is connected and no driver
> loaded. USB-ports disabled selected in the bios.

Just wild guesses but please try:
* booting with "cpu=poll" parameter
* kernel with ACPI and Power Management disabled

> If you still think this is a usb-thingy I will shift
> my communication to linux-usb-devel.

Please keep linux-ide@ and me in cc:.

Thanks.
Bartlomiej
