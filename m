From: Tejun Heo <htejun@gmail.com>
Subject: Re: SiI 3112A + Seagate HDs = still no go?
Date: Sat, 13 Aug 2005 23:59:26 +0900
Message-ID: <42FE0ACE.6010506@gmail.com>
References: <12872CA9-F089-4955-8751-8CC4E7B2140A@bootc.net> <42FC166A.3020505@gmail.com> <0FDE8D5B-CFF2-44F9-8C98-9C5EC5CDAE92@bootc.net> <42FC87ED.6030201@gmail.com> <22B1D7C7-7BC8-449C-914C-FCE5226BCAF2@bootc.net> <655E2636-B4D4-42EC-B10C-C8B8EFA09E33@bootc.net> <42FCAD4D.7080707@gmail.com> <74C9A166-2FDC-45F8-BEB1-A574FD9602D4@bootc.net> <42FD493D.8020506@gmail.com> <EB750DA5-854F-4387-A5D7-F646EB8E7AAC@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:17264 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751190AbVHMO7d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Aug 2005 10:59:33 -0400
Received: by wproxy.gmail.com with SMTP id i2so771032wra
        for <linux-ide@vger.kernel.org>; Sat, 13 Aug 2005 07:59:32 -0700 (PDT)
In-Reply-To: <EB750DA5-854F-4387-A5D7-F646EB8E7AAC@bootc.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Boot <bootc@bootc.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org

Chris Boot wrote:
> Some interesting developments!
> 
> I installed a fresh copy of Windows, and all the VIA and nVidia and  so 
> on drivers. At some point during all this (a period of relatively  heavy 
> disk IO), the computer seemed to crash and I rebooted it. It  then 
> worked fine for a while, but during my perfmon testing it seemed  to do 
> the same thing. This time I left it for a while and it did  eventually 
> wake up again, so I'm guessing the controller is a bit  fubared. Perfmon 
> did indeed show several dips down to or very close  to 0 during the 
> write operation, with peaks up to 48 MB/sec, which is  pretty 
> respectable. So, time to replace the brand-new controller I  guess.
> 
> Now, do you think this is just my one particular controller card and  a 
> simple return would fix the problem, or is it more likely a problem  
> with the whole range? It's an Innovision EIO SATA controller: http:// 
> www.ivmm.com/eio/products/index.htm
> 
> Would it be a safer bet to go for the Adaptec controller of the same  
> variety? How reliable are they?

  I frankly don't know.  Maybe it's just one faulty controller, 
connector or whatever.  Maybe the card manufacturer screwed up 
somewhere.  I mean, the only course I took in electronics is 
introductory digital circuits which used 74xx chips and push triggered 
clock on a breadboard.  What would I know about gigahertz signaling 
error.  :-p

  Though, one thing I can say is majority of 311x controllers don't seem 
to suffer from this problem.  So, take your pick.

-- 
tejun
