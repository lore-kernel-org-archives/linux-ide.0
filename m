From: Tejun Heo <htejun@gmail.com>
Subject: Re: /dev/sd*
Date: Fri, 18 Aug 2006 18:19:14 +0900
Message-ID: <44E58612.1040607@gmail.com>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain> <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu> <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net> <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr> <44E42900.1030905@PicturesInMotion.net> <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr> <44E56804.1080906@bfh.ch> <Pine.LNX.4.61.0608181050490.27740@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:6040 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751309AbWHRJTV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Aug 2006 05:19:21 -0400
Received: by py-out-1112.google.com with SMTP id n25so995880pyg
        for <linux-ide@vger.kernel.org>; Fri, 18 Aug 2006 02:19:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0608181050490.27740@yvahk01.tjqt.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Seewer Philippe <philippe.seewer@bfh.ch>, Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jan Engelhardt wrote:
>>> Less advanced users should use the upgrade tools their distribution 
>>> provides.
>> And personally I think less advanced users will be very happy with
>> /dev/disk (or /dev/hd). No more confusion wether to user /dev/hdx or
>> /dev/sdx or whatever!
> 
> Umm, hdx or sdx is a small impact. The real power of /dev/disk is that 
> not-so-technically minded users can go looking for their disk by its name 
> (or less frequently, by their address (e.g. USB drive)). Especially 
> important since any new disk discovered in the scsi layer gets the next 
> free slot.

Desktop volume management stuff is already doing it.  When I connect my 
ipod, it shows up as IPOD on my desktop regardless of which sd letter it 
gets.  Also, recent distributions use LABEL= tricks to find out root and 
other partitions to mount on boot.

The major/minor number and device name (which is determined by udev) 
aren't that important already and will become less of an issue as time 
passes.

-- 
tejun
