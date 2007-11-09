From: "Luca Tettamanti" <kronos.it@gmail.com>
Subject: Re: sata NCQ blacklist entry
Date: Fri, 9 Nov 2007 01:08:26 +0100
Message-ID: <68676e00711081608w53c497aciec60d19f2e71d230@mail.gmail.com>
References: <fa.GsS7Kps/lQSHlhBlf0yXpLzcPLQ@ifi.uio.no>
	 <fa.V2tP3GajMjY9gJUCTCoOjOocw+0@ifi.uio.no>
	 <fa.N0UZia/Lx8cvsvXXK1g9So2J6rk@ifi.uio.no> <47339C88.9050300@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932199AbXKIBGe@vger.kernel.org>
In-Reply-To: <47339C88.9050300@shaw.ca>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Tejun Heo <htejun@gmail.com>, jeff@garzik.org, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Nov 9, 2007 12:32 AM, Robert Hancock <hancockr@shaw.ca> wrote:
> Luca Tettamanti wrote:
> > On Nov 7, 2007 1:55 PM, Tejun Heo <htejun@gmail.com> wrote:
> >> Florian La Roche wrote:
> >>> Hello all,
> >>>
> >>> I've taking email addresses from the last NCQ blacklist changes going
> >>> into the kernel.
> >>> This Fujitsu drive also gives me spurious command completions. Detailed
> >>> output also available at https://bugzilla.redhat.com/show_bug.cgi?id=366181.
> >>>
> >>> Let me know if you need more info or anything else.
> >>>
> >>> --- drivers/ata/libata-core.c
> >>> +++ drivers/ata/libata-core.c
> >>> @@ -4222,6 +4222,7 @@
> >>>       { "WDC WD740ADFD-00NLR1", NULL,         ATA_HORKAGE_NONCQ, },
> >>>       { "WDC WD3200AAJS-00RYA0", "12.01B01",  ATA_HORKAGE_NONCQ, },
> >>>       { "FUJITSU MHV2080BH",  "00840028",     ATA_HORKAGE_NONCQ, },
> >>> +     { "FUJITSU MHW2160BJ G2",       NULL,           ATA_HORKAGE_NONCQ },
> >>>       { "ST9120822AS",        "3.CLF",        ATA_HORKAGE_NONCQ, },
> >>>       { "ST9160821AS",        "3.CLF",        ATA_HORKAGE_NONCQ, },
> >>>       { "ST9160821AS",        "3.ALD",        ATA_HORKAGE_NONCQ, },
> >> Thanks.  We're currently trying to find out what's actually going on
> >> with all these drives.  At first, drives which got blacklisted aren't
> >> many and made sense (had other problems with NCQ, etc..) but with new
> >> generation drives from many vendors showing the same symptom, we aren't
> >> too sure now.
> >
> > Is there a way to tell whether Windows is using NCQ or not? I checked
> > the system log (or whatever it's called) on my notebook and is clean
> > but I'm not sure it's using NCQ (I don't even know if it'd log
> > spurious completions somewhere).
>
> Which driver is installed for the SATA controller in Windows, the
> chipset-manufacturer-provided AHCI driver or the default Microsoft
> driver? You'd need the AHCI driver installed for NCQ to be used.

I'm aware of this. I'm using the AHCI driver (from Intel). Still, I
don't know if it's really used or limited like under Linux.

Luca
