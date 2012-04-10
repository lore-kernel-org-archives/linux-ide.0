From: Thang Nguyen <tqnguyen@apm.com>
Subject: RE: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
Date: Tue, 10 Apr 2012 10:46:22 +0700
Message-ID: <8a0ea5bd221ddeb9eded16e180aa8fbb@mail.gmail.com>
References: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
 <4F82B61D.8010502@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <4F82B61D.8010502@mvista.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-ide@vger.kernel.org

Hi Sergei,
Thanks for your review.
On Maui, there are 2 separate SATA controllers but they share the same
AHBDMA controller. Each SATA controller is assigned a fixed DMA channel on
the AHBDMA (channel 0 is assigned to SATA controller 0 and channel 1 is
assigned to SATA controller 1).
For the 460EX, there is only 1 SATA controller and it uses channel 0 for
transferring data.

In my opinion, in the case of Maui, we can use the same DMA information in
2 device nodes as they use the same DMA controller. And in another CPU, if
they use different DMA controller, the corresponding information will also
be different.

Regards,
Thang Nguyen -
-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
Sent: Monday, April 09, 2012 5:13 PM
To: Thang Q. Nguyen
Cc: Benjamin Herrenschmidt; Paul Mackerras; Jeff Garzik; Grant Likely; Rob
Herring; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
linux-ide@vger.kernel.org; devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change
filename from sata_dwc_460ex.c to sata_dwc_4xx.c

Hello.

On 03-04-2012 14:12, Thang Q. Nguyen wrote:

> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
[...]

> diff --git a/arch/powerpc/boot/dts/bluestone.dts
b/arch/powerpc/boot/dts/bluestone.dts
> index cfa23bf..803fda6 100644
> --- a/arch/powerpc/boot/dts/bluestone.dts
> +++ b/arch/powerpc/boot/dts/bluestone.dts
> @@ -155,6 +155,27 @@
>   					/*RXDE*/  0x5 0x4>;
>   		};
>
> +		/* SATA DWC devices */
> +		SATA0: sata@bffd1000 {
> +			compatible =3D "amcc,sata-apm821xx";
> +			reg =3D<4 0xbffd1000 0x800   /* SATA0 */
> +			       4 0xbffd0800 0x400>; /* AHBDMA */
> +			dma-channel=3D<0>;
> +			interrupt-parent =3D<&UIC0>;
> +			interrupts =3D<26 4    /* SATA0 */
> +			              25 4>;  /* AHBDMA */
> +		};
> +
> +		SATA1: sata@bffd1800 {
> +			compatible =3D "amcc,sata-apm821xx";
> +			reg =3D<4 0xbffd1800 0x800   /* SATA1 */
> +			       4 0xbffd0800 0x400>; /* AHBDMA */
> +			dma-channel=3D<1>;
> +			interrupt-parent =3D<&UIC0>;
> +			interrupts =3D<27 4    /* SATA1 */
> +			              25 4>;  /* AHBDMA */
> +		};
> +

    So, this is dual SATA controller, not dual port SATA controller?
BTW, it's wrong to have the same AHBDMA resource in two device nodes I
think.

MBR, Sergei
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, =

is for the sole use of the intended recipient(s) and contains information=
=A0
that is confidential and proprietary to AppliedMicro Corporation or its sub=
sidiaries. =

It is to be used solely for the purpose of furthering the parties' business=
 relationship. =

All unauthorized review, use, disclosure or distribution is prohibited. =

If you are not the intended recipient, please contact the sender by reply e=
-mail =

and destroy all copies of the original message.
