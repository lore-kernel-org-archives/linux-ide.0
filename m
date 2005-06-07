From: Brad Campbell <brad@wasp.net.au>
Subject: Re: [SATA] libata-dev queue updated
Date: Tue, 07 Jun 2005 17:15:05 +0400
Message-ID: <42A59DD9.5090903@wasp.net.au>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>	<42A47376.80203@rtr.ca> <87u0kbhqsz.fsf@stark.xeocode.com> <42A58307.3080906@wasp.net.au> <42A6AD46.5090200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261857AbVFGNPS@vger.kernel.org>
In-Reply-To: <42A6AD46.5090200@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Greg Stark <gsstark@mit.edu>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, James Bottomley <James.Bottomley@steeleye.com>
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> Brad Campbell wrote:
> 
> 
> That's weird.  So, is your /dev/sda a (S)ATA drive?

Yep.. I have 28 Maxtor Maxline-II drives on Promise SATA150TX4's
They all show up under /dev/scsi/host??

> 
> Maybe there's something screwy with true SATA drives and libata (doubtful)?

Not that I know of.. it has been working great here for months now.. (bar the odd oops)

> I also have "smartctl -data" working with SATA drives through the
> qstor driver (the non-libata version) without any issues, so we know
> the drives themselves are happy with it.
> 
>> smartctl -d ata -a /dev/sda

> Same thing as "-data".  Either works.
> 

So it does..

I'm still using a 2.6.10-bk10 kernel here with the libata-dev patches and some minor md patches.. 
It's stable unless one of the drives throws an error, whereapon libata oops and stops talking to the 
other drives (and then it gets really messy).. Have not had time to reproduce/upgrade to see if it's 
fixed though.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
