From: Fredrik Sjoholm <fredrik@sjoholm.com>
Subject: Re: libata SATA support for Sil 3726 port multiplier
Date: Wed, 12 Jul 2006 02:17:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0607111807240.23635@mail.ezic.com>
References: <Pine.LNX.4.64.0607040538040.12712@mail.ezic.com>
 <44B3D0B6.7070506@coplanar.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ezic.com ([216.33.71.68]:45448 "HELO mail.ezic.com")
	by vger.kernel.org with SMTP id S932349AbWGLCRj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jul 2006 22:17:39 -0400
In-Reply-To: <44B3D0B6.7070506@coplanar.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Jackson <jerj@coplanar.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


Hi,

The 3726 multiplier is in fact built into an external box:

 	http://www.datoptic.com/cgi-bin/web.cgi?product=Sbox-P&detail=yes

I connected the box with the 3726 multiplier to a 3132 based pci-x card 
via an eSATA cable.

There is one remaining quirk which i didn't notice before emailing you the 
mini-fix: When booting cold, the spin-up of each drive happens 
sequentially and the 5 second retry isn't enough for each drive to get 
ready. This wouldn't have been a problem except for the fact that even the 
latest version (7.3.13) of the Sil3132 BIOS doesn't bother detecting and 
spinning-up anything except the 1st drive on the multiplier. On subsequent 
bootups, with drives already spinning, it work right away.

I guess it would be nice to spin-up all drives in rapid succession, and 
then retry them all at once every few seconds, but all i did was to 
increase the timeout to 15 seconds which works too.


here are the dmesg outputs:

1. warm start, everything ok:

 	http://www.sjoholm.com/sata/dmesg.warmspin-ok

2. cold start, 5 second timeouts. only 1st drive usable:

 	http://www.sjoholm.com/sata/dmesg.spinup5-fail

3. cold start, ssleep(15)'s in libata-eh.c, all drives ok:

 	http://www.sjoholm.com/sata/dmesg.spinup15-ok


fredrik



On Tue, 11 Jul 2006, Jeremy Jackson wrote:

> What device do you have with a 3726?  I have tried contacting Silicon Image 
> directly, but they do not know of any products that are *not* external eSATA 
> enclosures.  If anyone knows of these (for sale - not demo boards), I'd like 
> to hear about it.
>
> Fredrik Sjoholm wrote:
>>
>>  Hello Jeff,
>>
>>  i'm using your libata SATA PMP support with a Sil 3132 chip + 3726 port
>>  multiplier with 5 drives. in order to get it to work, i had to make the
>>  following addition in ata_pm_quirks() [libata-pm.c]
>
>
