From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Tue, 17 Jan 2006 14:17:30 +0100
Message-ID: <58cb370e0601170517v6fe68992ma5bdc67d5eb1e6f1@mail.gmail.com>
References: <200601131909.07981.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.194]:49396 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932327AbWAQNRd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jan 2006 08:17:33 -0500
Received: by uproxy.gmail.com with SMTP id s2so1059993uge
        for <linux-ide@vger.kernel.org>; Tue, 17 Jan 2006 05:17:31 -0800 (PST)
In-Reply-To: <200601131909.07981.pvrusb2@toplitzer.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helmut Toplitzer <pvrusb2@toplitzer.net>
Cc: linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

On 1/13/06, Helmut Toplitzer <pvrusb2@toplitzer.net> wrote:
>
> Hi!

Hi,

> I've got a question about a small experiment I made:
> I tried to find out the transfer-rate of my hd by useing
> hdparm -t /dev/hda
> and got changing transferrates starting from
>
> 37MB/s with CPU not utilized
> 55MB/s with CPU 100% utilized

I can't reproduce this locally, please send me your kernel
config.  Although I have Intel chipset it is still worth a try
if it is generic kernel bug.  I don't remember seeing anything
like that on my old VIA system which also had VT8235
southbridge - if somebody has similar machine to Helmut's
please try to reproduce this behavior (thanks!).

> 22MB/s with ehci-hcd loaded and a device already initilized
> 55MB/s with ehci-hcd loaded and CPU 100% utilized
> (see log1/log2)

As discussed in this thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111765523627674&w=2

It seems that the problem is caused by flakey USB chipset
thus IDE folks cannot do much about it, sorry.

David, can we get this issue documented somewhere?

> So is this supposed normal operation? Or is there
> something wrong with it?
> Even tried useing the lirc_dev and lirc_i2c kernel-modules
> from the lirc project (Infrared remote over usb) and got
> only 12MB/s on hda until using CPU with 100%.

also seems like USB caused problem

> So it looks like CPU/USB/IDE is in some interaction. Any
> ideas what to do against this. My current kernel is
> 2.6.15

Bartlomiej
