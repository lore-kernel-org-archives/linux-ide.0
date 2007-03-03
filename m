From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_cmd640: CMD640 PCI support
Date: Sat, 03 Mar 2007 22:38:05 +0300
Message-ID: <45E9CE9D.9030807@ru.mvista.com>
References: <20070302150306.368e24b9@lxorguk.ukuu.org.uk>	<45E8B28D.7030500@garzik.org>	<45E9AC6B.50701@ru.mvista.com> <20070303203339.6f605ac9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:46304 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030404AbXCCTiQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Mar 2007 14:38:16 -0500
In-Reply-To: <20070303203339.6f605ac9@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>>+    if (t.active > 16)
>>>>+        t.active = 16;
>>
>>    Erm, clamping active time is not a right thing to do. Right thing to do 
>>was to bail out. I didn't do it in the legacy driver rewrite though...

> As far as I can work out its a "can't happen"

>>>>+        pci_read_config_byte(pdev, ARTIM23, &reg);

>>    It's not even expensive, it may be just unsafe.

> You have to serialize the channels and idle both so its very expensive -
> or is that what you meant by unsafe.

    I meant that the address setup timing should always match that of a slower 
device -- *no* switching.

>>>>+    /* CMD640 detected, commiserations */
>>>>+    pci_write_config_byte(pdev, 0x5C, 0x00);

>>>magic number

>>   Indeed, completely undocumented. And I don't even see it in the legacy 
>>driver...

> Should be 0x5B which is still undocumented. Will fix that.

    Ah, that's what became DRWTIM3 in the later chips?

>>    It's used to be a well known fact (soon after Intel put that chip on their 
>>motherboards :-) that PCI0640 may return bad data on command block reads if 
>>another channel has data port I/O going on. That's why the interrupts needed 
>>to be disabled during PIO in the legacy driver (and the channels serialized).

> I was under the impression this was only the situation with the
> FIFO/readahead logic enabled, as with the RZ1000 ?

    Sorry, I mixed up with RZ1000 for the Intel's case -- memory fade. :-<

> Can you clarify that at all ?

    Yeah, it was happening with IDE prefetch of course...

> Alan

WBR, Sergei
