From: Tejun Heo <htejun@gmail.com>
Subject: Re: How to make SATA hotplug path tight?
Date: Tue, 19 Sep 2006 12:11:46 +0900
Message-ID: <450F5FF2.9030208@gmail.com>
References: <8202f4270609150812r654c1319r511b18aadf7e1f7@mail.gmail.com>	 <20060915180903.GC25800@htj.dyndns.org>	 <8202f4270609151248k236d6c24vab519b64902f102e@mail.gmail.com>	 <450B58C9.7010904@gmail.com> <8202f4270609181218h160b8df7x4853f58429229b3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:22712 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751197AbWISDLw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Sep 2006 23:11:52 -0400
Received: by wx-out-0506.google.com with SMTP id s14so4275164wxc
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 20:11:52 -0700 (PDT)
In-Reply-To: <8202f4270609181218h160b8df7x4853f58429229b3b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

[adding linux-ide back, please don't drop it]

Fajun Chen wrote:
> Hi Tejun,
> 
> I try to understand your eh code and still have several questions:
> 
> 1. Why software is needed after hard reset under certain condition?

Because some controllers including sil24 cannot acquire device signature 
after hardreset.

>     rc = ata_do_reset(ap, reset, classes);
>     did_followup_srst = 0;
>     if (reset == hardreset &&
>         ata_eh_followup_srst_needed(rc, classify, classes)) {
>         /* okay, let's do follow-up softreset */
>         did_followup_srst = 1;
>         reset = softreset;
>       ...
>       Sometimes this part of the code costed as many as 7 secs:
> [  366.400000] ata2: hard resetting port
> [  366.400000] sata_phy_debounce: ENTER
> [  368.490000] sata_phy_debounce: EXIT
> [  368.490000] sil24_softreset: ENTER
> [  375.750000] ata_dev_classify: found ATA device by sig
> [  375.750000] sil24_softreset: EXIT, class=1
>       Is there any way to get drive going without going through this?

Well, on hotplug case, you need to detect which class of device is 
attached, so you need a softreset there.

> 2.  What's the concept of port suspend and resume?

Port being suspended and resumed, I think. :-) You need ask more 
specifically.

-- 
tejun
