From: Valerio Passini <valerio.passini@unicam.it>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Mon, 27 Oct 2008 11:14:28 +0100
Message-ID: <200810271114.28986.valerio.passini@unicam.it>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810262101.42874.valerio.passini@unicam.it> <20081027061556.GA17928@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.unicam.it ([193.204.8.1]:59865 "HELO unicam.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753235AbYJ0KOg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 06:14:36 -0400
In-Reply-To: <20081027061556.GA17928@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, valerio.p@libero.it, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org

Alle luned=EC 27 ottobre 2008, Borislav Petkov ha scritto:
> On Sun, Oct 26, 2008 at 09:01:42PM +0100, Valerio Passini wrote:
>=20
> [.. ]
>=20
> > Here I am, thus the patched kernel has been installed and tested.
> > Burning CD's and simulation work perfectly and everything seems fin=
e.
> > :)
>=20
> Well, nice to hear :). Thanks for your debugging effort and patience.

My pleasure!

> > The most mysterious part for me (as I wrote before), ide-cd sets
> > dma_alignment to 31 and dma_pad_mask to 15. So the current code
> > enables DMA if data_len is a multiple of 32. The old code enables D=
MA
> > if data_len is a multiple of 16.
>=20
> Of course, 'multiple of' description is wrong. Should have been
> 32-byte and 16-byte alignment respectively.

If you have another patch that solves the problem and you want to try i=
t, just send it to me, I will be glad to test it. Bye
