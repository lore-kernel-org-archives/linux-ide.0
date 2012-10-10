From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: Re: [PATCH 2/6] ARM: EXYNOS5: DT Support for SATA and SATA PHY
Date: Wed, 10 Oct 2012 14:08:31 +0530
Message-ID: <CAK1UHiyjyp8u-nFwU-19dds1uF7T1kkFNHyYQ6pWLFtUwGtR1w@mail.gmail.com>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
 <1349783332-18467-3-git-send-email-vasanthananthan@gmail.com>
 <20121009182828.GA20879@quad.lixom.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4633664120009761863=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121009182828.GA20879@quad.lixom.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, Vasanth Ananthan <vasanth.a@samsung.com>, linux-ide@vger.kernel.org, kgene.kim@samsung.com, thomas.abraham@linaro.org, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

--===============4633664120009761863==
Content-Type: multipart/alternative; boundary=20cf300fb2cf23224f04cbb061d2

--20cf300fb2cf23224f04cbb061d2
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On Tue, Oct 9, 2012 at 11:58 PM, Olof Johansson <olof@lixom.net> wrote:

> Hi,
>
>
> On Tue, Oct 09, 2012 at 05:18:48PM +0530, Vasanth Ananthan wrote:
> > This patch adds Device Nodes for SATA and SATA PHY device.
> >
> > Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos5250-smdk5250.dts |   11 +++++++++++
> >  arch/arm/boot/dts/exynos5250.dtsi         |   20 ++++++++++++++++++++
> >  arch/arm/mach-exynos/include/mach/map.h   |    7 +++++++
> >  arch/arm/mach-exynos/mach-exynos5-dt.c    |    6 ++++++
> >  4 files changed, 44 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> > index 8a5e348..bb262ce 100644
> > --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> > +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> > @@ -48,6 +48,17 @@
> >               };
> >       };
> >
> > +     i2c@121D0000 {
> > +             samsung,i2c-sda-delay = <100>;
> > +                samsung,i2c-max-bus-freq = <40000>;
> > +             samsung,i2c-slave-addr = <0x38>;
>
> Whitespace is off above.
>
> > +
> > +             sataphy@70 {
>
> sata-phy would be a more conventional name.
>
> > +                     compatible = "samsung,i2c-phy";
>
> i2c-phy? Seems like an odd choice of name. What is this device?
>

The SATA physical layer controller is both a platform device and a i2c
slave device.
This compatible string is for the i2c client driver. Hence I have used
i2c-phy here.


>
> > +                     reg = <0x38>;
>
> 70 is unit address but here it's 0x38? One of them is wrong. No need for a
> unit
> address if it's a unique name, by the way.
>
>
> > +             };
> > +     };
> > +
> >       i2c@12C80000 {
> >               status = "disabled";
> >       };
> > diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> > index 004aaa8..5a47a8f 100644
> > --- a/arch/arm/boot/dts/exynos5250.dtsi
> > +++ b/arch/arm/boot/dts/exynos5250.dtsi
> > @@ -88,6 +88,18 @@
> >               interrupts = <0 54 0>;
> >       };
> >
> > +     sata@122F0000 {
> > +                compatible = "samsung,exynos-sata-ahci";
> > +                reg = <0x122F0000 0x1ff>;
> > +             interrupts = <0 115 0>;
>
> More whitespace damage. And need binding.
>
> > +        };
> > +
> > +        sata-phy@12170000 {
> > +                compatible = "samsung,exynos-sata-phy";
> > +                reg = <0x12170000 0x1ff>;
> > +        };
>
> Should have binding too. How does this relate to the i2c device above.
>

As mentioned earlier SATA physical layer controller is both a platform
device and also an i2c slave device.
This Node is for the SATA physical layer platform device, the previous node
is for i2c slave device.
Certain initialization settings done directly and other settings has to be
done through i2c.


> > +
> >       i2c@12C60000 {
> >               compatible = "samsung,s3c2440-i2c";
> >               reg = <0x12C60000 0x100>;
> > @@ -152,6 +164,13 @@
> >               #size-cells = <0>;
> >       };
> >
> > +     i2c@121D0000 {
> > +                compatible = "samsung,s3c2440-sataphy-i2c";
>
> Is this a unique i2c controller, or is it just another one like the others
> on
> the chip? If it's the latter, it should use the regular compatible string.
>

Yes, its a unique i2c controller which lacks an interrupt line while others
are interrupt driven.
Hence I have used a distinct compatible string for the driver to
distinguish the controller.


> > +                reg = <0x121D0000 0x100>;
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +        };
> > +
> >       spi_0: spi@12d20000 {
> >               compatible = "samsung,exynos4210-spi";
> >               reg = <0x12d20000 0x100>;
> > @@ -460,4 +479,5 @@
> >                       #gpio-cells = <4>;
> >               };
> >       };
> > +
>
> Stray whitespace change.
>
> >  };
> > diff --git a/arch/arm/mach-exynos/include/mach/map.h
> b/arch/arm/mach-exynos/include/mach/map.h
> > index c72b675..6827190 100644
> > --- a/arch/arm/mach-exynos/include/mach/map.h
> > +++ b/arch/arm/mach-exynos/include/mach/map.h
> > @@ -177,9 +177,16 @@
> >  #define EXYNOS4_PA_HSOTG             0x12480000
> >  #define EXYNOS4_PA_USB_HSPHY         0x125B0000
> >
> > +#ifdef CONFIG_ARCH_EXYNOS4
>
> No need to ifdef since namespace isn't overlapped.
>
> >  #define EXYNOS4_PA_SATA                      0x12560000
> >  #define EXYNOS4_PA_SATAPHY           0x125D0000
> >  #define EXYNOS4_PA_SATAPHY_CTRL              0x126B0000
> > +#endif
> > +#ifdef CONFIG_ARCH_EXYNOS5
>
> Same here.
>
> > +#define EXYNOS5_PA_SATA_PHY_CTRL     0x12170000
> > +#define EXYNOS5_PA_SATA_PHY_I2C              0x121D0000
> > +#define EXYNOS5_PA_SATA_BASE         0x122F0000
> > +#endif
>
>
> -Olof
>

I will incorporate the other comments and resubmit the patch. Thanks.

-- 
Vasanth Ananthan.

--20cf300fb2cf23224f04cbb061d2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br><div class=3D"gmail_quote">On Tue, Oct 9, 2012 at 11:58 PM, Olof=
 Johansson <span dir=3D"ltr">&lt;<a href=3D"mailto:olof@lixom.net" target=
=3D"_blank">olof@lixom.net</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
Hi,<br>
<div class=3D"im"><br>
<br>
On Tue, Oct 09, 2012 at 05:18:48PM +0530, Vasanth Ananthan wrote:<br>
&gt; This patch adds Device Nodes for SATA and SATA PHY device.<br>
&gt;<br>
&gt; Signed-off-by: Vasanth Ananthan &lt;<a href=3D"mailto:vasanth.a@samsun=
g.com">vasanth.a@samsung.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0arch/arm/boot/dts/exynos5250-smdk5250.dts | =A0 11 +++++++++++<br>
&gt; =A0arch/arm/boot/dts/exynos5250.dtsi =A0 =A0 =A0 =A0 | =A0 20 ++++++++=
++++++++++++<br>
&gt; =A0arch/arm/mach-exynos/include/mach/map.h =A0 | =A0 =A07 +++++++<br>
&gt; =A0arch/arm/mach-exynos/mach-exynos5-dt.c =A0 =A0| =A0 =A06 ++++++<br>
&gt; =A04 files changed, 44 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot=
/dts/exynos5250-smdk5250.dts<br>
&gt; index 8a5e348..bb262ce 100644<br>
&gt; --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts<br>
&gt; +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts<br>
&gt; @@ -48,6 +48,17 @@<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
&gt; =A0 =A0 =A0 };<br>
&gt;<br>
&gt; + =A0 =A0 i2c@121D0000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 samsung,i2c-sda-delay =3D &lt;100&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0samsung,i2c-max-bus-freq =3D &lt;4000=
0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 samsung,i2c-slave-addr =3D &lt;0x38&gt;;<br>
<br>
</div>Whitespace is off above.<br>
<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 sataphy@70 {<br>
<br>
sata-phy would be a more conventional name.<br>
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;samsung=
,i2c-phy&quot;;<br>
<br>
i2c-phy? Seems like an odd choice of name. What is this device?<br></blockq=
uote><div><br>The SATA physical layer controller is both a platform device =
and a i2c slave device.<br>This compatible string is for the i2c client dri=
ver. Hence I have used i2c-phy here.<br>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0x38&gt;;<br>
<br>
70 is unit address but here it&#39;s 0x38? One of them is wrong. No need fo=
r a unit<br>
address if it&#39;s a unique name, by the way.<br>
<div class=3D"im"><br>
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 };<br>
&gt; + =A0 =A0 };<br>
&gt; +<br>
&gt; =A0 =A0 =A0 i2c@12C80000 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D &quot;disabled&quot;;<br>
&gt; =A0 =A0 =A0 };<br>
&gt; diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exy=
nos5250.dtsi<br>
&gt; index 004aaa8..5a47a8f 100644<br>
&gt; --- a/arch/arm/boot/dts/exynos5250.dtsi<br>
&gt; +++ b/arch/arm/boot/dts/exynos5250.dtsi<br>
&gt; @@ -88,6 +88,18 @@<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D &lt;0 54 0&gt;;<br>
&gt; =A0 =A0 =A0 };<br>
&gt;<br>
&gt; + =A0 =A0 sata@122F0000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D &quot;samsung,exynos-s=
ata-ahci&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D &lt;0x122F0000 0x1ff&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D &lt;0 115 0&gt;;<br>
<br>
</div>More whitespace damage. And need binding.<br>
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0};<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0sata-phy@12170000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D &quot;samsung,exynos-s=
ata-phy&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D &lt;0x12170000 0x1ff&gt;;<br>
&gt; + =A0 =A0 =A0 =A0};<br>
<br>
</div>Should have binding too. How does this relate to the i2c device above=
.<br></blockquote><div><br>As mentioned earlier SATA physical layer control=
ler is both a platform device and also an i2c slave device. <br>This Node i=
s for the SATA physical layer platform device, the previous node is for i2c=
 slave device.<br>
Certain initialization settings done directly and other settings has to be =
done through i2c.=A0 <br><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im"><br>
&gt; +<br>
&gt; =A0 =A0 =A0 i2c@12C60000 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;samsung,s3c2440-i2c&q=
uot;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0x12C60000 0x100&gt;;<br>
&gt; @@ -152,6 +164,13 @@<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D &lt;0&gt;;<br>
&gt; =A0 =A0 =A0 };<br>
&gt;<br>
&gt; + =A0 =A0 i2c@121D0000 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D &quot;samsung,s3c2440-=
sataphy-i2c&quot;;<br>
<br>
</div>Is this a unique i2c controller, or is it just another one like the o=
thers on<br>
the chip? If it&#39;s the latter, it should use the regular compatible stri=
ng.<br></blockquote><div><br>Yes, its a unique i2c controller which lacks a=
n interrupt line while others are interrupt driven. <br>Hence I have used a=
 distinct compatible string for the driver to distinguish the controller. <=
br>
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D &lt;0x121D0000 0x100&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D &lt;0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0};<br>
&gt; +<br>
&gt; =A0 =A0 =A0 spi_0: spi@12d20000 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;samsung,exynos4210-sp=
i&quot;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0x12d20000 0x100&gt;;<br>
&gt; @@ -460,4 +479,5 @@<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #gpio-cells =3D &lt;4&gt;;=
<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
&gt; =A0 =A0 =A0 };<br>
&gt; +<br>
<br>
</div>Stray whitespace change.<br>
<div class=3D"im"><br>
&gt; =A0};<br>
&gt; diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-e=
xynos/include/mach/map.h<br>
&gt; index c72b675..6827190 100644<br>
&gt; --- a/arch/arm/mach-exynos/include/mach/map.h<br>
&gt; +++ b/arch/arm/mach-exynos/include/mach/map.h<br>
&gt; @@ -177,9 +177,16 @@<br>
&gt; =A0#define EXYNOS4_PA_HSOTG =A0 =A0 =A0 =A0 =A0 =A0 0x12480000<br>
&gt; =A0#define EXYNOS4_PA_USB_HSPHY =A0 =A0 =A0 =A0 0x125B0000<br>
&gt;<br>
&gt; +#ifdef CONFIG_ARCH_EXYNOS4<br>
<br>
</div>No need to ifdef since namespace isn&#39;t overlapped.<br>
<div class=3D"im"><br>
&gt; =A0#define EXYNOS4_PA_SATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x12560000<br>
&gt; =A0#define EXYNOS4_PA_SATAPHY =A0 =A0 =A0 =A0 =A0 0x125D0000<br>
&gt; =A0#define EXYNOS4_PA_SATAPHY_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A00x126B00=
00<br>
&gt; +#endif<br>
&gt; +#ifdef CONFIG_ARCH_EXYNOS5<br>
<br>
</div>Same here.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; +#define EXYNOS5_PA_SATA_PHY_CTRL =A0 =A0 0x12170000<br>
&gt; +#define EXYNOS5_PA_SATA_PHY_I2C =A0 =A0 =A0 =A0 =A0 =A0 =A00x121D0000=
<br>
&gt; +#define EXYNOS5_PA_SATA_BASE =A0 =A0 =A0 =A0 0x122F0000<br>
&gt; +#endif<br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">-Olof<br>
</font></span></blockquote></div><br>I will incorporate the other comments =
and resubmit the patch. Thanks.<br clear=3D"all"><br>-- <br>Vasanth Anantha=
n.<br>

--20cf300fb2cf23224f04cbb061d2--


--===============4633664120009761863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4633664120009761863==--
