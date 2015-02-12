From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [V3 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Thu, 12 Feb 2015 12:51:39 +0200
Message-ID: <20150212105139.GE1561@lahna.fi.intel.com>
References: <2016200.TRfI2dfssZ@vostro.rjw.lan>
 <D101F3FB.108F7%suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60111 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbbBLKwD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Feb 2015 05:52:03 -0500
Content-Disposition: inline
In-Reply-To: <D101F3FB.108F7%suravee.suthikulpanit@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "Duran, Leo" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Lv Zheng <lv.zheng@intel.com>

On Wed, Feb 11, 2015 at 10:35:25PM +0000, Suthikulpanit, Suravee wrote:
> >> Besides, how do you support modules with this? Or did I miss somet=
hing?
> >
> >Good question.
>=20
> Ah. I didn=B9t think about this part earlier.
>=20
> IIUC, the current ACPI driver would create modules.alias entry with f=
ormat:
> 	acpi:<HID>:<CID>
>=20
> What do you think if we append the _CLS of the device using the follo=
wing
> format:
> 	acpi:<HID>:<CID>:<CLS>
>=20
> In case of PCI_CLASS_STORAGE_SATA_AHCI, this would become:
> 	acpi:::0x10601

Note, that you can have multiple _CIDs, in other words it may look like=
:

	acpi:<HID>:<CID0>:<CID1>:<CLS>

In which case I'm not sure how to match the class. Perhaps use somethin=
g
else than ':' as a separator for class?

BTW, should we add class_mask as well (like PCI does) so that drivers
can match part of the class id?
