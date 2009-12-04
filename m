From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_hpt3x2n: fix timing register masks (take 2)
Date: Sat, 05 Dec 2009 02:34:45 +0300
Message-ID: <4B199C95.7080708@ru.mvista.com>
References: <200912042330.23507.sshtylyov@ru.mvista.com> <20091204232923.6daacb23@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:38028 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932380AbZLDXez (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Dec 2009 18:34:55 -0500
In-Reply-To: <20091204232923.6daacb23@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

Hello.

Alan Cox wrote:

>> - the driver doesn't serialize access to the channels depending on the current
>>   clock mode like the vendor drivers, so the clock turnaround is only executed
>>   "optionally", not always as it should be;
>>     
>
> The vendor driver I have uses that algorithm. I think I prefer your
> approach however !
>
>   

   Does it have the *ClockCapable() things? These functions seem to 
implement command deferring much like hpt3x2n_qc_defer() does now.

>> - the wrong ports are written to when hpt3x2n_set_clock() is called for the
>>   secondary channel;
>>     
>
> Ouch.
>   

   Same as in the IDE driver... I really should have taken a closer look 
at the libata driver earlier.

>> - hpt3x2n_set_clock() can inadvertently enable the disabled channels when
>>   resetting the channel state machines.
>>     
>
> Yep.
>   

   Same as in IDE driver too. I guess you've copied this from the vendor 
driver that also does this.

>   
>> Could you give this a bit of testing? I don't have HPT371N at hand, and it's
>> seated in the board with 66 MHz PCI anyway...
>>     
>
> I'm not likely to have a chance to do so until next year.
>   

   That's a pity... well, then we probably have to commit it untested. :-)

MBR, Sergei


