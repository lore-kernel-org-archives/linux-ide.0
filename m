From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 15:30:32 -0700
Message-ID: <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57672 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab1JaWaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2011 18:30:55 -0400
In-Reply-To: <4EAF1F40.3030907@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Oct 31, 2011 at 3:20 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Perhaps we should introduce the notion of a "private tag" or somethin=
g
> along those lines? =A0(I guess that would still have to be possible t=
o
> push it, but not pull it by default...)

All tags are private by default.

We actually *only* fetch tags if somebody explicitly asks for them
(--tags), or when fetching from a named remote (and even then it will
only fetch tags that point to objects you fetched by default iirc -
you have to mark the remote specially to get *all* tags).

But if you do the normal "git pull git://git.kernel.org/name/of/repo"
- which is how things happen as a result of a pull request - you won't
get tags at all - you have to ask for them by name or use "--tags" to
get them all.

                   Linus
