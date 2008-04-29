From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support (revised)
Date: Tue, 29 Apr 2008 11:41:16 +0800
Message-ID: <20080429114116.38c7d56c@dxy.sh.intel.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080428094123.59d055c7@core>
	<20080428170751.097bdbe6@dxy.sh.intel.com>
	<200804282101.33012.bzolnier@gmail.com>
	<20080429081411.47fef877@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29643 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874AbYD2DsG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 23:48:06 -0400
In-Reply-To: <20080429081411.47fef877@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, 29 Apr 2008 08:14:11 +0800
Alek Du <alek.du@intel.com> wrote:

> > needs to be defined (which will lack .enablebits field but otherwise
> > be identical to DECLARE_ICH_DEV)
> > 
> I do not understand here, where DECLARE_ICH_DEV() used here? I just defined a new sub_type
> sch_pata_100, and inherit most ops from piix instead of cable_detect and prereset. 
>

I see now. I posted a new patch which defined DECLARE_SCH_DEV. Thanks a lot.

> > also seems that piix_cable_detect() should be updated to check for
> > dev->device == PCI_DEVICE_ID_INTEL_SCH_IDE and return ATA_CBL_PATA80
> > (it is OK to use it instead of ATA_CBL_UNK in drivers/ide/ - generic
> > cable detection code won't override drive side cable detection).
> >
> My first version of patch is to modify piix_cable_detect like your way. But Alan suggested
> use this way -- it is much cleaner. And according to my test, return ATA_CBL_UNK do no harm.
> The driver is set to UDMA5 when 80 cable is used.
>  
> > otherwise everything looks good
> > 
> > Thanks,
> > Bart
> 
> Thanks,
> Alek
