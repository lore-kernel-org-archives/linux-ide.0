From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Drives missing at boot
Date: Tue, 3 Aug 2010 11:47:25 -0700
Message-ID: <AANLkTi=bKn3t8eD=n8tDeZrn-mXsEzFHGj46-Z5U9EGA@mail.gmail.com>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>
	<AANLkTinBn35687znO2_IxI3s1opkXrG2HpCRgsejNbMq@mail.gmail.com>
	<4C2F61AB.9030806@kernel.org>
	<AANLkTilYOT45q8OUJ-_V61_fnYy9HIk6GAv5ZPiomCaT@mail.gmail.com>
	<4C317C04.20500@kernel.org>
	<AANLkTilupyieml9yaWO9BUNPmQQ0g2w1HLWj6R9MwDZf@mail.gmail.com>
	<4C32CE50.6010501@kernel.org>
	<AANLkTikehTO1j6Gd7Y_g32_P6Yg9KB8Z8qwbNJh10aOU@mail.gmail.com>
	<4C341598.6040004@kernel.org>
	<AANLkTik4zkcIyVxwtX8GA1BsQSZaAeODpPlY3mRVBc-4@mail.gmail.com>
	<4C34A1D5.1090202@kernel.org>
	<AANLkTilgQSu3qi7qoTtjnV22r-8Sh1hbDAB_nlPImWNt@mail.gmail.com>
	<4C34B8BE.5080504@kernel.org>
	<AANLkTilDbrA6lLPSOAtA8_4mLNkUZibHweTliqU5jd03@mail.gmail.com>
	<4C44BD42.3030904@kernel.org>
	<7141c88bc8c27f26c2187252c0594318.squirrel@thechecks.ca>
	<4C45AF40.7030800@kernel.org>
	<AANLkTinxDjPCk46eItZrXziTbf6efqvNNNTbkZDXIbns@mail.gmail.com>
	<4C483BF4.3090006@kernel.org>
	<AANLkTinwJLE=jjwG5zL8UBO91tzDpX36_W9GORKag8RK@mail.gmail.com>
	<20100803114105.7f199878.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61692 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565Ab0HCSr1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Aug 2010 14:47:27 -0400
Received: by wwj40 with SMTP id 40so5504285wwj.1
        for <linux-ide@vger.kernel.org>; Tue, 03 Aug 2010 11:47:25 -0700 (PDT)
In-Reply-To: <20100803114105.7f199878.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, Paul Check <paul@thechecks.ca>, Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Tue, Aug 3, 2010 at 11:41 AM, Randy Dunlap <randy.dunlap@oracle.com>=
 wrote:
> On Mon, 2 Aug 2010 15:07:11 -0700 Mark Knecht wrote:
>
>> On Thu, Jul 22, 2010 at 5:39 AM, Tejun Heo <tj@kernel.org> wrote:
>>
>> Hi Tejun,
>> =C2=A0 =C2=A0I'm finally home and trying to get back to this. I'm re=
ally a bad
>> programmer so I don't know what I've done wrong but it seems patch
>> isn't happy with me.
>>
>> c2stable linux # patch --dry-run -p1 <../ata_piix-sidpr-lock.patch
>> patching file drivers/ata/ata_piix.c
>> patch: **** malformed patch at line 13:
>
> Whenever the patch file was saved on this system, line 13 of it was
> split (probably by an email client). =C2=A0Whenever I see this, I jus=
t
> join (merge) that line and the next one and try again... sometimes
> several lines are malformed and have to be fixed like this.
>

Randy,
   Could very well be what happened. I added line 13 (the printk) by ha=
nd

<SNIP - ORIGINAL PATCH FILE>
struct piix_host_priv {
 =C2=A0 =C2=A0 =C2=A0 const int *map;
 =C2=A0 =C2=A0 =C2=A0 u32 saved_iocfg;
+ =C2=A0 =C2=A0 =C2=A0 spinlock_t sidpr_lock; =C2=A0/* FIXME: remove on=
ce locking in EH is fixed */
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *sidpr;
};

<SNIP - MY CHANGE BY HAND>
struct piix_host_priv {
       const int *map;
       u32 saved_iocfg;
+       spinlock_t sidpr_lock;  /* FIXME: remove once locking in EH is =
fixed */
+       printk("MWK - ata_sidpr patch applied!\n");
       void __iomem *sidpr;
};

Maybe I should have just put it on the same line as the previous
spinlock command?

I'll play with it and see if I can get it working.

Thanks,
Mark
