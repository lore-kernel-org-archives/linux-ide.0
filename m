From: Joerg Roedel <joro@8bytes.org>
Subject: Re: Supermicro X9SRL-F - channel enumeration error & ACPI/firmware
 bug question
Date: Sun, 2 Dec 2012 14:26:49 +0100
Message-ID: <20121202132649.GM30633@8bytes.org>
References: <CAErSpo7530xA6=1Ytj09dwyS1M_N_yAfk4xkr3f9Z_NBn6TJrA@mail.gmail.com>
 <00a501cdcca3$c2638510$472a8f30$@lucidpixels.com>
 <00b501cdcca6$03f88af0$0be9a0d0$@lucidpixels.com>
 <50B6ADA5.2030205@gmail.com>
 <04b301cdcdcb$65e2f400$31a8dc00$@lucidpixels.com>
 <CADLC3L09uxX_AU+22nfS20DCE97n1_ZxkG5A1R9joJcEua-EBg@mail.gmail.com>
 <02d501cdce0f$4b0ce520$e126af60$@lucidpixels.com>
 <CAErSpo7MpFrSX9rVH48A4mvsRdBjQybqiocv3nrZOPoK_+aqcw@mail.gmail.com>
 <CADLC3L1BAgQCbi1V=N0CRkJxbaQVK36q4pzbdnanO60exFem4w@mail.gmail.com>
 <CAErSpo6zvcN3aS_5ZNFD04yGNm_ehrNY_VUjO=172PSMKZYe+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 8bytes.org ([85.214.48.195]:45476 "EHLO mail.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab2LBN0x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2012 08:26:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.8bytes.org (Postfix) with SMTP id C97AA12B1F5
	for <linux-ide@vger.kernel.org>; Sun,  2 Dec 2012 14:26:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAErSpo6zvcN3aS_5ZNFD04yGNm_ehrNY_VUjO=172PSMKZYe+A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, support@supermicro.com, linux-kernel@vger.kernel.org, Dan Williams <djbw@fb.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org

On Thu, Nov 29, 2012 at 08:38:53PM -0700, Bjorn Helgaas wrote:
> That's essentially the patch at
> https://bugzilla.redhat.com/show_bug.cgi?id=757166#c16, which in my
> opinion is too ugly to consider.  But fortunately, I'm not the
> maintainer for any IOMMU drivers.

There is a quirk infrastructure for those kinds of broken devices in
drivers/pci/quirks.c. Have a look into the function
pci_get_dma_source(). This function is used by the IOMMU drivers to
create the correct mappings.


	Joerg


