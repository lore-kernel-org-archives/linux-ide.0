From: Tejun Heo <htejun@gmail.com>
Subject: Re: Need help understanding SATA error message.
Date: Mon, 31 Mar 2008 09:59:27 +0900
Message-ID: <47F0376F.2090000@gmail.com>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca> <47ED15D2.3080403@rtr.ca> <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se> <47EDBC87.8090109@rtr.ca> <Pine.LNX.4.61.0803301659300.5510@envy.nxs.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:13876 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbYCaA7c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Mar 2008 20:59:32 -0400
Received: by rv-out-0910.google.com with SMTP id k20so750920rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 30 Mar 2008 17:59:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0803301659300.5510@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Lund <tlund@nxs.se>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Tomas Lund wrote:
> On Fri, 28 Mar 2008, Mark Lord wrote:
> 
>> One thing to try, if you have 12000 seconds to spare, :) is to simply 
>> try this:
>>
>>  cat /dev/zero > /dev/sdX
>>  sync
>>  hdparm -F /dev/sdX
>>
>> And see if that completes without error. If it does, then the drive 
>> may be fine.
>>
>> Software bugs are always possible, but do seem unlikely in this case. 
>> But then, so does a hardware failure seem unlikely on a new drive.
> 
> completed without errors, no sectors reallocated...

Can you put the driver under IO load test involving lots of writes and 
flushes (mounting as ext3 w/ barrier=1 and doing lots of copying should 
achieve it) and see whether the error is still reproducible?

-- 
tejun
