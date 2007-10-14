From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: [PATCH] pata_cs5536: ATA driver for Geode companion chip
Date: Sun, 14 Oct 2007 00:49:16 -0400
Message-ID: <76366b180710132149i7dabb3dcv21abaafd5814a923@mail.gmail.com>
References: <yq1y7eahzis.fsf@sermon.lab.mkp.net>
	 <20071011112021.3be68418@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:27912 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbXJNEtQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Oct 2007 00:49:16 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1147465rvb
        for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 21:49:16 -0700 (PDT)
In-Reply-To: <20071011112021.3be68418@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, jordan.crouse@amd.com

On 10/11/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Thu, 11 Oct 2007 03:38:19 -0400
> "Martin K. Petersen" <martin.petersen@oracle.com> wrote:
>
> >
> > This is a driver for the ATA controller on the Geode CS5536 companion
> > chip.  The PCI device ID for this device was previously claimed by
> > pata_amd.c but the PIO timings were not correct.  This driver also
> > works around a bug in some BIOSes that handle unaligned access to the
> > PCI config registers poorly.  Finally, the driver allows fallback to
> > using MSR registers for configuration on BIOSes that are truly
> > broken.
> >
> > Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>
> Acked-by: Alan Cox <alan@redhat.com>

I've been using the driver (boot drive on the port) since Martin's
post and haven't experienced any problems.

Tested-by: Andrew Paprocki <andrew@ishiboo.com>
