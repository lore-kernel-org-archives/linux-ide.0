From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Mon, 30 Apr 2007 09:54:59 +0900
Message-ID: <46353E63.7070000@gmail.com>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <4634163D.1040408@gmail.com> <463487F0.4040701@rtr.ca> <46349695.7080706@rtr.ca> <46349A03.9090300@rtr.ca> <4634CAEC.4010700@gmail.com> <4634CC18.4080208@rtr.ca> <4634E8B3.4050301@rtr.ca> <4634ED0D.1090709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:4117 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbXD3DAE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Apr 2007 23:00:04 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1792011nzf
        for <linux-ide@vger.kernel.org>; Sun, 29 Apr 2007 20:00:02 -0700 (PDT)
In-Reply-To: <4634ED0D.1090709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Mark Lord wrote:
>>
>> ###### Test stuck DRQ on VIA-sata (disk):
>>
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata1.00: cmd ec/00:00:00:00:00/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
>>         res 58/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
> 
> Why do we not always put a '\n' in front of that last line above ??
> Sometimes it seems to have it, and lots of times it does not have a '\n'.
> Weird.
> 
>> ###### Test stuck DRQ on VIA-pata (ATAPI DVD/RW):
>> ###### Notice how the first "ata4.00: cmd ..." line is *missing*:
>>
>>         res 58/00:02:00:00:02/00:00:00:00:00/40 Emask 0x2 (HSM violation)
>> ata4: soft resetting port
>> ata4.00: configured for UDMA/66
>> ata4: EH complete
> 
> And in this case, the first line of diagnostics (the "cmd" line)
> is always missing.  Why?

Hmmm... that's very weird.  I've never seen such problems.  The report
messages are printed in ata_eh_report() and both the cmd and res lines
are printed by single invocation to printk().  Is the log captured using
serial console?  I think it could be transmission error or buffer
overflow on serial link.

-- 
tejun

