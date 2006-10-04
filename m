From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: What's in libata-dev.git
Date: Wed, 04 Oct 2006 22:03:39 +0400
Message-ID: <4523F77B.1030908@ru.mvista.com>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <4523F602.6070608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422713AbWJDSDt@vger.kernel.org>
In-Reply-To: <4523F602.6070608@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-Id: linux-ide@vger.kernel.org

Hello.

Mark Lord wrote:

>>>       [ATA] Increase lba48 max-sectors from 200 to 256.

>>    So was it for LBA28 or for LBA48?
>>    As for LBA28, it might be quite dangerous. Particularly, I know 
>> that IBM drives used to mistreated 256 as 0 in the past (bumped into 
>> that on a 8-year old drive which is still alive though).

> ..

>> The exact model was IBM DHEA-34331.

> I've been travelling for the past month, so pardon the late tuning in here.
> I've *never* encountered a drive that had this problem.
> Controllers, yes, and those are easily dealt with in the chipset drivers.
> 
> But never drives.  Not since 1992 when I first took up Linux IDE stuff.
> 
> I have some 7-year old IBM drives here, and they certainly don't have
> this problem either (but they do have working TCQ etc..).

    That was 8-year old Ultra33 drive, what TCQ? :-)

> I suspect Sergei simply had a bad controller card at the time.

    I can hardly imagine the reason why a PCI IDE controller (that was 
something like VT82C586 I think) would need to mess with the sector count reg. 
in PIO mode and return "command aborted" in the error reg... That was the 
exact sympthom IIRC.

> Cheers

WBR, Sergei
