From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 14 May 2004 12:23:20 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084559000.4017.52.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:50892 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261610AbUENSXo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 14:23:44 -0400
In-Reply-To: <40A3E595.8000003@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> This is important because some AHCI SATA controllers can only transfer
> a _single_ DRQ block per disk transaction.  In anticipation of the
> demise of PIO, no doubt :)

Eh?  What's a "disk transaction"?

Do we mean to say that some SATA controllers choke over the (rare)
device rudeness of an INTRQ for every two bytes of the standard x24 (36)
bytes of op x12 (18) Inquiry, for example?

> ...

The rest of your instructions I believe I can follow as written.  Below
I explain why I find some of them surprising, in case that's interesting
or useful to anyone here.

Pat LaVarre

-----

> For an ATA device, we
> * write the taskfile, except for command
> * set up the DMA engine
> * write the command
> * write DMA-start bit
> 
> And the functions used by the low-level drivers, ata_bmdma_start_mmio 
> and ata_bmdma_start_pio, are hardcoded to use this ordering.  By 
> contrast, for ATAPI you should do:
> * set up DMA engine
> * write entire taskfile, including command
> * proceed through state diagram until DRQ==1
> * write SCSI CDB
> * write DMA-start bit

Why we care whether we write the taskfile apart from the command before
or after DMA engine setup, I do not understand.

> > +     int bcl = (8 * 0x400); /* PIO "byte count limit" */
> 
> Make this a more obvious "8 * 1024".

A point of pain for me moving into the world near linux-ide was
discovering that `dd` wanted me to say 512 rather than the more familiar
and plainly rounded value x200.

> For the sake of correctness, I prefer to call this "DRQ block size" 
> rather than the more ambigous "byte count limit".

"Byte count limit" is the unfortunate phrase found at t13.org.

I will assume I should use your term but may once provide a
cross-referencing translation to the standard unfortunate phrase as a
comment.

> > +     struct ata_taskfile *tf = &qc->tf;
> > +     tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> > +     tf->protocol = qc->dev->xfer_protocol;
> > +     tf->command = ATA_CMD_PACKET; /* often 0xA0 */
> 
> kill the comment, this should be obvious to anyone who reads the
> public specs.  That's why we have the constant, after all...

See below.

> > +             tf->feature = ATAPI_PKT_DMA; /* often x01 */
> 
> kill the comment

I understood your objection to: ATA_CMD_PACKET; /* often 0xA0 */
to mean I should never tell people what hovering the mouse over an
identifier should (but often doesn't) tell them.

Me, I didn't know ATA_CMD_PACKET meant xA0 until I looked it up.  I'm
likely to forget again in future.  ATA_CMD_PACKET is a Linux only term,
whereas "A0" I find in every source I read, be it xA0 or A0h or 0A0h
etc., be the source English, bus traces, machine code hex dumps, ....

> > +     } else {
> > +             DPRINTK("PIO ATAPI 0x%lX %d\n", qc->flags,
> qc->tf.protocol);
> > +             qc->tf.protocol = ATA_PROT_ATAPI;
> > +             tf->lbam = bcl >> 8;
> > +             tf->lbah = bcl;
> > +     }
> > +     qc->flags |= ATA_QCFLAG_ATAPI;
> > +     return 0;
> >  }
> 
> key flags that should be used, but are just being deleted in the 
> previous chunk:
> ATA_QCFLAG_SG
> ATA_NIEN
> ATA_QCFLAG_POLL
> 
> Their proper placement is left as an exercise to the reader, who seems
> to be doing well so far :)

Thank you for your kind words.

> > +     if (dev->class == ATA_DEV_ATAPI) { /* (thus !=
> ATA_DEV_ATAPI_UNSUP) */
> > +             return atapi_xlat;
> > +     }
> > +
>
> Remove the extraneous braces ... :)

Understood to mean do not enclose in { } unless two or more statements
appear as part of the then or else of an if.

> > +     if (dev->class == ATA_DEV_ATAPI) { /* (thus !=
> ATA_DEV_ATAPI_UNSUP) */
> > +             return atapi_xlat;
> > +     }
> > +
>
> Remove ... the comment :)

Will do, without me yet having fully confirmed that ATA_DEV_ATAPI_UNSUP
means known to be ATAPI but treated as ATA_DEV_UNKNOWN.

Pat LaVarre



