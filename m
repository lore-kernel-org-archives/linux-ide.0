From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [V5 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device matching
Date: Tue, 24 Mar 2015 21:20:16 +0100
Message-ID: <1602323.I0oL7Cv9OO@vostro.rjw.lan>
References: <1425622302-15193-1-git-send-email-Suravee.Suthikulpanit@amd.com> <55117373.3020808@amd.com> <20150324144346.GO1878@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150324144346.GO1878@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, lv.zheng@intel.com, hpa@linux.intel.com, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-ide@vger.kernel.org

On Tuesday, March 24, 2015 04:43:46 PM Mika Westerberg wrote:
> On Tue, Mar 24, 2015 at 09:23:47AM -0500, Suravee Suthikulpanit wrote:
> > Not sure if this email went out originally. So, I am resending this.
> > 
> > On 3/9/15 10:20, Mika Westerberg wrote:
> > >On Fri, Mar 06, 2015 at 12:11:41AM -0600, Suravee Suthikulpanit wrote:
> > >>Device drivers typically use ACPI _HIDs/_CIDs listed in struct device_driver
> > >>acpi_match_table to match devices. However, for generic drivers, we do not
> > >>want to list _HID for all supported devices. Also, certain classes of devices
> > >>do not have _CID (e.g. SATA, USB). Instead, we can leverage ACPI _CLS,
> > >>which specifies PCI-defined class code (i.e. base-class, subclass and
> > >>programming interface). This patch adds support for matching ACPI devices using
> > >>the _CLS method.
> > >>
> > >>To support loadable module, current design uses _HID or _CID to match device's
> > >>modalias. With the new way of matching with _CLS this would requires modification
> > >>to the current ACPI modalias key to include _CLS. This patch appends PCI-defined
> > >>class-code to the existing ACPI modalias as following.
> > >>
> > >>     acpi:<HID>:<CID1>:<CID2>:..:<CIDn>:<bbsspp>:
> > >>E.g:
> > >>     # cat /sys/devices/platform/AMDI0600:00/modalias
> > >>     acpi:AMDI0600:010601:
> > >>
> > >>where bb is th base-class code, ss is te sub-class code, and pp is the
> > >>programming interface code
> > >>
> > >>Since there would not be _HID/_CID in the ACPI matching table of the driver,
> > >>this patch adds a field to acpi_device_id to specify the matching _CLS.
> > >>
> > >>     static const struct acpi_device_id ahci_acpi_match[] = {
> > >>         { "", 0, PCI_CLASS_STORAGE_SATA_AHCI },
> > >
> > >How about introducing macro like PCI already has and then do it like:
> > >
> > >	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI) },
> > 
> > This is good.  I'll update this.
> > >
> > >Also should we allow mask here as well? This would allow partial match
> > >if, for example we are only interested in class and subclass.
> > 
> > Hm, I'm not familiar with how other drivers might be benefit from this.
> > Could you please give an example of a drivers that only deals with just the
> > class and/or subclass of devices?
> 
> If you check for example drivers/ata/ata_generic.c it has this:
> 
>         { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL),
> 	          .driver_data = ATA_GEN_CLASS_MATCH },
> 
> That seems to ignore programming interface.
> 
> > If so, could we use 0xFF to specify the don't care field?
> 
> In the above it seems that 0 is the don't care.
> 
> > >
> > >>         {},
> > >>     };
> > >>
> > >>In this case, the corresponded entry in modules.alias file would be:
> > >>
> > >>     alias acpi*:010601:* ahci_platform
> > >>
> > >>Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > >>---
> > >>  drivers/acpi/acpica/acutils.h     |  3 ++
> > >>  drivers/acpi/acpica/nsxfname.c    | 21 ++++++++++--
> > >>  drivers/acpi/acpica/utids.c       | 71 +++++++++++++++++++++++++++++++++++++++
> > >
> > >I think you need to split the ACPICA part to be a separate patch. Those
> > >are merged through ACPICA.
> > 
> > I will update this in the next patch set.
> > 
> > >>[....]
> > >>diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> > >>index e530533..9a42522 100644
> > >>--- a/include/linux/mod_devicetable.h
> > >>+++ b/include/linux/mod_devicetable.h
> > >>@@ -189,6 +189,7 @@ struct css_device_id {
> > >>  struct acpi_device_id {
> > >>  	__u8 id[ACPI_ID_LEN];
> > >>  	kernel_ulong_t driver_data;
> > >>+	__u32 cls;
> > >
> > >It would be nice if we could change ordering here but I understand that
> > >it breaks quite many drivers. Perhaps we should consider creating
> > >ACPI_DEVICE() macro and convert existing drivers to that at some point.
> > 
> > Yes, a roughly grep in the drivers directory showing about 112 files at the
> > moment. If you think this is the right approach going forward, we can work
> > on cleaning this up on a separate patch series. Please let me know what you
> > think.
> 
> I think having ACPI_DEVICE() macro would be pretty useful and it avoids
> things like this if we need to add new fields in the future. Rafael has
> the last word, though :-)

I agree.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
