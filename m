From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
Date: Wed, 21 Nov 2018 23:33:44 +0800
Message-ID: <CAEExFWsLP0oJVDV1KBENwsFKZ52ygZ18DQp1g1ah4a1ZmxeJLw@mail.gmail.com>
References: <20181121130439.22255-1-tiny.windzz@gmail.com> <e45f832b-ef98-e419-6082-27dd7ced71d2@cogentembedded.com>
 <CAEExFWvw1tw-AWbp1beajZNCRLYQXdiC6ifMvGc5_po64i_GtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEExFWvw1tw-AWbp1beajZNCRLYQXdiC6ifMvGc5_po64i_GtQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sergei.shtylyov@cogentembedded.com
Cc: b.zolnierkie@samsung.com, axboe@kernel.dk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Nov 21, 2018 at 11:31 PM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> On Wed, Nov 21, 2018 at 11:24 PM Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> >
> > Hello!
> >
> > On 11/21/2018 04:04 PM, Yangtao Li wrote:
> >
> > > of_find_node_by_path() acquires a reference to the node
> > > returned by it and that reference needs to be dropped by its caller.
> > > bl_idle_init() doesn't do that, so fix it.
> >
> >    I thought we're inside pata_macio_cable_detect()?
Hi Sergei=EF=BC=9A

Yeah,this is a typo.
Need me to resend a patch?

Thanks=EF=BC=8C
Yangtao
> Hi Sergei=EF=BC=9A
>
> What do you mean?
> Why not release the refcount of root?
>
> Yours,
>     Yangtao
> >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/ata/pata_macio.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> > > index 9588e685d994..8cc9c429ad95 100644
> > > --- a/drivers/ata/pata_macio.c
> > > +++ b/drivers/ata/pata_macio.c
> > > @@ -483,6 +483,8 @@ static int pata_macio_cable_detect(struct ata_por=
t *ap)
> > >               struct device_node *root =3D of_find_node_by_path("/");
> > >               const char *model =3D of_get_property(root, "model", NU=
LL);
> > >
> > > +             of_node_put(root);
> > > +
> > >               if (cable && !strncmp(cable, "80-", 3)) {
> > >                       /* Some drives fail to detect 80c cable in Powe=
rBook
> > >                        * These machine use proprietary short IDE cabl=
e
> >
> > MBR, Sergei
