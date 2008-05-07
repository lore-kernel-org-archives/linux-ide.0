From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
Subject: Re: Compact Flash Question
Date: Wed, 07 May 2008 17:01:54 +0200
Message-ID: <4821C462.2000108@free.fr>
References: <48215673.3060201@wpkg.org> <e2e108260805070044v42f596bbj39c5b52b6f0a096@mail.gmail.com> <48216039.3070001@wpkg.org> <4821A12F.2020800@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759538AbYEGPjc@vger.kernel.org>
In-Reply-To: <4821A12F.2020800@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Bart Van Assche <bart.vanassche@gmail.com>, LKML <linux-kernel@vger.kernel.org>, YSadgat1@gcte.com, linux-os@analogic.com, Alan <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

experience report :
In June 2004 we migrated to CF after bad hard disk crashes experience..=
=2E

Most of the CF do NOT do wear leveling, you have to ask the manufacture=
r
if it does it or not, generally it is called industrial... and normally=
,
cost much more .
So, for low cost cf I assume you have to do wear leveling with the
kernel ...otherwise it is already "wear leveling inside"
Since the technology evolves very fast it may be possible today that th=
e
production's cost of wear leveled CF will be the same as standard one
and wear leveling will be a standard ?


I think it should be possible to know if the Cf supports wear leveling
using the the identify device command (0xEC) and look at words 82 to 87=
=20
(cf. CF specifications http://www.compactflash.org/specdl1.htm)
Depending on the application, some system hacks like noatime... need to
be setted up.

we use  silicon systems CF  with wear leveling inside  , we write a few
kb data back each 1/4 h  on it.(log /tmp files  are redirected to ram)

Since June 2004 ALL  hard disk  systems based replaced with CF (env. 10=
0
units)   have not failed.

If somebody could report experience with other brand CF including wear
leveling , it will be fine
some other brand I know only the name :
www.apro-tw.com
http://www.afaya.com.tw/ (spec tells it supports wear leveling)


Best Regards
S.Ancelot

Helge Hafting a =C3=A9crit :
> Tomasz Chmielewski wrote:
>>
>> How does it work, then?
>> How can it do wear levelling over the whole CF if some (or most) are=
a
>> of CF is already used by our precious data/metadata?
>> It would have to know the areas where no data is stored, but it
>> contradicts the CF <-> filesystem separation.
> It don't necessarily need to know. It can swap two used blocks, one
> often-used and one
> rarely-used.  That way the rarely-used block is rewriten over the
> previously busy
> block, and the busy block is moved to the rarely used area that isn't
> worn.
> This implies an extra write whenever a busy block is moved.  Don't
> know if
> anybody do this, but the technique is simple enough.
>
> CF-filesystem separation is necessary, for they can't know in advance
> what
> filesystem or partitioning scheme will be used.  (I have ext3 on CF,
> for example...)
>
> Helge Hafting
>
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
