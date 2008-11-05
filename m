From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata-rb532-cf: read and write data in 4-byte blocks
Date: Wed, 05 Nov 2008 14:54:44 +0300
Message-ID: <49118984.7090004@ru.mvista.com>
References: <490E1A63.3040507@ru.mvista.com> <1225718954-8307-1-git-send-email-n0-1@freewrt.org> <490FE535.8080109@garzik.org> <20081104123504.GA14551@nuty>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:5620 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755306AbYKELyv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Nov 2008 06:54:51 -0500
In-Reply-To: <20081104123504.GA14551@nuty>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Phil Sutter wrote:

>>> * rename the offset definition to avoid abiguity with the standard ATA
>>>  IO address
>>> * read and write four bytes at once
>>> * use writesl() and readsl() which implicitly iterate over the data
>>> * fix the signature of rb532_pata_data_xfer() to match the function
>>>  pointer definition and return the number of bytes consumed
>>>
>>> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
>>> Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>
>>> ---
>>> drivers/ata/pata_rb532_cf.c |   21 ++++++++++-----------
>>> 1 files changed, 10 insertions(+), 11 deletions(-)
>>>       
>> None of this description says _why_ you wish to do this.  Also, maybe I 
>> missed the response, what about ATAPI?
>>     
>
> Well, Sergei Shtylyov pointed out that the original driver does transfer
> data at 4-byte blocks, so I changed it accordingly and tested it.
> Hopefully this will provide a performance gain, though I did not do any
> performance tests and therefore can't tell if that's really the case.
>   

   Might've been worth to put this into separate patch, apart from the 
fix for the function prototype.

> I had interpreted Sergei's response to my BUG_ON() statement for it to
> be unnecessary, which may be wrong.

   You misintepreted my response. :-)

> I don't know if it's possible to
> connect ATAPI devices to the on board CompactFlash slot, maybe you can
>   

   I don't think so.

> give me some hints on this. OTOH I see that the sector size is hard
> coded in the original driver to 0x200, so I guess either ATAPI is not
> possible or at least not with the original driver, right?
>   

   If ATAPI was indeed possible, BUG() wouldn't have been an option.
   I've just remembered about the READ/WRITE LONG commands which might 
cause byte count to not be divisible by 4 (although by default ECC is 
4-byte entity and CF 1.4 says that this is the ony option).

MBR, Sergei


