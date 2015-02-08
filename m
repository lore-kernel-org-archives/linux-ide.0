From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [V3 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Mon, 9 Feb 2015 07:36:28 +0800
Message-ID: <20150208233628.GA8354@kroah.com>
References: <1423412404-4690-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1423412404-4690-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <6495379.TIpKZohZf0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6495379.TIpKZohZf0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org, grant.likely@linaro.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-ide@vger.kernel.org

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

None from me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
