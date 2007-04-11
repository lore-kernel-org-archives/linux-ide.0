From: Michael <michaelzwrk@gmail.com>
Subject: Re: IDE driver in polling mode
Date: Wed, 11 Apr 2007 10:39:58 +0200
Message-ID: <1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	 <461B9D04.2000109@ru.mvista.com>
	 <20070410171125.3aeed29d@the-village.bc.nu>
	 <461BB8C7.9050900@garzik.org>
	 <20070410172942.7f63d49c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:15569 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXDKIkA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 04:40:00 -0400
Received: by nz-out-0506.google.com with SMTP id s1so73589nze
        for <linux-ide@vger.kernel.org>; Wed, 11 Apr 2007 01:39:59 -0700 (PDT)
In-Reply-To: <20070410172942.7f63d49c@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-embedded@ozlabs.org, linux-ide@vger.kernel.org

Doesn't libata have to do with SCSI devices? I'm afraid it wouldn't
work with CF, which is P-ATA compatible.

Wouldn't it work just to call ide_intr() explicitly from some polling
function, as Mark suggested?

Michael

On 4/10/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > The only real restriction in libata is in ata_device_add(), which
> > unconditionally registers an irq handler.  Make a few changes there, add
> > a few flags, and the existing polling code will kick in.
>
> Obvious thing to do would be to do this if the IRQ number passed in is 0
> rather than aborting as we do now. In theory ISAPnP devices may be
> IRQless too.
>
> Alan
>
