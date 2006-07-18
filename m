From: Fredrik Sjoholm <fredrik@sjoholm.com>
Subject: Re: libata SATA support for Sil 3726 port multiplier
Date: Tue, 18 Jul 2006 23:55:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0607182348410.25060@mail.ezic.com>
References: <Pine.LNX.4.64.0607040538040.12712@mail.ezic.com>
 <44B3D0B6.7070506@coplanar.net> <Pine.LNX.4.64.0607111807240.23635@mail.ezic.com>
 <44BD72BD.70105@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ezic.com ([216.33.71.68]:31368 "HELO mail.ezic.com")
	by vger.kernel.org with SMTP id S932420AbWGRXzW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jul 2006 19:55:22 -0400
In-Reply-To: <44BD72BD.70105@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeremy Jackson <jerj@coplanar.net>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org



Hi,

i already downloaded the 2.6.17.4 verion patch a few days ago, and it's 
working perfectly. i haven't tried it with any drives unplugged yet, which 
i had planned to do since i saw that you hardcoded the fan-out to 5 
drives. although i'm sure it'll still detect having less than 5 actual 
drives plugged into the multiplier elsewhere in the code.

if there's any special case you'd like me to test, i'd be happy to (oh no, 
another reboot... ;-)

fredrik


On Tue, 18 Jul 2006, Tejun Heo wrote:

> Hello, Fredrik.
>
> Fredrik Sjoholm wrote:
>>
>>  Hi,
>>
>>  The 3726 multiplier is in fact built into an external box:
>>
>>      http://www.datoptic.com/cgi-bin/web.cgi?product=Sbox-P&detail=yes
>>
>>  I connected the box with the 3726 multiplier to a 3132 based pci-x card
>>  via an eSATA cable.
>>
>>  There is one remaining quirk which i didn't notice before emailing you the
>>  mini-fix: When booting cold, the spin-up of each drive happens
>>  sequentially and the 5 second retry isn't enough for each drive to get
>>  ready. This wouldn't have been a problem except for the fact that even the
>>  latest version (7.3.13) of the Sil3132 BIOS doesn't bother detecting and
>>  spinning-up anything except the 1st drive on the multiplier. On subsequent
>>  bootups, with drives already spinning, it work right away.
>>
>>  I guess it would be nice to spin-up all drives in rapid succession, and
>>  then retry them all at once every few seconds, but all i did was to
>>  increase the timeout to 15 seconds which works too.
>
> Yes, we have yet to implement staggered spinup support with someway to 
> control the number of concurrently spun up devices.  It's on my agenda.  SATA 
> staggered spinup is enabled by loading certain pin in the power connector 
> during power-up.  So, it is the enclosure which determines whether staggered 
> spin-up is enabled or disabled.  Your enclosure may have a dip switch or 
> something to control that.
>
>>  here are the dmesg outputs:
>>
>>  1. warm start, everything ok:
>>
>>      http://www.sjoholm.com/sata/dmesg.warmspin-ok
>>
>>  2. cold start, 5 second timeouts. only 1st drive usable:
>>
>>      http://www.sjoholm.com/sata/dmesg.spinup5-fail
>>
>>  3. cold start, ssleep(15)'s in libata-eh.c, all drives ok:
>>
>>      http://www.sjoholm.com/sata/dmesg.spinup15-ok
>
> Can you try new version and see how it acts?
>
> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060710.tar.bz2
>
> It probably won't fix the problem but hardreset implementation has changed 
> and it would help me understanding how spinning up device acts.  Also, 
> turning on CONFIG_PRINTK_TIME (Kernel Hacking -> Show timing information on 
> printks) will be nice.
>
> Thanks.
>
> -- 
> tejun
>
>
>
