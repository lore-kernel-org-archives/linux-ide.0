From: Harald Dunkel <harald.dunkel@t-online.de>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Tue, 15 May 2007 19:38:09 +0200
Message-ID: <4649F001.6090707@t-online.de>
References: <46362672.7080103@gmx.net> <4636EA85.40809@t-online.de> <46371628.9060905@gmail.com> <46379CA1.601@t-online.de> <463AEAF9.3000103@gmail.com> <463B6E3F.5000300@t-online.de> <463EFF88.7050308@gmail.com> <463F6E45.504@t-online.de> <464088BF.5070106@gmail.com> <464206DB.1010506@t-online.de> <4643176A.80809@gmail.com> <4643803F.5040808@t-online.de> <46442A58.4040304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout08.sul.t-online.com ([194.25.134.20]:41377 "EHLO
	mailout08.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757011AbXEORi2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 13:38:28 -0400
In-Reply-To: <46442A58.4040304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Daniel Beichl <daniel_beichl@gmx.net>

Hi Tejun,

Tejun Heo wrote:
> Hello,
> 
> Harald Dunkel wrote:
>> Hi Tejun,
>>
>> Setting the timeout to 15 did not help, either :-(. All your patches
>> are still in, of course.
> 
> Hmm... I'm out of ideas.  I'll try it when I get back home.
> 

I think I will survive for the next few days.

>> May 10 22:16:01 pluto kernel: ata2.00: configured for UDMA/33
>> May 10 22:16:01 pluto kernel: ata2: EH complete
> 
> Well, at least one thing worked.  I'll push the patch upstream soon.
> 

This was indeed a huge improvement. Before this patch I had
to reboot to wake up the DVD drive.


Many thanx

Harri

