From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 20 May 2014 11:15:10 +0200
Message-ID: <20140520091510.GA25381@kwain>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-2-git-send-email-antoine.tenart@free-electrons.com>
 <537B1C35.20107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <537B1C35.20107-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Tue, May 20, 2014 at 11:11:17AM +0200, Sebastian Hesselbarth wrote:
> On 05/20/2014 11:04 AM, Antoine T=E9nart wrote:
> >+#define HOST_VSA_ADDR		0x0
> >+#define HOST_VSA_DATA		0x4
> >+#define PORT_VSR_ADDR           0x78
> >+#define PORT_VSR_DATA           0x7c
>=20
> Above two lines are indented with spaces.

Indeed ... sorry for that.

> >+#define PORT_SCR_CTL		0x2c
> >+
> >+#define CONTROL_REGISTER	0x0
> >+#define MBUS_SIZE_CONTROL	0x4
> >+
> >+#define POWER_DOWN_PHY0			BIT(6)
> >+#define POWER_DOWN_PHY1			BIT(14)
> >+#define MBUS_WRITE_REQUEST_SIZE_128	(BIT(2) << 16)
> >+#define MBUS_READ_REQUEST_SIZE_128	(BIT(2) << 19)
> >+
> >+#define PHY_BASE                0x200
>=20
> ditto.
>=20
> >+
> >+/* register 0x01 */
> >+#define REF_FREF_SEL_25         BIT(0)
> >+#define PHY_MODE_SATA           (0x0 << 5)
>=20
> ditto.
>=20
> >+
> >+/* register 0x02 */
> >+#define USE_MAX_PLL_RATE        BIT(12)
>=20
> ditto.
>=20
> >+
> >+/* register 0x23 */
> >+#define DATA_BIT_WIDTH_10       (0x0 << 10)
> >+#define DATA_BIT_WIDTH_20       (0x1 << 10)
> >+#define DATA_BIT_WIDTH_40       (0x2 << 10)
>=20
> ditto.
>=20
> >+
> >+/* register 0x25 */
> >+#define PHY_GEN_MAX_1_5         (0x0 << 10)
> >+#define PHY_GEN_MAX_3_0         (0x1 << 10)
> >+#define PHY_GEN_MAX_6_0         (0x2 << 10)
>=20
> ditto.

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
