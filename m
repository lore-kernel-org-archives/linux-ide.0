From: Tejun Heo <htejun@gmail.com>
Subject: Re: regarding ata_msg_*()
Date: Tue, 27 Jun 2006 12:23:30 +0900
Message-ID: <44A0A4B2.7010001@gmail.com>
References: <449E7FB9.4080305@gmail.com> <20060626074132.GA10695@gollum.tnic> <449F9427.1080806@gmail.com> <20060626083459.GA13039@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:34499 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933331AbWF0DXh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 23:23:37 -0400
Received: by nz-out-0102.google.com with SMTP id o1so83186nzf
        for <linux-ide@vger.kernel.org>; Mon, 26 Jun 2006 20:23:36 -0700 (PDT)
In-Reply-To: <20060626083459.GA13039@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Borislav Petkov wrote:
>> My suggestion is to keep the current (pre-msg_enable) model for the 
>> first conversion and categorize debug messages further after that.  So, 
>> message categories will be...
>>
>> ATA_MSG_ERR
>> ATA_MSG_WARN
>> ATA_MSG_INFO
>> -------------> all above are enabled by default
>> ATA_MSG_DEBUG
>> ATA_MSG_VDEBUG
>>
>> Then, you have 1-to-1 mapping w/ the existing messages.  You can simply 
>> incorporate message enabled tests into ata_*_printk() functions and the 
>> conversion would be trivial.
>>
>> After that's complete, we can diversify ATA_MSG_DEBUG and ATA_MSG_VDEBUG 
>> by separating out chatty ones out.  e.g. you can separate out SG 
>> mapping/unmapping (including padding) debug messages, which produce 
>> massive amount of logs when enabled, into ATA_MSG_SG or something. 
>> After several such separations, debug messages should be quite 
>> manageable && the categories wouldn't be too elaborate.
> 
> Yes, this sounds logical, I like it, it really fits libata more but at the time
> I made that msg classification I kinda wanted to stick closely to Becker's
> initial implementation :). But you're perfectly right, this is the way to go so
> I'll do that after reading what the others have to say. However, as I said
> before, IMHO it would be of higher priority now to convert to this new scheme
> and changing the dbg levels later would be trivial once we got all of libata
> done.

Jeff, what do you think?

Borislav, can you restore configuration messages in ata_dev_configure()? 
  Those messages need to be printed.

Thanks.

-- 
tejun
