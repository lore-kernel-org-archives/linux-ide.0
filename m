From: "kiran vedere" <vederekiran@gmail.com>
Subject: Re: libata-core.c
Date: Thu, 25 Sep 2008 09:32:42 -0400
Message-ID: <679aeaf0809250632m74f80fdex5a86af7e03052888@mail.gmail.com>
References: <679aeaf0809241511yf6cd812oa1ed5f3a1a37cfba@mail.gmail.com>
	 <20080924232449.299b5158@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:59439 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbYIYNcn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Sep 2008 09:32:43 -0400
Received: by wf-out-1314.google.com with SMTP id 27so496584wfd.4
        for <linux-ide@vger.kernel.org>; Thu, 25 Sep 2008 06:32:43 -0700 (PDT)
In-Reply-To: <20080924232449.299b5158@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Alan:

Thanks a lot for the clarification.

Regards,
kiran

On Wed, Sep 24, 2008 at 6:24 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> 1. Is this library generic for all platforms or is it specific to PC
>> because it seems to reference PCI in some places. If I have my host
>> controller driver, is the current pata_pcmcia.c (and libata helper
>> libraries) sufficient to use the Compact Flash in True-IDE mode or
>> something additional is needed.
>
> libata is generic.
>
>> 2. The CF TrueIDE mode supports Multiword DMA and Ultra DMA modes of
>> data transfer. Your libata-core.c seems to have support for these
>> modes. However I assume I will need to provide the DMA Buffer to
>> facilitate this. Do I need to provide call back functions to do this
>> or I need to implement a seperate Client Driver to support these
>> modes? I assume the pata_pcmcia.c uses PIO mode by default? Correct me
>> if I am wrong.
>
> If you are in trueide mode the device behaves as an IDE disk, so you will
> need a driver for whatever ATA controller is being used.
>
> If you are in PCMCIA mode then you only get PIO0 and the pata_pcmcia
> driver drives the CF card with the CF card acting as a PCMCIA ATA
> controller
>
> Alan
>
