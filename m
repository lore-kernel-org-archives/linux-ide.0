From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [V3 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Tue, 10 Feb 2015 11:59:32 +0200
Message-ID: <20150210095932.GN1480@lahna.fi.intel.com>
References: <20150209111538.GB1480@lahna.fi.intel.com>
 <D0FF3AEC.1020B%suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61222 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbbBJJ7k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Feb 2015 04:59:40 -0500
Content-Disposition: inline
In-Reply-To: <D0FF3AEC.1020B%suravee.suthikulpanit@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "Duran, Leo" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Lv Zheng <lv.zheng@intel.com>

On Mon, Feb 09, 2015 at 09:02:11PM +0000, Suthikulpanit, Suravee wrote:
> On 2/9/15, 19:15, "Mika Westerberg" <mika.westerberg@linux.intel.com>
> wrote:
> 
> >On Mon, Feb 09, 2015 at 12:02:43AM +0100, Rafael J. Wysocki wrote:
> >> On Monday, February 09, 2015 12:20:03 AM Suravee Suthikulpanit wrote:
> >> > Device drivers typically use ACPI _HIDs/_CIDs listed in struct
> >>device_driver
> >> > acpi_match_table to match devices. However, for generic drivers, we do
> >> > not want to list _HID for all supported devices, and some device
> >>classes
> >> > do not have _CID (e.g. SATA, USB). Instead, we can leverage ACPI _CLS,
> >> > which specifies PCI-defined class code (i.e. base-class, subclass and
> >> > programming interface).
> >> > 
> >> > This patch adds support for matching ACPI devices using the _CLS
> >>method.
> >> > 
> >> > Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >> 
> >> Greg, Mika, any problems with this?
> >
> >Is there some specific reason why this cannot be done in similar way
> >than PCI already does?
> >
> >In other words, stuff _CLS fields to struct acpi_device_id and make
> >match functions match against those if they are != 0.
> 
> That was my original thought. Then I realized that the acpi_device_id is
> used
> to create the device matching table, in which could contain several
> _HID/_CID.
> However, most of the added _CLS field would likely ended up being unused
> and
> taking up space.

Well, PCI is doing that already :)

> In contrast to _HID/_CID, a driver is likely to match just a single _CLS.
> So, I think it is cleaner to have just a dedicate struct acpi_device_cls,
> and 
> a matching function for it.

IMHO cleaner version is the one following PCI. Besides, how do you
support modules with this? Or did I miss something?
