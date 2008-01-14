From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata 4726 Testing
Date: Mon, 14 Jan 2008 09:35:16 +0900
Message-ID: <478AAE44.2000003@gmail.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com> <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com> <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com> <47859132.1000700@gmail.com> <4785521B.6070205@shaw.ca> <47859D1A.8010006@gmail.com> <47855F02.3010407@shaw.ca> <4785BD03.10809@gmail.com> <4786C42A.10403@shaw.ca> <47871F88.8070109@gmail.com> <4787F82C.80709@shaw.ca> <47899D39.4050108@gmail.com> <478A6017.5060509@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:46482 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbYANAfY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 19:35:24 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3322384wah.23
        for <linux-ide@vger.kernel.org>; Sun, 13 Jan 2008 16:35:22 -0800 (PST)
In-Reply-To: <478A6017.5060509@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

Andrew Ryder wrote:
> Tejun,
> 
> I have completed some of the testing, things were working fine.. then
> something died. It will not even recognize the 4726 anymore. During book
> when the HBA does it scan nor in windows 2000 does anything work or be
> recognized.
> 
> I will have a new eSATA cable this week sometime, maybe a pin got
> shmucked if lucky. I've attached the logs of the good and the gone dead.

Ah... definitely looks like a hardware problem.  Hopefully cable is the
culprit.  I wish the warranty of your port multiplier hasn't expired yet.

-- 
tejun
