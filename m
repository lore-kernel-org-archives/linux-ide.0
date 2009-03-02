From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ATAPI question
Date: Mon, 02 Mar 2009 17:33:19 -0600
Message-ID: <49AC6CBF.3000306@gmail.com>
References: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com> <49A8AAC6.2090201@gmail.com> <49AA84E4.3050108@kernel.org> <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCEDF6@azsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:19926 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbZCBXd1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2009 18:33:27 -0500
Received: by fg-out-1718.google.com with SMTP id 16so4599fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2009 15:33:24 -0800 (PST)
In-Reply-To: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCEDF6@azsmsx504.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Foster, Doug F" <doug.f.foster@intel.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Foster, Doug F wrote:
> Yes, I would be glad to post the traces.  Is there a preferred location?  Otherwise, I can just post them to an Intel FTP server for download.

On an FTP would be usable, but if you can extract out key parts and post 
them on the list, that might be better..

> 
> -----Original Message-----
> From: Tejun Heo [mailto:tj@kernel.org]
> Sent: Sunday, March 01, 2009 5:52 AM
> To: Robert Hancock
> Cc: Foster, Doug F; linux-ide@vger.kernel.org
> Subject: Re: ATAPI question
> 
> Hello,
> 
> Robert Hancock wrote:
>>> Using a SATA analyzer, I find that on an INQUIRY (12h) ATAPI packet
>>> command, the device sets bit-6 (DRDY) and bit-4 (SERV) in the status
>>> register, and bits 0 (CoD) and 1 (IO) are set in the ATAPI Interrupt
>>> Reason Register (ATA Sector Count Register).  After SERVICE is flagged
>>> by the ATAPI device (and not serviced), it doesn't respond properly
>>> from then on.
>> Bit 4 isn't SERV in this context, it's DRQ. (It's only SERV when TCQ is
>> in use, which it isn't.) It looks like this is a READ CAPACITY command
>> that's being issued by PIO. DRQ means the device expects to transfer
>> data - either to receive the CDB or send the response. Presumably that
>> didn't happen for some reason. Are you sure about both the C/D and I/O
>> bits being 1? That would mean command transfer to the host, which
>> doesn't make any sense.
>>
>> You're saying that DRQ never gets cleared after the INQUIRY command?
>> It's possible the device wanted to transfer more data than the PRD table
>> had room for. Not sure what AHCI ends up doing in this case. I'm CCing
>> Tejun who might know more..
> 
> libata always prepares for extra space for draining so I doubt that.
> Any chance you can post the traces?
> 
> --
> tejun

