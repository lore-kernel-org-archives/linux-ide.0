From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Possible performance issue with sata_sil og Gigabyte i-Ram
Date: Tue, 23 Jan 2007 17:12:30 -0500
Message-ID: <45B6884E.3030100@garzik.org>
References: <20070123205301.GK1054@nixx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51270 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933134AbXAWWMf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Jan 2007 17:12:35 -0500
In-Reply-To: <20070123205301.GK1054@nixx.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Oddbj=F8rn_Kvalsund?= <oddbjorn@nixx.no>
Cc: linux-ide@vger.kernel.org

Oddbj=F8rn Kvalsund wrote:
> Hi,
>=20
> I recently purchased a Gigabyte i-Ram GC Ramdisk after reading some
> quite impressive reviews online. Getting the card up and running
> connected to a ST Lab A-223 Serial ATA PCI Card (sil3114 using sata_s=
il)
> with kernel 2.6.19.1 was quite easy, thanks guys!
>=20
> Access times on this thing are great, but I seem to be hitting some
> strange performance-issues when doing large reads/writes. "hdparm -t
> /dev/sda" gives me 80-82 MB/s on average and bonnie++ (see link to
> complete output below) confirms these results.  My simple stdio
> C-program gives write-speeds of around 70 MB/s. =20
>=20
> Other people using this device report of read/write speeds constantly
> maxing out their SATA150 or PCI-bus. Is this my sil3114 being the
> bottleneck? Other devices on the PCI-bus? My general system (see link=
 to
> the complete output of lspci and /proc/cpuinfo below)? Or is this som=
e
> glitch in the iRam + sil3114 combination?

=46WIW, I have nothing but trouble with the gigabyte i-RAM.  I thought =
it=20
was the coolest device in the world, and bought one as soon as I found =
one.

However, I am unable to keep it from corrupting data.  I primarily use=20
it on sil3114, just like your hardware, but I have the same problems=20
with other controllers.

My gut feeling is that the i-RAM has very strict RAM model requirements=
,=20
and needs the latest firmware, but I have not yet tested these hypothes=
es.

I would love to get it working too...

	Jeff



