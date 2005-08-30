From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: Promise SATAII150 TX4: strange disk ordering
Date: Tue, 30 Aug 2005 20:31:59 +1000
Message-ID: <4314359F.2070100@eyal.emu.id.au>
References: <430E4AB0.2060600@eyal.emu.id.au> <4313E433.1080602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:27062 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751186AbVH3KcG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Aug 2005 06:32:06 -0400
In-Reply-To: <4313E433.1080602@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Eyal Lebedinsky wrote:
> 
>> I needed a 4-port SATA controller and this was was picked. It seems
>> to work OK, however I find that Linux (2.6.12.5 and .13-rc7) see
>> the disks in a different order than the labelled sockets (which do
>> match what the BIOS detection lists at bootup).
>>
>> It is not even the reverse order:
>>     TX4 socket    sata_promise ata*
>>     1        4
>>     2        2
>>     3        1
>>     4        3
>> This order looks stable - I connected a different number of disks
>> on some ports and this ordering was maintained.
> 
> 
> sata_promise driver just presents the devices in the order that the
> board maker has wired each port to the chip.  What may be labelled "port
> 3" on the board might be wired to the chip's port-0.  sata_promise just
> presents what it is given.
> 
>     Jeff

Seeing how people trust these number, the confusion is risky. I may
remove the wrong raid disk when it is reported offline and lose the
lot.

If we know the wiring (I assume this is stable for each board) why
not arrange the logical ports accordingly? Much more user friendly.

Thanks

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
