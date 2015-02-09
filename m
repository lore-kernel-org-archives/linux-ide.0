From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [V3 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Mon, 9 Feb 2015 13:15:38 +0200
Message-ID: <20150209111538.GB1480@lahna.fi.intel.com>
References: <1423412404-4690-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1423412404-4690-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <6495379.TIpKZohZf0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58857 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbbBILP5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Feb 2015 06:15:57 -0500
Content-Disposition: inline
In-Reply-To: <6495379.TIpKZohZf0@vostro.rjw.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org, grant.likely@linaro.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Lv Zheng <lv.zheng@intel.com>

On Mon, Feb 09, 2015 at 12:02:43AM +0100, Rafael J. Wysocki wrote:
> On Monday, February 09, 2015 12:20:03 AM Suravee Suthikulpanit wrote:
> > Device drivers typically use ACPI _HIDs/_CIDs listed in struct device_driver
> > acpi_match_table to match devices. However, for generic drivers, we do
> > not want to list _HID for all supported devices, and some device classes
> > do not have _CID (e.g. SATA, USB). Instead, we can leverage ACPI _CLS,
> > which specifies PCI-defined class code (i.e. base-class, subclass and
> > programming interface).
> > 
> > This patch adds support for matching ACPI devices using the _CLS method.
> > 
> > Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> Greg, Mika, any problems with this?

Is there some specific reason why this cannot be done in similar way
than PCI already does?

In other words, stuff _CLS fields to struct acpi_device_id and make
match functions match against those if they are != 0.
