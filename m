From: Johan Herland <johan@herland.net>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 10 Nov 2011 17:03:17 +0100
Message-ID: <CALKQrgdxEXQGKQ3t9Sh82=U933ypHNg8duyVmG9uJbg2iST5fw@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org>
	<1319969101.5215.20.camel@dabdike>
	<CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
	<1320049150.8283.19.camel@dabdike>
	<CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
	<7vy5w1ow90.fsf@alter.siamese.dyndns.org>
	<CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
	<7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
	<CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
	<7vk47jld5s.fsf@alter.siamese.dyndns.org>
	<CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
	<CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
	<CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
	<CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
	<7v62j1gitn.fsf@alter.siamese.dyndns.org>
	<7vvcr1f38j.fsf@alter.siamese.dyndns.org>
	<CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
	<7v4nydurzh.fsf@alter.siamese.dyndns.org>
	<CALKQrgfZtELcK3H5ZYvmcW8RrtKMVRACFTvw3s5SidFvmFWkGw@mail.gmail.com>
	<7vaa84t3ek.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7vaa84t3ek.fsf@alter.siamese.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ted Ts'o <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Nov 10, 2011 at 16:15, Junio C Hamano <junio@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> On Wed, Nov 9, 2011 at 18:26, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> =C2=A0- "git notes" is represented as a commit that records a tree =
that holds
>>> =C2=A0 the entire mapping from commit to its annotations, and the o=
nly way to
>>> =C2=A0 transferr it is to send it together with its history as a wh=
ole. It
>>> =C2=A0 does not have the nice auto-following property that transfer=
s only the
>>> =C2=A0 relevant annotations.
>>
>> True. However, consider these mitigating factors:
>> ...
>>
>> My point is that although "notes" might end up transferring more
>> annotations than strictly necessary, I believe that in practice all =
the
>> notes being transferred are already (or will soon become) relevant.
>
> Sorry, but I do not think you are considering what would happen when =
you
> have many branches with different purposes, whose commits near tips w=
ill
> never get merged with each other. "automatic following" semantics lik=
e
> what "git fetch" does for signed tags is absolutely necessary in such=
 a
> case, and the above are not mitigating factors at all in that context=
=2E

What about having one notes ref per branch? If/when the branch is merge=
d,
the associated notes ref containing the annotations for the commits on =
that
branch would be merged as well (using "git notes merge").

Sure, using one notes ref per branch is more expensive than a single no=
tes
ref, but it's still cheaper than one ref per signed commit (which is wh=
at we
get when using annotated tags). And it prevents the added code and
complexity of the timestamped mapping approach.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
