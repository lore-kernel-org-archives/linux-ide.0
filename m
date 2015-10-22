From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: add support for NCQ commands for SG interface
Date: Thu, 22 Oct 2015 17:57:17 +0900
Message-ID: <20151022085717.GB24379@mtj.duckdns.org>
References: <1445082519-8160-1-git-send-email-vinayak.kale@seagate.com>
 <CACLWs=VWXTd6ZcDQCGXHkngf72RpiqDVkZKXrWJC7Rmx_giWsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33592 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178AbbJVI5Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2015 04:57:25 -0400
Content-Disposition: inline
In-Reply-To: <CACLWs=VWXTd6ZcDQCGXHkngf72RpiqDVkZKXrWJC7Rmx_giWsA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vinayak Kale <vinayak.kale@gmail.com>
Cc: sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On Wed, Oct 21, 2015 at 10:39:32AM +0530, Vinayak Kale wrote:
...
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 0d7f0da..5b0a5ab 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -2914,12 +2914,14 @@ ata_scsi_map_proto(u8 byte1)
> >         case 5:         /* PIO Data-out */
> >                 return ATA_PROT_PIO;
> >
> > +       case 12:        /* FPDMA */
> > +               return ATA_PROT_NCQ;
> > +
> >         case 0:         /* Hard Reset */
> >         case 1:         /* SRST */
> >         case 8:         /* Device Diagnostic */
> >         case 9:         /* Device Reset */
> >         case 7:         /* DMA Queued */
> > -       case 12:        /* FPDMA */
> >         case 15:        /* Return Response Info */
> >         default:        /* Reserved */
> >                 break;
> > @@ -2963,7 +2965,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
> >                         tf->hob_lbal = cdb[7];
> >                         tf->hob_lbam = cdb[9];
> >                         tf->hob_lbah = cdb[11];
> > -                       tf->flags |= ATA_TFLAG_LBA48;
> > +                       tf->flags |= (ATA_TFLAG_LBA48 | ATA_TFLAG_LBA);
> >                 } else
> >                         tf->flags &= ~ATA_TFLAG_LBA48;
> >
> > @@ -2992,6 +2994,10 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
> >                 tf->command = cdb[9];
> >         }
> >
> > +       /* For NCQ commands with FPDMA protocol, copy the tag value */
> > +       if (tf->protocol == ATA_PROT_NCQ)
> > +               tf->nsect = qc->tag << 3;
> > +
> >         /* enforce correct master/slave bit */
> >         tf->device = dev->devno ?
> >                 tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;
>
> Any comments on this?

It looks like it'd work given that it's forcing qc->tag into
tf->nsect.  What's the use case tho?

Thanks.

-- 
tejun
