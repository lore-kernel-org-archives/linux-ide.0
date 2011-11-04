From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 04 Nov 2011 13:16:08 -0700
Message-ID: <7vlirvbq47.fsf@alter.siamese.dyndns.org>
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
 <CA+55aFzstE-+NzfSAWMEokB7-rYsZOcZe9Ez-LxPNOKnciJ3UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzstE-+NzfSAWMEokB7-rYsZOcZe9Ez-LxPNOKnciJ3UQ@mail.gmail.com> (Linus
 Torvalds's message of "Wed, 2 Nov 2011 19:19:34 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I suspect we should just apply this patch, but I didn't check
> exacty what the failed tests are - except for the first one, that just
> compares against a canned response (and the canned response should
> just be changed).

After applying your patch and running

$ perl -pi -e 'if (/\ttag /) {
    s/754b754407bf032e9a2f9d5a9ad05ca79a6b228f/6c9dec2b923228c9ff994c6cfe4ae16c12408dc5/;
    s/0567da4d5edd2ff4bb292a465ba9e64dcad9536b/c61a82b60967180544e3c19f819ddbd0c9f89899/;
    s/6134ee8f857693b96ff1cc98d3e2fd62b199e5a8/525b7fb068d59950d185a8779dc957c77eed73ba/;
}' t/t5515/fetch.*

to unpeel the three tags used in the test 5515 that used to expect
FETCH_HEAD to have peeled tags to expect tag objects themselves instead,
all tests passes.

> although I suspect it was just a fairly mindless case of "make it a
> commit, because the merge needs the commit" - never mind that the
> merge would peel it anyway.

I am 100% sure the machinery that comes up with the tree (or half-merged
conflicted state) does not mind being fed tags. After all they need to
peel them down to commits for common ancestor discovery, and they need to
further peel them down to trees to perform three-way merges.

However we would need to audit so that we do not accidentally record the
tag object names in the "parent" headers in the merge commits, which is
what I'll be doing next.
