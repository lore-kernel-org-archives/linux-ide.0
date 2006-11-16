From: Andrew Morton <akpm@osdl.org>
Subject: Re: Testing with 2.6.19-rc5
Date: Thu, 16 Nov 2006 12:36:06 -0800
Message-ID: <20061116123606.78e251ca.akpm@osdl.org>
References: <f4527be0611150645h7cc2791cub7a2ca753156564f@mail.gmail.com>
	<20061115110333.4daccb6d.akpm@osdl.org>
	<f4527be0611160321o118c8f35ic3969dbda40a7358@mail.gmail.com>
	<f4527be0611160552j1b00bffag790f1a1a29790078@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:54960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424444AbWKPUgT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Nov 2006 15:36:19 -0500
In-Reply-To: <f4527be0611160552j1b00bffag790f1a1a29790078@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: linux-ide@vger.kernel.org, Neil Brown <neilb@suse.de>

On Thu, 16 Nov 2006 13:52:28 +0000
"Andrew Lyon" <andrew.lyon@gmail.com> wrote:

> 
> Comparing the first 32k of the 4 disks under 2.6.18.2 and 2.6.19-rc5
> there is no difference, so I decided to compare the bootup dmesg, the
> following text is not output with 2.6.19-rc5:
> 
> md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: bitmap version 4.39
> 
> also missing from 2.6.19-rc5 dmesg:
> 
> md: raidstart(pid 3158) used deprecated START_ARRAY ioctl. This will
> not be supported beyond July 2006
> 
> Might that explain why my raid5 does not work in 2.6.19-rc5 ?

That sounds like a very good theory.

> I have
> attached the full dmesg and kernel config's from both versions, in
> case I have made a error there.
> 
> I am currnetly using raidtools 1.00.3

That appears to be something which Ingo released three and a half years ago ;)
I guess it's time to learn mdadm.
