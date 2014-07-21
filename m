From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v10 2/8] Documentation: bindings: add the Berlin SATA PHY
Date: Mon, 21 Jul 2014 11:04:23 +0200
Message-ID: <20140721090423.GD32208@kwain>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-3-git-send-email-antoine.tenart@free-electrons.com>
 <53C95900.9050200@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53C95900.9050200-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On Fri, Jul 18, 2014 at 09:27:28PM +0400, Sergei Shtylyov wrote:
> On 07/18/2014 04:30 PM, Antoine T=E9nart wrote:
>=20
> >diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.t=
xt b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
> >new file mode 100644
> >index 000000000000..88f8c23384c0
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
> >@@ -0,0 +1,34 @@
> >+Berlin SATA PHY
> >+---------------
> >+
> >+Required properties:
> >+- compatible: should be "marvell,berlin2q-sata-phy"
> >+- address-cells: should be 1
> >+- size-cells: should be 0
> >+- phy-cells: from the generic PHY bindings, must be 1
>=20
>    It's "#address-cells", "#size-cells", and "#phy-cells".

Sure.

>=20
> >+- reg: address and length of the register
> >+- clocks: reference to the clock entry
> >+
> >+Sub-nodes:
> >+Each PHY should be represented as a sub-node.
>=20
>    Then "#phy-cells" should also belong to the sub-nodes.

No, because the PHY provider is still the parent.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
