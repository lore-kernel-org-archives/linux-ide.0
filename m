From: "Foster, Doug F" <doug.f.foster@intel.com>
Subject: RE: ATAPI question
Date: Mon, 2 Mar 2009 08:58:24 -0700
Message-ID: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCEDF6@azsmsx504.amr.corp.intel.com>
References: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com>
 <49A8AAC6.2090201@gmail.com> <49AA84E4.3050108@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47195 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069AbZCBP63 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2009 10:58:29 -0500
In-Reply-To: <49AA84E4.3050108@kernel.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Foster, Doug F" <doug.f.foster@intel.com>

Yes, I would be glad to post the traces.  Is there a preferred location?  Otherwise, I can just post them to an Intel FTP server for download.

-----Original Message-----
From: Tejun Heo [mailto:tj@kernel.org]
Sent: Sunday, March 01, 2009 5:52 AM
To: Robert Hancock
Cc: Foster, Doug F; linux-ide@vger.kernel.org
Subject: Re: ATAPI question

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
