From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.20-git10 (and -git13): BUG at drivers/pci/pci.c:817 during resume from disk
Date: Sun, 25 Feb 2007 17:32:00 +0100
Message-ID: <20070225163200.GZ12392@stusta.de>
References: <200702150016.24865.rjw@sisk.pl> <200702151223.44846.rjw@sisk.pl> <200702171100.39114.rjw@sisk.pl> <45DA6E6D.5030700@gmail.com> <20070224230259.GU12392@stusta.de> <45E1107A.2040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43849 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751118AbXBYQcB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Feb 2007 11:32:01 -0500
Content-Disposition: inline
In-Reply-To: <45E1107A.2040708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>

On Sun, Feb 25, 2007 at 01:28:42PM +0900, Tejun Heo wrote:
> Hello, Adrian.
> 
> Adrian Bunk wrote:
> > On Tue, Feb 20, 2007 at 12:43:41PM +0900, Tejun Heo wrote:
> >> Rafael J. Wysocki wrote:
> >>> Update:
> >>>
> >>> I get the same BUG with 2.6.20-git13 100% of the time during the resume.
> >>> The system seems to be fully functional nonetheless.
> >> Known bug, will be fixed soon.
> > 
> > Is this a variation of
> > 
> > Subject    : HP nx6325: usb mouse stops working after resume from ram
> > References : http://lkml.org/lkml/2007/2/21/413
> > Submitter  : Arkadiusz Miskiewicz <arekm@maven.pl>
> > Caused-By  : Konstantin Karasyov <konstantin.a.karasyov@intel.com>
> >              commit 0a6139027f3986162233adc17285151e78b39cac
> > Status     : unknown
> > 
> > or one of the other ACPI problems in 2.6.21-rc1?
> 
> No, it's not related to ACPI.  It's caused by devres changes and fixed
> in libata-dev tree.

I'm currently a bit lost with all the ATA/ACPI/suspend regression 
reports...

Which patch fixes this regression?

> tejun

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

