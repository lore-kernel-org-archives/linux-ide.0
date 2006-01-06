From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: USB EHCI VIA disconnect problem
Date: Fri, 6 Jan 2006 09:59:00 +0100
Message-ID: <200601060959.00891.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:45711 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S932173AbWAFI7N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jan 2006 03:59:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by toplitzer.net (SX Mail) with ESMTP id 595F8BC40
	for <linux-ide@vger.kernel.org>; Fri,  6 Jan 2006 09:58:54 +0100 (CET)
Received: from [10.0.0.140] (pc057-adsl.adsl.uni-klu.ac.at [143.205.236.57])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by toplitzer.net (SX Mail) with ESMTP id 6EB04BBE9
	for <linux-ide@vger.kernel.org>; Fri,  6 Jan 2006 09:58:53 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi!

I forward this mail to this list because there might be a connection to
the VIA IDE drivers. Maybe the two described problems are related,
maybe not. Transferrates experiment is however influenced by ehci-hcd.
In one post from Alan Stern it's however noticed that the disconnect
problem maybe solved in an other way.

The mail originates on the linux-usb-devel list:
http://marc.theaimsgroup.com/?l=linux-usb-devel&w=2&r=1&s=USB+EHCI+VIA&q=b

Maybe someone has at least an explanation about this.

TIA
Helmut

----------  Forwarded Message  ----------

Subject: Re: [linux-usb-devel] Re: [Linux-usb-users] USB EHCI VIA disconnect 
problem
Date: Thursday 05 January 2006 23:09
From: Helmut Toplitzer <pvrusb2@toplitzer.net>
To: scalfee@healthhero.com
Cc: linux-usb-devel@lists.sourceforge.net, Rene Herman 
<rene.herman@keyaccess.nl>, David Brownell <david-b@pacbell.net>

Ok because of the long thread a short summary:

My transferrate tests were running on a normal IDE device.

VIA IDE, USB and so on ... systems are intefering.
USB-system affects IDE system, sometimes in
a dramatic way (diff. 20MB/s on IDE transferrate).

Beside this sometimes the ehci-driver disconnects USB devices
without any reason. This is a big problem in streaming data etc.
It looks like this:
22:36 kernel: hub 4-0:1.0: state 5 ports 6 chg 0000 evt 0008
22:36 kernel: ehci_hcd 0000:00:10.3: GetStatus port 3 status 00180b POWER
sig=j PEC \
CSC CONNECT 22:36 kernel: hub 4-0:1.0: port 3, status 0501, change 0003, 480
Mb/s
22:36 kernel: usb 4-3: USB disconnect, address 2
22:36 kernel: usb 4-3: usb_disable_device nuking all URBs
22:36 kernel: ehci_hcd 0000:00:10.3: shutdown urb ca6e53c0 pipe c0420280
ep4in-bulk
22:36 kernel: ehci_hcd 0000:00:10.3: shutdown urb ca6e5440 pipe c0420280
ep4in-bulk
22:36 kernel: ehci_hcd 0000:00:10.3: shutdown urb ce69ce20 pipe c0420280
ep4in-bulk
22:36 kernel: ehci_hcd 0000:00:10.3: shutdown urb c0417f60 pipe c0420280
ep4in-bulk
....


All VIA motherboards with the IDE problem have
the problem with the disconnects to (AFAIK).
That's the story. It was startet by Rene Hermann on linux-devel without
solution, when I came up with my usb-disconnect problem and we found
the similarities about this. See the same thread on linux-usb-user
http://marc.theaimsgroup.com/?t=113506436100003&r=1&w=2
and thread "External USB2 HDD affects speed hda"
http://marc.theaimsgroup.com/?t=111749614000002&r=1&w=2
on linux-devel about this.

So. The question is: How broken is the VIAchipset/driver/etc.
How to solve this? What's the role of the usb-driver in this story.

- E.g. Loading/Unloading ehci-hcd uhci-hcd affects ide-transferrates.
- Making the CPU utilized !!!increases!!!! the IDE transfer rate.
- Streaming data on ehci-hcd causes disconnects of devices after some time.

Normal IDE transferrate                 : 36MB/s
lircd with lirc_i2c and lirc_dev loaded : 14MB/s
ehci-hcd loaded and once used           : 22MB/s
cpu 100% utilized                       : 55MB/s

This is "just" doubling transfer rates with a snip.
So whats going on here? It looks like DMA/BusMastering is
taking place when CPU is utilized (Not realy knowing).
But what happens when ehci-hcd, lircd are loaded which only use the
usb-system?

Any ideas?

Helmut

--
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656

-------------------------------------------------------
