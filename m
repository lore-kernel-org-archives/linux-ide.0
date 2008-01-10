From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata 4726 Testing
Date: Thu, 10 Jan 2008 13:20:42 +0900
Message-ID: <47859D1A.8010006@gmail.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com> <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com> <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com> <47859132.1000700@gmail.com> <4785521B.6070205@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:15220 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815AbYAJEUs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 23:20:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so826880wah.23
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 20:20:48 -0800 (PST)
In-Reply-To: <4785521B.6070205@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

Andrew Ryder wrote:
> Tejun,
> 
> I rebooted with the 4726 online during bootup, verified everything was
> there by re-formatting the fs on each drive. I powered off the 4726 for
> approx 15 seconds, turned it back on, and repeated the power on/off
> again about 1 minute later.
> 
> The first 3 drives are accessible, but the 4th drive on ata1.03 failed
> to be recognized.

Hmmm... That's interesting.  The fourth drive seemed to have gone out
for lunch.  If you can, does connecting the drive to another port (be it
PMP port or not) without removing power make the drive work again?  If
you can't do that, does removing the drive and re-plugging revives it?
Please try to determine who went out for lunch - the PMP port or the
drive.  Also, can you please turn on CONFIG_PRINTK_TIME so that I can
tell what's happening when?

Thanks.

-- 
tejun
