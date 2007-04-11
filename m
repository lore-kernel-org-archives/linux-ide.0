From: Michael <michaelzwrk@gmail.com>
Subject: Re: IDE driver in polling mode
Date: Wed, 11 Apr 2007 17:10:12 +0200
Message-ID: <1ea6be8e0704110810l205f5dc7gb831603455a883e2@mail.gmail.com>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	 <461B9D04.2000109@ru.mvista.com>
	 <20070410171125.3aeed29d@the-village.bc.nu>
	 <461BB8C7.9050900@garzik.org>
	 <20070410172942.7f63d49c@the-village.bc.nu>
	 <1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>
	 <20070411094702.74774d25@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:13228 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbXDKPKN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 11:10:13 -0400
Received: by wr-out-0506.google.com with SMTP id 71so160439wri
        for <linux-ide@vger.kernel.org>; Wed, 11 Apr 2007 08:10:13 -0700 (PDT)
In-Reply-To: <20070411094702.74774d25@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-embedded@ozlabs.org, linux-ide@vger.kernel.org

I see.
The problem is I am constrained to 2.6.14 kernel.
Is it still correct to say it is P-ATA compatible?

On 4/11/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 11 Apr 2007 10:39:58 +0200
> Michael <michaelzwrk@gmail.com> wrote:
>
> > Doesn't libata have to do with SCSI devices? I'm afraid it wouldn't
> > work with CF, which is P-ATA compatible.
>
> libata drives PATA and SATA devices, including CF.
>
> > Wouldn't it work just to call ide_intr() explicitly from some polling
> > function, as Mark suggested?
>
> No. See the ATA spec - polling command issue is subtly different.
>
> Alan
>
