From: Tejun Heo <htejun@gmail.com>
Subject: Re: Need help understanding SATA error message.
Date: Wed, 02 Apr 2008 01:15:41 +0900
Message-ID: <47F25FAD.1090200@gmail.com>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca> <47ED15D2.3080403@rtr.ca> <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se> <47EDBC87.8090109@rtr.ca> <Pine.LNX.4.61.0803301659300.5510@envy.nxs.se> <47F0376F.2090000@gmail.com> <47F0FAD3.9060001@rtr.ca> <47F18127.8070509@gmail.com> <47F19764.9080705@rtr.ca> <Pine.LNX.4.61.0804010834280.5510@envy.nxs.se> <47F224F9.40906@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:23097 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbYDAQPt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2008 12:15:49 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1244393rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 01 Apr 2008 09:15:48 -0700 (PDT)
In-Reply-To: <47F224F9.40906@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tomas Lund <tlund@nxs.se>, linux-ide@vger.kernel.org

Hello,

Mark Lord wrote:
>>> Mmm.. the one Tomas Lund has is on what appears to be AHCI (ICH9R).
>>
>> Yes, indeed:
>>
>> # lspci -v -nn -s 00:1f.2
>> 00:1f.2 SATA controller [0106]: Intel Corporation 82801IR/IO/IH 
>> (ICH9R/DO/DH) 6 port SATA AHCI Controller [8086:2922] (rev 02) 
>> (prog-if 01 [AHCI 1.0])
>>         Subsystem: Super Micro Computer Inc Unknown device [15d9:d180]
> ..
>> (dmesg output available at http://tlund.pp.se/envy4_dmesg.txt)

Right.

>>> Tomas, if you move the "problem drive" to another port, does the 
>>> error follow the drive, or stay with the same port?
> ..
>> Yes, the drive has already been moved, and the problem did indeed move 
>> with the drive. However, I am currently stressing the drives by 
>> copying large amounts of files, in paralel sessions, and issuing 
>> "sync" every 30 seconds, and I have not seen the error since Mar 28 
>> 18:17 (current time here is Apr 1 09:10).
>>
>> The system does not have any data on it yet, and I am not really in a 
>> hurry to get it into production. Willing to try anything to track this 
>> problem down.
> ..
> 
> Mmm.. I suppose the thing to do, is to move it back to the port it was
> on when it failed, if you haven't already done that.
> 
> If things continue to go well there now, it would not be unreasonable
> to perhaps assume that a flaky cable connection was the culprit,
> and that simply rearranging the drives/cables produced a better connection.

I've never really seen transmission errors resulting in FLUSH failure. 
All that needs to be transferred is the opcode and according to the 
SMART log, the drive got the command right but still aborted it.  The 
only thing I can think of right now is that dd over the whole disk put 
sanity into the disk but it's just a wild speculation.  Yeap, I would 
love to see whether the problem reproduces itself when moved back to the 
original port.

Thanks.

-- 
tejun
