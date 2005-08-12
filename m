From: Tejun Heo <htejun@gmail.com>
Subject: Re: SiI 3112A + Seagate HDs = still no go?
Date: Fri, 12 Aug 2005 12:24:26 +0900
Message-ID: <42FC166A.3020505@gmail.com>
References: <12872CA9-F089-4955-8751-8CC4E7B2140A@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:13735 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751148AbVHLDYc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 23:24:32 -0400
Received: by wproxy.gmail.com with SMTP id i20so340085wra
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2005 20:24:32 -0700 (PDT)
In-Reply-To: <12872CA9-F089-4955-8751-8CC4E7B2140A@bootc.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Boot <bootc@bootc.net>, Linux-ide <linux-ide@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Hi all,
> 
> I just recently took the plunge and bought 4 250 GB Seagate drives  and 
> a 2 port Silicon Image 3112A controller card for the 2 drives my  
> motherboard doesn't handle. No matter how hard I try, I can't get the  
> hard drives to work: they are detected correctly and work reasonably  
> well under _very_ light load, but anything like building a RAID array  
> is a bit much and the whole controller seems to lock up.
> 
> I've tried adding the drive to the blacklist in the sata_sil.c driver  
> and I still have the same trouble: as you can see the messages below  
> relate to my patched kernel with the blacklist fix. I've seen that  this 
> was discussed just yesterday, but that seemed to give nothing:  
> http://www.ussg.iu.edu/hypermail/linux/kernel/0508.1/0310.html
> 
> Ready and willing to hack my kernel to pieces; this machine is no use  
> until I get all the drives working! Needless to say the drives  
> connected to the on-board VIA controller work fine, as do the drives  
> currently on the SiI controller if I swap them around.
> 
> Any ideas?
> 
> TIA
> Chris
> 

[added linux-ide to cc list]

  Can you please try w/ vanilla kernel (2.6.12 or 2.6.13-rc)?  And w/ 
one drive only?

-- 
tejun
