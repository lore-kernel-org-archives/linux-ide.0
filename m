From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [V5 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Wed, 25 Mar 2015 17:11:39 +0200
Message-ID: <20150325151139.GA1878@lahna.fi.intel.com>
References: <1425622302-15193-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <55117373.3020808@amd.com>
 <20150324144346.GO1878@lahna.fi.intel.com>
 <1602323.I0oL7Cv9OO@vostro.rjw.lan>
 <5512CFB6.1020606@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1563 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863AbbCYPNx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Mar 2015 11:13:53 -0400
Content-Disposition: inline
In-Reply-To: <5512CFB6.1020606@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, lv.zheng@intel.com, hpa@linux.intel.com, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On Wed, Mar 25, 2015 at 10:09:42AM -0500, Suravee Suthikulpanit wrote:
> On 3/24/15 15:20, Rafael J. Wysocki wrote:
> >On Tuesday, March 24, 2015 04:43:46 PM Mika Westerberg wrote:
> >>On Tue, Mar 24, 2015 at 09:23:47AM -0500, Suravee Suthikulpanit wrote:
> >>>On 3/9/15 10:20, Mika Westerberg wrote:
> >>>>>[....]
> >>>>>diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> >>>>>index e530533..9a42522 100644
> >>>>>--- a/include/linux/mod_devicetable.h
> >>>>>+++ b/include/linux/mod_devicetable.h
> >>>>>@@ -189,6 +189,7 @@ struct css_device_id {
> >>>>>  struct acpi_device_id {
> >>>>>  	__u8 id[ACPI_ID_LEN];
> >>>>>  	kernel_ulong_t driver_data;
> >>>>>+	__u32 cls;
> >>>>
> >>>>It would be nice if we could change ordering here but I understand that
> >>>>it breaks quite many drivers. Perhaps we should consider creating
> >>>>ACPI_DEVICE() macro and convert existing drivers to that at some point.
> >>>
> >>>Yes, a roughly grep in the drivers directory showing about 112 files at the
> >>>moment. If you think this is the right approach going forward, we can work
> >>>on cleaning this up on a separate patch series. Please let me know what you
> >>>think.
> >>
> >>I think having ACPI_DEVICE() macro would be pretty useful and it avoids
> >>things like this if we need to add new fields in the future. Rafael has
> >>the last word, though :-)
> >
> >I agree.
> 
> Okay, how should I organize this big change? Can we do this as a separate
> patch series?

Separate patch series is fine.
