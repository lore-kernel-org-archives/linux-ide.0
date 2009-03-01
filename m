From: Tejun Heo <tj@kernel.org>
Subject: Re: ATAPI question
Date: Sun, 01 Mar 2009 21:51:48 +0900
Message-ID: <49AA84E4.3050108@kernel.org>
References: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com> <49A8AAC6.2090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46152 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414AbZCAMve (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Mar 2009 07:51:34 -0500
In-Reply-To: <49A8AAC6.2090201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "Foster, Doug F" <doug.f.foster@intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

Robert Hancock wrote:
>> Using a SATA analyzer, I find that on an INQUIRY (12h) ATAPI packet
>> command, the device sets bit-6 (DRDY) and bit-4 (SERV) in the status
>> register, and bits 0 (CoD) and 1 (IO) are set in the ATAPI Interrupt
>> Reason Register (ATA Sector Count Register).  After SERVICE is flagged
>> by the ATAPI device (and not serviced), it doesn't respond properly
>> from then on.
> 
> Bit 4 isn't SERV in this context, it's DRQ. (It's only SERV when TCQ is
> in use, which it isn't.) It looks like this is a READ CAPACITY command
> that's being issued by PIO. DRQ means the device expects to transfer
> data - either to receive the CDB or send the response. Presumably that
> didn't happen for some reason. Are you sure about both the C/D and I/O
> bits being 1? That would mean command transfer to the host, which
> doesn't make any sense.
> 
> You're saying that DRQ never gets cleared after the INQUIRY command?
> It's possible the device wanted to transfer more data than the PRD table
> had room for. Not sure what AHCI ends up doing in this case. I'm CCing
> Tejun who might know more..

libata always prepares for extra space for draining so I doubt that.
Any chance you can post the traces?

-- 
tejun
