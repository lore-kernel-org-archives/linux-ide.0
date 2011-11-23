From: Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: Crash with sata_sil24 driver
Date: Wed, 23 Nov 2011 10:49:00 +0530
Message-ID: <CAHM4w1nsNTQmAL-0d76O9cYXjNbiq-0f60Y3emWO2yf7HyFWDg@mail.gmail.com>
References: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com>
	<CAHM4w1nZ7GgutiuDiTCKu9wUuphn8qOiWgmCYVXXvwW1q8CgoA@mail.gmail.com>
	<20111122150613.GA322@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34068 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab1KWFTD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Nov 2011 00:19:03 -0500
In-Reply-To: <20111122150613.GA322@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>

Hello Tejun,


On Tue, Nov 22, 2011 at 8:36 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> (cc'ing Jesse)
>
> On Tue, Nov 22, 2011 at 04:40:40PM +0530, Pratyush Anand wrote:
>> > I am using various PCIe card based on Silicon Image 3124/3132 to
>> > test my PCIe host. This card is working with most of my host contr=
oler.
>> > I use sata_sil24 driver to enable the card, with one modification =
of
>> > commenting line [pcie_set_readrq(pdev, 4096);]
>> >
>> > I had sent a patch for it , which is still unanswered.
>> > http://comments.gmane.org/gmane.linux.kernel.pci/10300
>
> Yeah, that's something lifted from proprietary driver and it's
> likely to be wrong. =A0Jesse, is there a way to find out the safe
> maximum value for readrq? =A0I'm a bit reluctant to drop it as pcie
> variants of these chips are bottlenecked on the host bus pretty badly=
=2E
>
>> > Anyway, this mail is regarding another issue.
>> >
>> > I am still having problem when I use above driver (with above patc=
h),
>> > in following
>> > situation.
>> >
>> > My SOC is having cortex-a9 dual core. When I work with CPU freq 50=
0
>> > MHz, it works
>> > well. But with 600 MHz it crashes. Crash log is at the end of mail=
=2E
>> >
>> > I did further debugging. I found that if I put some delay after
>> > calling of sil24_init_controller(host); in function sil24_init_one=
, it
>> > works well.
>> >
>> > My question is.
>> > does sil24_init_controller insure perfact initilization?
>> > or we missing to check some status register which might be needed
>> > before ata_host_activate.
>> > ------------------------------------------------------------------=
----------------------------------------------
>> > Modules linked in:
>> > CPU: 0 =A0 =A0Not tainted =A0(2.6.37-lsp-3.2.2-rc-dirty #7)
>> > PC is at sil24_scr_read+0x38/0x50
>> > LR is at sil24_port_base+0x14/0x2c
>> > pc : [<80255e10>] =A0 =A0lr : [<80255d44>] =A0 =A0psr: 80000013
>
> Hmm... this is weird. =A0All init happens in the same thread. =A0Ther=
e's
> no race condition involved here. =A0I'm not too familiar with arm. =A0=
Can
> you please track down what is causing the crash? =A0ie. is it memory
> access to kernel data structure or io region?

It  is accessing SATA Controller registers rather kerenl data struct
at the time of crash.
It crashes when it tries to read SCR_CONTROL register.
Its really strage that same register become accesible if a delay of 10u=
s is
put after sil24_init_controller.

Regards
Pratyush

> Thanks.
>
> --
> tejun
>
