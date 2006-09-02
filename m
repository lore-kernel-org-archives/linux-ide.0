From: Greg KH <gregkh@suse.de>
Subject: Re: 2.6.18-rc5-mm1
Date: Sat, 2 Sep 2006 01:52:54 -0700
Message-ID: <20060902085254.GA14123@suse.de>
References: <20060901015818.42767813.akpm@osdl.org> <1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org> <44F93EB3.8050500@goop.org> <44F942B9.6050102@goop.org> <20060902084440.GA13361@suse.de> <44F9452F.8090306@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <44F9452F.8090306@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Matthias Hentges <oe@hentges.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-ide@vger.kernel.org

On Sat, Sep 02, 2006 at 01:47:43AM -0700, Jeremy Fitzhardinge wrote:
> Greg KH wrote:
> >There are 9 MSI patches in my tree that you can just remove.  They were
> >just recently (a few hours ago) replaced with a total rewrite due to a
> >number of different problems that were found.  So I'd suggest just
> >waiting till the next -mm release to see if it works properly or not.
> >  
> 
> This lot?
> 
> gregkh-pci-msi-01-merge_msi_disabling_quirks.patch
> gregkh-pci-msi-02-factorize_pci_msi_supported.patch
> gregkh-pci-msi-03-add_pci_device_exp_type.patch
> gregkh-pci-msi-04-use_root_chipset_dev_no_msi_instead_of_pci_bus_flags.patch
> gregkh-pci-msi-05-add_no_msi_to_sysfs.patch
> gregkh-pci-msi-06-rename_pci_cap_id_ht_irqconf.patch
> gregkh-pci-msi-07-check_hypertransport_msi_capabilities.patch
> gregkh-pci-msi-08-drop_pci_msi_quirk.patch
> gregkh-pci-msi-09-drop_pci_bus_flags.patch

Yes, try reverting them and see if your machine works again.

thanks,

greg k-h

-- 
VGER BF report: H 0
