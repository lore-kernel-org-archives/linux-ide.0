From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Question about PATA Sil680 Cache Line Size and Performance Degradation on ARM XScale
Date: Wed, 21 Feb 2007 18:21:38 -0700
Message-ID: <8202f4270702211721o1629aa63q3670823b7348df1f@mail.gmail.com>
References: <8202f4270702211456h52498bbdk560d9d47e2e319d7@mail.gmail.com>
	 <20070222000400.2c220b8f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:38241 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422857AbXBVBVj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 20:21:39 -0500
Received: by nz-out-0506.google.com with SMTP id s1so17348nze
        for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 17:21:39 -0800 (PST)
In-Reply-To: <20070222000400.2c220b8f@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 2/21/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 21 Feb 2007 15:56:28 -0700
> "Fajun Chen" <fajunchen@gmail.com> wrote:
>
> > Hi Folks,
> >
> > I've noticed the following code in both pata_sil680.c and IDE code siimage.c
> >         /* FIXME: double check */
> >       pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, (class_rev) ? 1 : 255);
> > I was unable to find the recommended setting in Sil680 document. Could
> > someone explain the rational behind the code above? Does it need to be
> > adjusted on different processors for PCI read/write performance?
>
> The code is inherited from the original bits by Andre Hedrick who had
> access to the chip errata documents, which afaik have never been
> published.
>
Thanks for the update, Alan.

I did another experiments by changing Cache Line Size to 0x02 and
Latency Timer to 0x40 and the performance of PCI Read (Read DMA) has
been  almost doubled.  So this seems there may be room for further
performance enhancement by tweaking PCI configuration.  One concern
about the latency timer change is increased bus hold time, could this
delay other applications which shares the PCI bus?

Since Sil3124 has better PCI read/write performance, as a reference,
could someone explain or point me to the PCI configuration code for
Sil3124? I couldn't find it in sata_sil24.c.

The kernel version used is 2.6.18-rc2 and libata version is 2.00.

Thanks,
Fajun
