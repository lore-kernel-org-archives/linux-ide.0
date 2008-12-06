From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] remove ide-scsi
Date: Sun, 7 Dec 2008 00:45:41 +0100
Message-ID: <200812070045.42160.bzolnier@gmail.com>
References: <20081203103856S.fujita.tomonori@lab.ntt.co.jp> <493B022B.3050406@ru.mvista.com> <493B0A8E.7000506@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <493B0A8E.7000506@garzik.org>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Dan =?iso-8859-1?q?No=E9?= <dpn@isomerica.net>, James Bottomley <James.Bottomley@hansenpartnership.com>, Christoph Hellwig <hch@infradead.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, osst@riede.org
List-Id: linux-ide@vger.kernel.org

On Sunday 07 December 2008, Jeff Garzik wrote:
> Sergei Shtylyov wrote:
> > Hello.
> > 
> > Alan Cox wrote:
> >>> I think that for the time being it is best to just proceed with the 
> >>> removal
> >>> and see if there are any users needing the driver (+ we should 
> >>> probably try
> >>> SCSI/libata/osst path first).
> >>>     
> >>
> >> Far better to just leave it there. It generally works for users so all
> >> you are doing is creating a regression with no possible benefit (other
> >> than encouraging people to move to libata so we can obsolete all of
> >> drivers/ide - which is what we really need to do and move the last few
> >> users over)
> >>   
> > 
> >   Oh, yes. SCSI emulation is just what Linux embedded world is asking 
> > for...
> 
> The goal is to make SCSI emulation optional for ATA devices, by creating 
> a libata ATA block device driven by the libata driver framework.

Given five years this is too-less-too-late by my book.  Especially given
that you are still talking about the "goal" not the actual "code"...

Anyway this becomes offtopic to ide-scsi removal.
