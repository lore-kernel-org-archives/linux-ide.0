From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] Added AMCC 460EX Canyonlands SATA support.
Date: Fri, 1 May 2009 15:35:23 -0600
Message-ID: <fa686aa40905011435v1071f871nbc47871fdb4046e1@mail.gmail.com>
References: <1241211774-32719-1-git-send-email-fkan@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:36611 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbZEAVfi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 May 2009 17:35:38 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2001044rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 May 2009 14:35:38 -0700 (PDT)
In-Reply-To: <1241211774-32719-1-git-send-email-fkan@amcc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Feng Kan <fkan@amcc.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Fri, May 1, 2009 at 3:02 PM, Feng Kan <fkan@amcc.com> wrote:
> This adds the OF platform support for the AMCC 460EX Canyonlands SATA=
 port.
>
> Signed-off-by: Feng Kan <fkan@amcc.com>
> ---
> =A0arch/powerpc/boot/dts/canyonlands.dts =A0| =A0 =A08 ++
> =A0arch/powerpc/platforms/44x/Makefile =A0 =A0| =A0 =A04 +
> =A0arch/powerpc/platforms/44x/amcc-sata.c | =A0125 ++++++++++++++++++=
++++++++++++++
> =A03 files changed, 137 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/platforms/44x/amcc-sata.c
>
> diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boo=
t/dts/canyonlands.dts
> index 5fd1ad0..b536223 100644
> --- a/arch/powerpc/boot/dts/canyonlands.dts
> +++ b/arch/powerpc/boot/dts/canyonlands.dts
> @@ -163,6 +163,14 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0x1e =
4>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SATA0: sata@bffd1000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "amcc=
,sata-460ex";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <4 0xbffd1000 0=
x800 4 0xbffd0800 0x400>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D=
 <&UIC3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <0 4 =
=A0 =A0 =A0 /* SATA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A05 4>; =A0 =A0 /* AHBDMA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> +

You should also add documentation for the "amcc,sata-460ex" binding to
Documentation/powerpc/dts-bindings.  Doesn't have to be huge, just a
blurb describing the device and what each tuple in the reg &
interrupts properties mean.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
