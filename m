From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Tue, 19 Jun 2007 16:24:40 +0900
Message-ID: <467784B8.7090507@gmail.com>
References: <46362672.7080103@gmx.net> <4636EA85.40809@t-online.de> <46371628.9060905@gmail.com> <46379CA1.601@t-online.de> <463AEAF9.3000103@gmail.com> <463B6E3F.5000300@t-online.de> <463EFF88.7050308@gmail.com> <463F6E45.504@t-online.de> <464088BF.5070106@gmail.com> <464206DB.1010506@t-online.de> <4643176A.80809@gmail.com> <4643803F.5040808@t-online.de> <46442A58.4040304@gmail.com> <46663A32.9010206@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:24281 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbXFSHYu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2007 03:24:50 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2500426wah
        for <linux-ide@vger.kernel.org>; Tue, 19 Jun 2007 00:24:47 -0700 (PDT)
In-Reply-To: <46663A32.9010206@t-online.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-ide@vger.kernel.org, Daniel Beichl <daniel_beichl@gmx.net>

Harald Dunkel wrote:
>> Harald Dunkel wrote:
>>> Hi Tejun,
>>>
>>> Setting the timeout to 15 did not help, either :-(. All your patches
>>> are still in, of course.
>>
>> Hmm... I'm out of ideas.  I'll try it when I get back home.
>>
> 
> Any news about this? At the end I had the impression that this is
> a bug in the chip design. Is this correct?

I can't reproduce that with sil3112 and the same SH-S183A.  I don't know
what's going on here.  Mine behaves really good but yours seems to be
causing all sorts of problems.

> Is there any chance to get the 60-byte patch into the kernel?

We still don't know what's going on so....

-- 
tejun
