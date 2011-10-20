From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/28 v6] m68k: Convert to genirq
Date: Thu, 20 Oct 2011 17:02:57 +0200
Message-ID: <CAMuHMdVMp65XzV2zu7V8sgwsniCAxD7NDDnHSvp5gO-8g1ovHg@mail.gmail.com>
References: <1315742394-16036-1-git-send-email-geert@linux-m68k.org>
	<CAMuHMdWOhKcoDoyTnKJzruZ=gpV5uKNFpXnGCkrac7oEkCihJw@mail.gmail.com>
	<alpine.LNX.2.00.1110202347320.2696@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1110202347320.2696@nippy.intranet>
Sender: linux-kernel-owner@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Oct 20, 2011 at 15:40, Finn Thain <fthain@telegraphics.com.au> =
wrote:
> On Thu, 20 Oct 2011, Geert Uytterhoeven wrote:
>
>> > There are some known issues with drivers, which Finn and Michael a=
re
>> > looking into.
>>
>> Any fixes I still have to apply?
>
> I did some further testing on Baboon and OSS hardware etc. and I didn=
't
> find any new regressions to fix.
>
> There is a cleanup patch though --
> http://article.gmane.org/gmane.linux.ports.m68k/2726

OK, I'll add it.

>> Updated, on top of m68k master (which is at v3.1-rc10 now).
>> http://git.kernel.org/?p=3Dlinux/kernel/git/geert/linux-m68k.git;a=3D=
shortlog;h=3Drefs/heads/m68k-genirq
>>
>> If noone objects, I'd like to add this to the m68k master and for-3.=
2
>> branches.
>
> Sounds good. The mac_esp fix I sent is already in linux-next.

Thanks for reminding me I still have to apply that one :-)

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
