From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 10:11:26 +0100
Message-ID: <20111102091126.GG18903@elte.hu>
References: <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com>
 <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
 <4EAF2245.90308@zytor.com>
 <CA+55aFzedaAzzWfzhqVf8y8ZW0jeb56hZwdV3UodSp8Q_Qhc2A@mail.gmail.com>
 <7vvcr4ojvp.fsf@alter.siamese.dyndns.org>
 <CA+55aFyKWLUMQFfaeKJKGFPV_7kfOGjf+pSZ1Y8afzkT4OYQ9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyKWLUMQFfaeKJKGFPV_7kfOGjf+pSZ1Y8afzkT4OYQ9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Junio C Hamano <gitster@pobox.com>, "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And the receiving side would just do the "git pull" and 
> automatically just get notified that "Yes, this push has been 
> signed by key Xyz Abcdef"

If this approach is used then it would be nice to have a .gitconfig 
switch to require trusted pulls by default: to not allow doing 
non-signed or untrusted pulls accidentally, or for Git to warn in a 
visible, hard to miss way if there's a non-signed pull.

This adds social uncertainty (and an element of a silent alarm) to a 
realistic attack: the attacker wouldnt know exactly how the puller 
checks signed pull requests, it's kept private.

Thanks,

	Ingo
