From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 10/62] ata: remove the second argument of
 k[un]map_atomic()
Date: Mon, 28 Nov 2011 13:00:12 -0600
Message-ID: <1322506812.5071.37.camel@dabdike.int.hansenpartnership.com>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>
	 <1322371662-26166-11-git-send-email-amwang@redhat.com>
	 <4ED35BFE.6080900@mvista.com> <4ED373C3.4050903@redhat.com>
	 <4ED37541.4040701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ED37541.4040701@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cong Wang <amwang@redhat.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 2011-11-28 at 19:49 +0800, Cong Wang wrote:
> =E4=BA=8E 2011=E5=B9=B411=E6=9C=8828=E6=97=A5 19:42, Cong Wang =E5=86=
=99=E9=81=93:
> > =E4=BA=8E 2011=E5=B9=B411=E6=9C=8828=E6=97=A5 18:01, Sergei Shtylyo=
v =E5=86=99=E9=81=93:
> >> Hello.
> >>
> >> On 27-11-2011 9:26, Cong Wang wrote:
> >>
> >>> Signed-off-by: Cong Wang<amwang@redhat.com>
> >>> ---
> >>> drivers/ata/libata-sff.c | 8 ++++----
> >>> 1 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> IMO, you should do this in a single patch, not piecemeal to keep t=
he kernel bisectable.
> >>
> >
> > Hi,
> >
> > Please see patch 01/62,
> >
> > https://lkml.org/lkml/2011/11/28/35
> >
> > So even without it, the kernel can still compile, just with some wa=
rnings.
> >
>=20
> Ah, no, sorry that I replied too quickly. We have to have at least 01=
/62
> to compile.
>=20
> Actually I did make the patches as a whole, but Andrew Morton prefers=
 to
> split them, so I make V2 of them.

I'd vote for as a whole as well, but if there's some legitimate reason
why not, then take them through Jiri's trivial tree; it's pretty trivia=
l
anyway and at least going that way would keep them bisectable.

James
