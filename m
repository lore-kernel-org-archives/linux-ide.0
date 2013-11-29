From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 0/3] ACPI / bind: Use struct acpi_device pointers instead
 of ACPI handles
Date: Fri, 29 Nov 2013 10:11:21 +0800
Message-ID: <5297F7C9.6090303@intel.com>
References: <4501334.ovACrGogrl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29206 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab3K2CW7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Nov 2013 21:22:59 -0500
In-Reply-To: <4501334.ovACrGogrl@vostro.rjw.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Aaron Lu <aaron.lu@intel.com>, Toshi Kani <toshi.kani@hp.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-ide@vger.kernel.org, linux-usb@vger.kernel.org

On 2013=E5=B9=B411=E6=9C=8829=E6=97=A5 08:36, Rafael J. Wysocki wrote:
> Hi,
>=20
> Now that we store a pointer to struct acpi_device as the ACPI compani=
on in
> struct device, the code making associations between "physical" device=
s and
> ACPI device objects can be modified to work with struct acpi_device p=
ointers
> instead of ACPI handles too.  The first two of the following patches =
make these
> changes and the third one is just a related cleanup.
>=20
> [1/3] ACPI / bind: Replace .find_device in struct acpi_bus_type with =
=2Efind_companion
> [2/3] ACPI / bind: Modify acpi_bind_one() to take a struct acpi_devic=
e pointer as
>       the second argument.
> [3/3] ACPI / bind: Move acpi_get_child() to ide-acpi.c which is the o=
nly remaining
>       user of that function.
>=20

Test usb/ACPI bind part, it works normally.

Tested-by: Lan Tianyu <tianyu.lan@intel.com>

> The patches are on top of linux-pm.git/linux-next.  Please let me kno=
w if you see
> any problems in them.
>=20
> Thanks!
>=20


--=20
Best regards
Tianyu Lan
