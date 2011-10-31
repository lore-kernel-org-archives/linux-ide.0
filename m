From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 15:51:06 -0700
Message-ID: <7vvcr4ojvp.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com>
 <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
 <4EAF2245.90308@zytor.com>
 <CA+55aFzedaAzzWfzhqVf8y8ZW0jeb56hZwdV3UodSp8Q_Qhc2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934617Ab1JaWvI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Oct 2011 18:51:08 -0400
In-Reply-To: <CA+55aFzedaAzzWfzhqVf8y8ZW0jeb56hZwdV3UodSp8Q_Qhc2A@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 31 Oct 2011 15:38:54 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But seriously, I don't care about the *implementation* all that much.
> If people want to use the crazy git "notes" capability, you can do
> that too, although quite frankly, I don't see the point.

As I already said, I do not think notes is a good match as a tool to do
this.

> matters is that "git push" and "git pull" would JustWork(tm), and
> check the signature if one exists, without having to cut-and-paste
> data that simply shouldn't be visible to the user.
>
> I abhor the interface Ingo suggested, for example....

Some cut-and-paste (or piping the e-mail to a command) would be necessary
evil, though, as you would have GPG keys from more than one trusted person
in your keyring, and when you are responding to a pull-request from person
A, finding a valid commit signed by person B should not be a success, but
at least should raise a warning.
