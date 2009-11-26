From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_it8213: MWDMA0 is unsupported
Date: Thu, 26 Nov 2009 19:00:11 +0100
Message-ID: <200911261900.11506.bzolnier@gmail.com>
References: <200911261728.36433.bzolnier@gmail.com> <200911261800.55025.bzolnier@gmail.com> <4B0EB986.2010801@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750993AbZKZSJ2@vger.kernel.org>
In-Reply-To: <4B0EB986.2010801@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 26 November 2009 06:23:18 pm Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>MWDMA0 timings cannot be met with the PIIX based controller
> >>programming interface.
> 
> >>This change should be safe as this is how we have been doing
> >>things in IDE it8213 host driver for years.
> 
> >>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >>---
> >>Verified with the documentation (similar case as with pata_efar).
> 
> > Uhhh, no...
> 
> > Too many damn drivers.
> 
> > Too much damn duplication.
> 
> > Too much damn subtle differences here and there.
> 
> > The hardware is probably fine for MWMDA0 when it comes to pata_{efar,it8213},
> > it just not documented properly in the data sheet.
> 
>     How so with pata_efar? The active/recovery bitfields are still 2-bit 
> wide, no?

Yes but when TIMEx bit is disabled we are using XFER_PIO_SLOW timings.

All data sheets including original Intel ones are a complete crap when it
comes to explicitly documenting this behavior.

--
Bartlomiej Zolnierkiewicz
