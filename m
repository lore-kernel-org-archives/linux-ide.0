From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 17:23:40 +0300
Message-ID: <45FAA86C.5080607@ru.mvista.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	<45F56800.3040104@rtr.ca>	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>	<45F5A523.1080500@rtr.ca>	<45FA8D7A.3040504@rtr.ca> <20070316150129.5bd65c9d@lxorguk.ukuu.org.uk> <45FAA692.8080507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33285 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965138AbXCPOXz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 10:23:55 -0400
In-Reply-To: <45FAA692.8080507@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Alan Cox wrote:
> 
>>> The fussy bit is that these commands require a non-standard
>>> sector size, usually 520 bytes instead of 512.

>> Do we always know the worst case here as this breaks my pending patch to
>> use bounce buffers for PIO so we transfer with IRQ enabled and I need to
>> know the correct new worst case size.

> Ugh.  The drives default to 520 bytes (always),

    The old IDE drives used to have 4 and 7 byte ECC (seen in ancient Phoenix 
BIOS).

> but can specify a different, preferred, length in
> the IDENTIFY data.  A SETFEATURES command is required
> to change the setting from the default of 520.

    You're wrong here (which is explainable by your patch bneing boken 
protocol wise) -- there used to be two subcodes, one to selecyt vendor spcific 
length (0x44), and one to selectt 4-byte ECC (0xBB). Not 8-byte!

> In practice, I only ever use 520, because (1) it always works,
> and (2) I'm only trying to corrupt drives, not write correct stuff. ;)

> So we could modify the patch to limit it to a specific maximum,
> or always require exactly 520 bytes without any hardship.

> ???

    Certainly not the second. Vendor ECC length is indicated in the word 22 
identify device info. Not sure how this gets translated to SCSI...

WBR, Sergei
