From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 16:42:22 -0700
Message-ID: <CA+55aFxeMgpVDPJ1aEza5oeKYhBTbbZQ4wdjVG-t8MFBjuOK7w@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vsjm6gkte.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54193 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1KBXmp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2011 19:42:45 -0400
In-Reply-To: <7vsjm6gkte.fsf@alter.siamese.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Nov 2, 2011 at 4:34 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> You keep saying cut-and-paste, but do you mind feeding the e-mail tex=
t
> itself to a tool, instead of cut-and-paste?

=46eeding the email to a tool is actually a fair amount of extra work.
It would have worked well in the days when I used text-based email
clients that just had a "pipe email to command" model, but that's long
gone.

In contrast, cut-and-paste to another program is easy - but then you
really can't depend on whitespace or headers or other subtle things.

> A respond-to-request-pull wrapper you would use could be:
>
> =A0- Get the e-mail from the standard input;
> =A0- Pick up the signed bits and validate the signature;
> =A0- Perform the requested fetch; and
> =A0- Record the merge (or prepare .git/MERGE_MSG) with both the signe=
d bits.

So is there any reason this couldn't be cut-and-paste? Make the signed
part small (*not* including diffstat and shortlog), and make it
whitespace-safe, and I wouldn't mind a tool at all.

If it *can* take the whole email, that would probably be a good design
(so that a "pipe email to command"  model would still work), but it
would be much better if it doesn't require it.

> and the "signed bits" could include:
>
> =A0 - the repository and the branch you were expected to pull;
> =A0 - the topic description.
>
> among other things the requestor can edit when request-pull message i=
s
> prepared.

One thing I'd like is that it would also fire up an editor for the
merge, even if it gets the topic description from the email or
cut-and-paste. I often want to fix up peoples grammar etc. That's a
separate argument for trying to keep the signed part minimal - because
 I really don't want to have to maintain spelin errors just because
they are part of what was signed..

                  Linus
