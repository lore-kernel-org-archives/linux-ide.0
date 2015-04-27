From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [V8 PATCH 1/3] ACPICA: Add ACPI _CLS processing
Date: Mon, 27 Apr 2015 22:38:33 +0200
Message-ID: <3419939.l8boJE7mrB@vostro.rjw.lan>
References: <D162D21D.19BCD%suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <D162D21D.19BCD%suravee.suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Moore, Robert" <robert.moore@intel.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "Duran, Leo" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-ide@vger.kernel.org

On Sunday, April 26, 2015 10:45:29 PM Suthikulpanit, Suravee wrote:
> On 4/24/15, 21:28, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>=20
> >On Friday, April 24, 2015 04:08:31 PM Suravee Suthikulpanit wrote:
> >> On 4/16/15 20:45, Zheng, Lv wrote:
> >> > Before back porting this to ACPICA, let me ask one simple questi=
on.
> >> > According to the spec, the _CLS is optional and PCI specific.
> >> > So why should we implement it in ACPICA core not OSPM specific
> >>modules?
> >> > If this need to be implemented in ACPICA, then what about the
> >>following device identification objects?
> >> > _DDN, _HRV, _MLS, _PLD, _STR, _SUN
> >> >
> >> > Thanks and best regards
> >> > -Lv
> >>=20
> >> Hi,
> >>=20
> >> Sorry for late reply. As for the justification for introducing the=
 _CLS
> >> support in the ACPICA, this is mainly because ACPI does not curren=
tly
> >> define _CID for certain device classes, which used to mostly be PC=
I
> >> devices. Instead, ACPI spec mentioned that _CLS can be used for lo=
ading
> >> generic drivers on hardware that is compatible with PCI-defined de=
vice
> >> classes, but that is not implemented on the PCI bus (and is theref=
ore
> >> enumerated by ACPI.)
> >
> >I think it would be good to point to the particular part of the spec
> >making that provision.  In what section is that mentioned, exactly?
>=20
> Here is the copied from section 6.1.3 _CLS (Class Code) from ACPI 5.1=
 spec:
> "This object is used to supply OSPM with the PCI-defined class, subcl=
ass
> and programming interface for a device. This object is optional but m=
ay be
> useful for generic drivers written for PCI devices that move off of P=
CI
> and are enumerated by ACPI."

OK, so the "move off of PCI" part should be understood as "something th=
at
used to be on the PCI bus, but now may be included into an SoC directly
in which case it won't be a PCI device any more", right?

> Otherwise, if the community think it=C2=B9s better to not putting the=
 _CLS the
> _CLS parsing code in ACPICA since, I can try looking into pulling the=
 code
> out of ACPICA. I also noticed a little issue in the patch series wher=
e the
> ACPI_VALID_CLS is used in the patch 1 but defined in patch 2. I can s=
end
> out v9 with the fix once we agree on the _CLS parsing.

To me that pretty much depends on the answer to the above question.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
