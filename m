From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_hpt{37x|3x2n}: fix timing register masks
Date: Fri, 27 Nov 2009 00:18:28 +0300
Message-ID: <4B0EF0A4.1000201@ru.mvista.com>
References: <200911242315.52826.sshtylyov@ru.mvista.com> <20091124212006.4730aacf@lxorguk.ukuu.org.uk> <200911262151.05067.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:9900 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751032AbZKZVSi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 16:18:38 -0500
In-Reply-To: <200911262151.05067.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>> These drivers inherited from the older 'hpt366' IDE driver the buggy timing
>>> register masks in their set_piomode() metods. As a result, too low command
>>> cycle active time is programmed for slow PIO modes.  Quite fortunately, it's
>>> later "fixed up" by the set_dmamode() methods which also "helpfully" reprogram
>>> the command timings, usually to PIO mode 4.
>>>
>>> However, the drivers added some breakage of their own too:  the bit that they
>>> set/clear to control the FIFO is wrong -- it's actually the MSB of the command
>>> cycle setup time; setting it in DMA mode is also wrong as this bit is only for
>>> PIO actually...
>>>
>>> Fix all this and bump the drivers' versions, accounting for recenjt patches
>>> that forgot to do it...
>>>       
>
> Sergei, pata_hpt37x contains another copy of ->set_{piomode,dmamode} methods
> (for HPT372 and later chipsets) which also need to be updated.
>   

   Oh, horror... :-(
   They also all need to be squashed together and the interrupt bit 
manipulation moved to some other place...

>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>>       
>> Acked-by: Alan Cox <alan@linux.intel.com>
>>     
>
> --
> Bartlomiej Zolnierkiewicz
>   

MBR, Sergei


