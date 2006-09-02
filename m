From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.18-rc5-mm1
Date: Sat, 02 Sep 2006 01:47:43 -0700
Message-ID: <44F9452F.8090306@goop.org>
References: <20060901015818.42767813.akpm@osdl.org> <1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org> <44F93EB3.8050500@goop.org> <44F942B9.6050102@goop.org> <20060902084440.GA13361@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20060902084440.GA13361@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Matthias Hentges <oe@hentges.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-ide@vger.kernel.org

Greg KH wrote:
> There are 9 MSI patches in my tree that you can just remove.  They were
> just recently (a few hours ago) replaced with a total rewrite due to a
> number of different problems that were found.  So I'd suggest just
> waiting till the next -mm release to see if it works properly or not.
>   

This lot?

gregkh-pci-msi-01-merge_msi_disabling_quirks.patch
gregkh-pci-msi-02-factorize_pci_msi_supported.patch
gregkh-pci-msi-03-add_pci_device_exp_type.patch
gregkh-pci-msi-04-use_root_chipset_dev_no_msi_instead_of_pci_bus_flags.patch
gregkh-pci-msi-05-add_no_msi_to_sysfs.patch
gregkh-pci-msi-06-rename_pci_cap_id_ht_irqconf.patch
gregkh-pci-msi-07-check_hypertransport_msi_capabilities.patch
gregkh-pci-msi-08-drop_pci_msi_quirk.patch
gregkh-pci-msi-09-drop_pci_bus_flags.patch

    J

-- 
VGER BF report: H 0
