From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata 4726 Testing
Date: Thu, 10 Jan 2008 15:36:51 +0900
Message-ID: <4785BD03.10809@gmail.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com> <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com> <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com> <47859132.1000700@gmail.com> <4785521B.6070205@shaw.ca> <47859D1A.8010006@gmail.com> <47855F02.3010407@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:56940 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYAJGg6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 01:36:58 -0500
Received: by wa-out-1112.google.com with SMTP id v27so888090wah.23
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 22:36:57 -0800 (PST)
In-Reply-To: <47855F02.3010407@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

Hello,

Andrew Ryder wrote:
> This might be of interest.. I had turned the drive off for about 20
> minutes, then turned it back on. ata1.03 is now partially there, it is
> recognized as a device, but of 0MB in size.
> 
> All of this is done with the 4726 turned on..
> 
> Bootlog11.txt -> I unplugged the 4726, waited 10 seconds, and plugged it
> into the second port on the 3124. All 4 drives are there.
> 
> Bootlog12.txt -> I unplugged the 4726 again, waited 10 seconds, plugged
> it back into the first (original) port, and ata1.03 is back..
> 
> Bootlog13.txt -> I powered the 4726 off, waited 10 seconds, turned it
> back on. The same drive is missing now.
> 
> Bootlog14.txt -> I unplugged, waited 10 seconds, and re-plugged the 4726
> into the same port (first eSATA port) and now ata1.03 is recognized and
> accessible.
> 
> I'll make sure to turn on the timestamping for you tomorrow. Would want
> me to redo this testing so you can have the timestamps also?

Please swap the third and fourth drive and see whether the problem moves
with the drive or stays with the port.  Also, please verify regular
powered on detection (array up and running before detection begins)
always works.  4726 is very quirky (it ate up a LOT of development /
testing time) and I guess we'll have to accept some brokenness.

Thanks.

-- 
tejun
