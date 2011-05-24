From: Rakib Mullick <rakib.mullick@gmail.com>
Subject: Re: [PATCH] drivers: Use kzalloc instead of 'kmalloc+memset',
	where possible.
Date: Tue, 24 May 2011 23:39:08 +0600
Message-ID: <BANLkTi=HshbS5HHDBkU5Zh=Lbzdqp5bung@mail.gmail.com>
References: <1306172407.8198.3.camel@localhost.localdomain>
	<1306173085.8687.38.camel@Joe-Laptop>
	<BANLkTikQjH5pdenTNRxyBwegbkRj0vGHLg@mail.gmail.com>
	<1306256971.2298.37.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1171671884=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1306256971.2298.37.camel@Joe-Laptop>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

--===============1171671884==
Content-Type: multipart/alternative; boundary=20cf300fb09fadb25704a4091042

--20cf300fb09fadb25704a4091042
Content-Type: text/plain; charset=ISO-8859-1

On Tue, May 24, 2011 at 11:09 PM, Joe Perches <joe@perches.com> wrote:

> On Tue, 2011-05-24 at 22:59 +0600, Rakib Mullick wrote:
> > On 5/23/11, Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2011-05-23 at 23:40 +0600, Rakib Mullick wrote:
> > >> Following patch removes the uses of 'kmalloc+memset' from various
> > >> drivers subsystems, which is replaced by kzalloc. kzalloc take care of
> > >> setting allocated memory with null, so it helps to get rid from using
> > >> memset.
> > >> diff --git a/drivers/gpu/drm/drm_scatter.c
> b/drivers/gpu/drm/drm_scatter.c
> > > []
> > >> -  entry->pagelist = kmalloc(pages * sizeof(*entry->pagelist),
> GFP_KERNEL);
> > >> +  entry->pagelist = kzalloc(pages * sizeof(*entry->pagelist),
> GFP_KERNEL);
> > > Perhaps it's better to use:
> > >     entry->pagelist =  kcalloc(pages, sizeof(*entry->pagelist),
> GFP_KERNEL);
> > >> -  entry->busaddr = kmalloc(pages * sizeof(*entry->busaddr),
> GFP_KERNEL);
> > >> +  entry->busaddr = kzalloc(pages * sizeof(*entry->busaddr),
> GFP_KERNEL);
> > > here too.
> > Is there any significant benefit of using kcalloc here?
>
> Overflow and tradition.
>
> static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
> {
>        if (size != 0 && n > ULONG_MAX / size)
>                return NULL;
>        return __kmalloc(n * size, flags | __GFP_ZERO);
> }
>
> It's been used for allocating memory for an array. Maybe, using kcalloc in
entry->pagelist could be useful. But, not that much sure though. There's no
problem with current implementation.

This patch touches few drivers subsystems, they are added to the CC list.

Thanks,
Rakib

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--20cf300fb09fadb25704a4091042
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, May 24, 2011 at 11:09 PM, Joe Pe=
rches <span dir=3D"ltr">&lt;<a href=3D"mailto:joe@perches.com">joe@perches.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-=
left: 1ex;">
<div><div></div><div class=3D"h5">On Tue, 2011-05-24 at 22:59 +0600, Rakib =
Mullick wrote:<br>
&gt; On 5/23/11, Joe Perches &lt;<a href=3D"mailto:joe@perches.com">joe@per=
ches.com</a>&gt; wrote:<br>
&gt; &gt; On Mon, 2011-05-23 at 23:40 +0600, Rakib Mullick wrote:<br>
&gt; &gt;&gt; Following patch removes the uses of &#39;kmalloc+memset&#39; =
from various<br>
&gt; &gt;&gt; drivers subsystems, which is replaced by kzalloc. kzalloc tak=
e care of<br>
&gt; &gt;&gt; setting allocated memory with null, so it helps to get rid fr=
om using<br>
&gt; &gt;&gt; memset.<br>
&gt; &gt;&gt; diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/=
drm_scatter.c<br>
&gt; &gt; []<br>
&gt; &gt;&gt; - =A0entry-&gt;pagelist =3D kmalloc(pages * sizeof(*entry-&gt=
;pagelist), GFP_KERNEL);<br>
&gt; &gt;&gt; + =A0entry-&gt;pagelist =3D kzalloc(pages * sizeof(*entry-&gt=
;pagelist), GFP_KERNEL);<br>
&gt; &gt; Perhaps it&#39;s better to use:<br>
&gt; &gt; =A0 =A0 entry-&gt;pagelist =3D =A0kcalloc(pages, sizeof(*entry-&g=
t;pagelist), GFP_KERNEL);<br>
&gt; &gt;&gt; - =A0entry-&gt;busaddr =3D kmalloc(pages * sizeof(*entry-&gt;=
busaddr), GFP_KERNEL);<br>
&gt; &gt;&gt; + =A0entry-&gt;busaddr =3D kzalloc(pages * sizeof(*entry-&gt;=
busaddr), GFP_KERNEL);<br>
&gt; &gt; here too.<br>
&gt; Is there any significant benefit of using kcalloc here?<br>
<br>
</div></div>Overflow and tradition.<br>
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt=
 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
static inline void *kcalloc(size_t n, size_t size, gfp_t flags)<br>
{<br>
 =A0 =A0 =A0 =A0if (size !=3D 0 &amp;&amp; n &gt; ULONG_MAX / size)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;<br>
 =A0 =A0 =A0 =A0return __kmalloc(n * size, flags | __GFP_ZERO);<br>
}<br>
<font color=3D"#888888"><br></font></blockquote><div>It&#39;s been used for=
 allocating memory for an array. Maybe, using kcalloc in entry-&gt;pagelist=
 could be useful. But, not that much sure though. There&#39;s no problem wi=
th current implementation.<br>
=A0<br>This patch touches few drivers subsystems, they are added to the CC =
list.<br><br>Thanks,<br>Rakib<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">
<font color=3D"#888888">
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</font></blockquote></div><br>

--20cf300fb09fadb25704a4091042--

--===============1171671884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1171671884==--
