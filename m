From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches 1/2] warnings: attack valid cases spotted by warnings
Date: Tue, 17 Jul 2007 18:10:46 -0400
Message-ID: <469D3E66.3010502@garzik.org>
References: <20070717214239.GF28448@devserv.devel.redhat.com> <ada8x9epuip.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50143 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757991AbXGQWK4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jul 2007 18:10:56 -0400
In-Reply-To: <ada8x9epuip.fsf@cisco.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roland Dreier <rdreier@cisco.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, chas@cmf.nrl.navy.mil, rolandd@cisco.com, dwmw2@infradead.org, gregkh@suse.de

Roland Dreier wrote:
>  >     drivers/infiniband/hw/mthca/mthca_qp: kill uninit'd var warnin=
g
>  >    =20
>  >     drivers/infiniband/hw/mthca/mthca_qp.c: In function
>  >       =E2=80=98mthca_tavor_post_send=E2=80=99:
>  >     drivers/infiniband/hw/mthca/mthca_qp.c:1594: warning: =E2=80=98=
f0=E2=80=99 may be used
>  >       uninitialized in this function
>  >     drivers/infiniband/hw/mthca/mthca_qp.c: In function
>  >       =E2=80=98mthca_arbel_post_send=E2=80=99:
>  >     drivers/infiniband/hw/mthca/mthca_qp.c:1949: warning: =E2=80=98=
f0=E2=80=99 may be used
>  >       uninitialized in this function
>  >    =20
>  >     Initializing 'f0' is not strictly necessary in either case, AF=
AICS.
>  >    =20
>  >     I was considering use of uninitialized_var(), but looking at t=
he
>  >     complex flow of control in each function, I feel it is wiser a=
nd
>  >     safer to simply zero the var and be certain of ourselves.
>  >    =20
>  >     Signed-off-by: Jeff Garzik <jeff@garzik.org>
>=20
> I don't really like this.  These functions are in the hottest, most
> latency-sensitive code path of this driver, which is used by people
> who care about nanoseconds.  I'm quite confident that the code is
> correct as written, and it really feels wrong to me to add bloat to
> the fastpath just to cover up a shortcoming of gcc.

I don't buy that performance argument, in this case.  You are already=20
dirtying the same cacheline with other variable initializations.

Like I noted in the changeset description (hey, this is precisely why I=
=20
included it, so that we could have this discussion), IMO the flow of=20
control makes it not only impossible for the compiler to understand the=
=20
full value range of 'f0', but also difficult for humans as well.

I could perhaps understand initializing the variable to some poison=20
value rather than zero, but IMO the code is stronger with f0 set to a=20
sane value.

It's poorly readable, poorly commented code as-is.

	Jeff



