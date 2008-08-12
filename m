From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: IT8212 driver seems to be broken - no DMA or functionality in general
Date: Tue, 12 Aug 2008 14:47:08 +0200
Message-ID: <58cb370e0808120547t75cad09ci973f668d4e8fc6fd@mail.gmail.com>
References: <4405b24e0808120446s14c42968t870de56a0af109c4@mail.gmail.com>
	 <4405b24e0808120449r7ce1466bm3387319549dbaa0b@mail.gmail.com>
	 <20080812125735.40f46775@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:62025 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbYHLMrK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 08:47:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1337512fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 12 Aug 2008 05:47:08 -0700 (PDT)
In-Reply-To: <20080812125735.40f46775@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Wells <pete.wells@gmail.com>, linux-ide@vger.kernel.org

On Tue, Aug 12, 2008 at 1:57 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> The post is located at http://kerneltrap.org/node/16482 and looks like this:
>>
>> IT8212 driver seems to be broken - no DMA or functionality in general
>
> I sent Jeff a set of fixes for this for the libata driver. Some changes
> in libata broke some tricks the pata_it821x driver did. I've rewritten
> those bits and parts of the core libata to sort that out and my IT821x
> RAID card is back to health with libata. Hopefully .27 will behave
> somewhat better therefore.
>
> No idea about the old IDE driver. I don't think anyone maintains that one
> any more but it certainly used to work.

It should still work.  Peter, please try with 2.6.27-rc2 (2.6.26 needs
a fix which is queued for the next -stable release).
