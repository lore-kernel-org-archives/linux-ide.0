From: Mark Lord <liml@rtr.ca>
Subject: Re: How to assess PMP register
Date: Mon, 04 May 2009 19:37:14 -0400
Message-ID: <49FF7C2A.6030000@rtr.ca>
References: <fa69d4570904291849p638b849fm856be97c81340624@mail.gmail.com>	 <49FA2763.9040409@rtr.ca> <fa69d4570905032204q726728a1qd4be4800b916439a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33571 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757898AbZEDXhP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 May 2009 19:37:15 -0400
In-Reply-To: <fa69d4570905032204q726728a1qd4be4800b916439a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: s ticket <smticket@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

s ticket wrote:
>>> Is there any way to read PMP registers after hardreset/softreset?
>>> SATA Controller is marvell 88SX7042 and driver is sata_mv.
>>> I try to send 0xE4 and 0xE6 command to read/write PMP registers:
>> ..
>>>        if (ioctl(fd, SG_IO, &io_hdr) == -1) {
>> ..
>>
>> No, there is no existing way to access PMP registers from user space.
>>
> But what's the difference in dealing with '0xE4' and '0xE8' commands.
> I found that only the two commands will reset the link
..

There's no guaranteed way to do that (reset the link) from userspace either.

You're trying to do device driver things -- those should be done inside
the device driver in the kernel proper.

Cheers
