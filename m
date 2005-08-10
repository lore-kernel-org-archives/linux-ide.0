From: Tejun Heo <htejun@gmail.com>
Subject: Re: SOLVED: DriveStatusError BadCRC
Date: Wed, 10 Aug 2005 19:25:40 +0900
Message-ID: <42F9D624.6020005@gmail.com>
References: <42D7AA47000408B7@mail-5.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:38243 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932543AbVHJKZt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2005 06:25:49 -0400
Received: by wproxy.gmail.com with SMTP id i20so105142wra
        for <linux-ide@vger.kernel.org>; Wed, 10 Aug 2005 03:25:46 -0700 (PDT)
In-Reply-To: <42D7AA47000408B7@mail-5.mail.tiscali.sys>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sampei02@tiscali.it
Cc: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

sampei02@tiscali.it wrote:
> I replaced 80 wire flat cable with another 40 wire cable.
> In this way I have no errors but now UDMA mode is set to 2 value.
> I'm sure that MOTHERBOARD supports UDMA ATA/33/66/100 BUS IDE ports.
> What do you think ?

  [sticking nose in...]

  In that case, it could be one of...

  #1 faulty cable, try another 80c cable
  #2 only one device gets attached to the cable but it's using the 
middle connector.  You need to use the connector at the end of cable 
when you connect only one device.  (I think it became a requirement w/ 
newer transfer modes.  No? still recommendation?)
  #3 faulty IDE controller (or faulty traces from the controller to cable)
  #4 faulty drive

  My bet is on #1 or #2.

-- 
tejun
