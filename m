From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: RFC Patch: Use x86 init_hwif in the alim15x3 for x86-like PowerPC
	systems
Date: Thu, 16 Apr 2009 23:27:34 +0200
Message-ID: <c8485d470904161427w31ff313dsb651aa1f53bbacea@mail.gmail.com>
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com>
	 <c8485d470904150734s47ce0f27y3ae984355e823d9f@mail.gmail.com>
	 <200904162130.01237.bzolnier@gmail.com>
	 <20090416205735.GA26519@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:59251 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbZDPV1f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Apr 2009 17:27:35 -0400
Received: by bwz17 with SMTP id 17so622827bwz.37
        for <linux-ide@vger.kernel.org>; Thu, 16 Apr 2009 14:27:34 -0700 (PDT)
In-Reply-To: <20090416205735.GA26519@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Thu, Apr 16, 2009 at 10:57 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Apr 16, 2009 at 09:30:00PM +0200, Bartlomiej Zolnierkiewicz w=
rote:
>>
>> Hi,
>>
>> On Wednesday 15 April 2009 16:34:22 Roderick Colenbrander wrote:
>> > Hi,
>> >
>> > I'm using a Xilinx ML510 it features a PowerPC 440 cpu inside a
>> > Virtex-5 FPGA. The board also contains a ALI M1533 south bridge
>> > for IDE, USB and Audio. I did a lot of work to get the pci bus wor=
king
>> > on this board and it works correctly but the default init code
>> > of the alim15x3 driver doesn't work for me. The driver explicitly
>> > disabled some initialization code for powerpc after uncommenting t=
his
>> > code it works properly. Benjamin Herrenschmidt and I think this
>> > !CONFIG_PPC check should be removed because the system behaves
>> > like a real 'x86' system (also the i8259 interrupt controller is u=
sed).
>>
>> Ben, I guess you are OK with the change and there are no longer othe=
r
>> platforms requiring CONFIG_PPC check below? =A0[I don't see your ACK=
 here]
>
> I'd like to nak this patch. It'll break MPC8610HPCD boards.
>
> See commit 6d1cee44361b8d06ccd1812e80448d86ae60dfe3
>
> I'm not sure how should we handle this for Xilinx PPC, MPC8610
> PPC and Sparc all at the same time, but it's obvious that #ifdef
> isn't enough any longer...
>
>
>

If it is really a board specific issue (in case of powerpc it appears
to be one) we could also use the default_irq override in ppc_md. What
do you think?

Roderick
