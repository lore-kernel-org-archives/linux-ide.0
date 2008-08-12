From: "Peter Wells" <pete.wells@gmail.com>
Subject: Re: IT8212 driver seems to be broken - no DMA or functionality in general
Date: Tue, 12 Aug 2008 13:22:55 +0100
Message-ID: <4405b24e0808120522y608f5bc7l60e205e6175def36@mail.gmail.com>
References: <4405b24e0808120446s14c42968t870de56a0af109c4@mail.gmail.com>
	 <4405b24e0808120449r7ce1466bm3387319549dbaa0b@mail.gmail.com>
	 <20080812125735.40f46775@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:21457 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbYHLMW4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 08:22:56 -0400
Received: by yw-out-2324.google.com with SMTP id 9so869188ywe.1
        for <linux-ide@vger.kernel.org>; Tue, 12 Aug 2008 05:22:55 -0700 (PDT)
In-Reply-To: <20080812125735.40f46775@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Hi Alan,

Thanks for your quick response.

Is there an existing patch that can be applied to some recent-ish
vanilla kernel source in order to fix libata and pata_it821x or would
it be best to wait until .27 ?

Kind regards,

Pete

2008/8/12 Alan Cox <alan@lxorguk.ukuu.org.uk>:
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
>
> Alan
>
