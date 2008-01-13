From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata 4726 Testing
Date: Sun, 13 Jan 2008 14:10:17 +0900
Message-ID: <47899D39.4050108@gmail.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com> <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com> <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com> <47859132.1000700@gmail.com> <4785521B.6070205@shaw.ca> <47859D1A.8010006@gmail.com> <47855F02.3010407@shaw.ca> <4785BD03.10809@gmail.com> <4786C42A.10403@shaw.ca> <47871F88.8070109@gmail.com> <4787F82C.80709@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:16689 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbYAMFKX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 00:10:23 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2818097wah.23
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 21:10:22 -0800 (PST)
In-Reply-To: <4787F82C.80709@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

Andrew Ryder wrote:
> Tejun,
> 
> No problem. I should be thanking you and your team for all the hard work
> writing the drivers for the hardware..
> 
> I think this patch might have solved the issue. I did a quick test: warm
> rebooted and turned the 4726 on and off 3 times and all disks were
> successfully detected each time. I'll do a more thorough test tomorrow
> or Sunday.

Great.  I forwarded the patch for #upstream-fixes as the patch is in the
right direction whether it fully fixes your problem or not.  Please
lemme know the test result.

Gaston, for the initial detection failure messages when connected to ICH
AHCI, I don't really have much idea what's going on or how to fix it.  I
suspect it's related to initial FISes from drives arriving
asynchronously after hard resets but can't tell much without bus
analyzer.  Anyways, as EH can handle the case quickly enough, I guess we
can leave it at that for now.  If you have ideas on what's going on or
how to fix it, please lemme know.

Thanks.

-- 
tejun
