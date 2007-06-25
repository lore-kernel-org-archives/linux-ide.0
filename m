From: Robert de Rooy <robert.de.rooy@gmail.com>
Subject: Re: libata and legacy ide pcmcia failure
Date: Mon, 25 Jun 2007 11:31:55 +0200
Message-ID: <467F8B8B.1000006@gmail.com>
References: <466718B6.4080105@gmail.com> <4667B39D.209@gmail.com> <46685AE5.4010908@gmail.com> <466900F3.7040801@gmail.com> <46694FB2.6040007@pobox.com> <4669D2D8.3020806@gmail.com> <4669D3F5.7040300@rtr.ca> <466B4D86.1020808@gmail.com> <466C631D.2000001@rtr.ca> <466C723C.6000300@gmail.com> <20070610221322.GA18196@flint.arm.linux.org.uk> <466C7A9F.1080700@rtr.ca> <466DCE55.30507@gmail.com> <466DCF43.5060304@pobox.com> <466E11DF.5020901@gmail.com> <466F4A27.8070309@tw.ibm.com> <46710CD7.9070901@gmail.com> <467BB7DB.4090004@gmail.com> <467BCF86.8060508@rtr.ca> <467F3EDC.2060002@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.176]:6437 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbXFYJbv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 05:31:51 -0400
Received: by ik-out-1112.google.com with SMTP id b32so989091ika
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 02:31:49 -0700 (PDT)
In-Reply-To: <467F3EDC.2060002@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Jeff Garzik <jeff@garzik.org>, bzolnier@gmail.com, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> Mark Lord wrote:
>   
>> ...
>>
>> Mmm.. I don't know about the first failure there,
>> but after that it gets into the "stuck DRQ" state
>> which libata makes no attempt to handle at present.
>>
>>     
>
> It seems the pata_pcmcia driver is using IRQ driven PIO. Maybe Robert
> could try the following pio_polling patch first.
>   

I did not get the chance to try Marks patch, but the pio_polling patch 
from Albert works!!
