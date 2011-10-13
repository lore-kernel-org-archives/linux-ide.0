From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_rdc: parallel scanning needs an extra locking
Date: Thu, 13 Oct 2011 18:08:31 +0200
Message-ID: <201110131808.31470.bzolnier@gmail.com>
References: <201110131606.04496.bzolnier@gmail.com> <20111013164923.23683fcb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111013164923.23683fcb@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:

> On Thu, 13 Oct 2011 16:06:04 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_rdc: parallel scanning needs an extra locking
> > 
> > This is similar change as commit 60c3be3 ("ata_piix: parallel scanning
> > on PATA needs an extra locking") for ata_piix host driver.
> 
> Again has anyone verified with the vendor that the RDC can support
> parallel scanning ?

Upstream has always used it:

commit 6b406782ad0408f9cb480c2e1b543d194e8206d0
Author: Alan Cox <alan@linux.intel.com>
Date:   Wed Jun 24 18:29:44 2009 +0100

    [libata] Add pata_rdc driver for RDC ATA devices
    
    From: Alan Cox <alan@linux.intel.com>
    
    Signed-off-by: Alan Cox <alan@linux.intel.com>
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
...
+
+       host->flags |= ATA_HOST_PARALLEL_SCAN;
+
...

My patch only adds needed locking.
