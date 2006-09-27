From: Tejun Heo <htejun@gmail.com>
Subject: Re: dvd-r detection problem with port multiplier
Date: Wed, 27 Sep 2006 16:24:27 +0900
Message-ID: <451A272B.60500@gmail.com>
References: <KMS--2023338046-2588@mail.norwalkdist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:30711 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965421AbWI0HYd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Sep 2006 03:24:33 -0400
Received: by nz-out-0102.google.com with SMTP id n1so28851nzf
        for <linux-ide@vger.kernel.org>; Wed, 27 Sep 2006 00:24:32 -0700 (PDT)
In-Reply-To: <KMS--2023338046-2588@mail.norwalkdist.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Trent George <trent@norwalkdist.com>
Cc: linux-ide@vger.kernel.org

Hello,

Trent George wrote:
> sorry to be a pest with this.
> Hopefully this helps though..

Don't be sorry.  You're helping a lot.

[--snip--]
> that patch did not work for me.
> 
> this folling patch did work for me. (I moved the one line fix
> into the sil24_init_port function, compared to before)
> 
> I wonder if the processer speed makes a difference ?
> I'am on a intel 820 D dual core 2.8ghz
> 
> I believe the problem is based on a failing PRB_CTRL_SRST, 
> while the PORT_CS_INIT is still in progress.
> Even though the PORT_CS_RDY comes ready quickly.

PORT_CS_INIT is "Port Initialize" and is internal (re-)initialization. 
It doesn't issue anything to outside of the controller silicon.  It 
simply makes the chip forget about pending commands and internal state 
and ready for the next command.  So, I'm a bit surprised that slow 
device has affect on it.  It's described in 7.3.3 Bit[2].

> I think you can not send another pmp command until the last 
> one completes (seems the init is slow on some bridgeboards)

Not only that, from the result it seems the whole controller is locked 
up after such sequence.

> the plextor finsihed in 12/250 seconds, the pioneer in 84/250 sec
> The other option is a msleep(1000); in the do_softrest after
> the init_port.

I see.

> It seems you can also monitor the PORT_SACTIVE register with a 
> ata_wait_register(port + PORT_SACTIVE, 1, 1, 10, 1000);
> to do the same thing.

I'm just curious what PORT_SACTIVE or Active Slot field has to do with 
PORT_CS_INIT.  Maybe it's some internal detail.....

> all in all, it is VERY hard to fix without the same revision
> hardware, as if you can't duplicate it, you cant fix it.
> The spec does not really tell you what will happen on a init
> while in pmp mode. it shows a different enumeration method
> than the driver uses for pmp ...
> 
> Plus the plextor is very fast, and one slow device, messes it
> up for all the other devices.
> 
> it seems this may not be optimum on non-pmp hardware though.
> my vote would be for the msleep for compatability

I'll contact simg and ask them about the problem and incorporate 
whatever fix they recommend to next iteration of PMP patches.  I hope 
you'll be around to test it.  :-)

[--snip--]
> here is a dmesg output of the bad and good version
> the bad version, just cycles through reseting seamingly "forever"

Well, it gives up link by link.  As the timeout is quite long and all 
links fail, it takes quite some time but it isn't forever.  This will be 
improved in the future.

[--snip--]
> not to get off topic, but
> this was from SiI-DS-0113_3124-1_full.pdf
> 5.4.6 Interrupts and Command Completion
> talked about the multi interrupt lines. 

Ah... that one.  Now I remember.  Yeah, sil24 can do 4 IRQs using 
INTA-D, which is pretty interesting, but I don't think off-the-shelf IO 
add-on cards actually connect them.  Even if there is card which do, I 
think we'll need to jump through some loops to get IRQ routing right. 
INTA-D lines aren't supposed to be used like that after all.  I think 
that's why the doc says "In certain embedded environments,...".

Thanks.

-- 
tejun
