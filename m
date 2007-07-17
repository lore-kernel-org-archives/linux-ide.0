From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [git patches 1/2] warnings: attack valid cases spotted by warnings
Date: Tue, 17 Jul 2007 14:53:02 -0700
Message-ID: <ada8x9epuip.fsf@cisco.com>
References: <20070717214239.GF28448@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936330AbXGQVxV@vger.kernel.org>
In-Reply-To: <20070717214239.GF28448@devserv.devel.redhat.com> (Jeff Garzik's message of "Tue, 17 Jul 2007 17:42:39 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, chas@cmf.nrl.navy.mil, rolandd@cisco.com, dwmw2@infradead.org, gregkh@suse.de
List-Id: linux-ide@vger.kernel.org

 >     drivers/infiniband/hw/mthca/mthca_qp: kill uninit'd var warning
 >    =20
 >     drivers/infiniband/hw/mthca/mthca_qp.c: In function
 >       =E2=80=98mthca_tavor_post_send=E2=80=99:
 >     drivers/infiniband/hw/mthca/mthca_qp.c:1594: warning: =E2=80=98f=
0=E2=80=99 may be used
 >       uninitialized in this function
 >     drivers/infiniband/hw/mthca/mthca_qp.c: In function
 >       =E2=80=98mthca_arbel_post_send=E2=80=99:
 >     drivers/infiniband/hw/mthca/mthca_qp.c:1949: warning: =E2=80=98f=
0=E2=80=99 may be used
 >       uninitialized in this function
 >    =20
 >     Initializing 'f0' is not strictly necessary in either case, AFAI=
CS.
 >    =20
 >     I was considering use of uninitialized_var(), but looking at the
 >     complex flow of control in each function, I feel it is wiser and
 >     safer to simply zero the var and be certain of ourselves.
 >    =20
 >     Signed-off-by: Jeff Garzik <jeff@garzik.org>

I don't really like this.  These functions are in the hottest, most
latency-sensitive code path of this driver, which is used by people
who care about nanoseconds.  I'm quite confident that the code is
correct as written, and it really feels wrong to me to add bloat to
the fastpath just to cover up a shortcoming of gcc.

And I don't like using uninitialized_var() here for a similar
reason... the functions are complex and I would prefer to avoid hiding
future bugs that may creep in.  In fact adding the initialization to 0
has a similar effect, since it shuts up the compiler even if the logic
in the function gets screwed up.

On the other hand I definitely sympathize with the desire to have a
warning-free build so that real warnings are more visible.  I guess I
could live with the uninitialized_var() patch, although I would feel a
little sad.

 - R.
