From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: PowerPC MPC5200B ATA MWDMA regression
Date: Mon, 03 Jan 2011 18:27:45 +0300
Message-ID: <4D21EAF1.2010504@ru.mvista.com>
References: <201101031445.47922.roman.fietze@telemotive.de>	<20110103135929.GO18831@htj.dyndns.org>	<4D21DD55.2000000@ru.mvista.com> <AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57893 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab1ACP2w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 10:28:52 -0500
Received: by eye27 with SMTP id 27so5947034eye.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 07:28:50 -0800 (PST)
In-Reply-To: <AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Roman Fietze <roman.fietze@telemotive.de>, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hello.

On 03-01-2011 17:33, Tejun Heo wrote:

>>> The commit you bisected to contains all those conversions too.  Take a
>>> look at a similar driver and look at how it has been converted
>>> recently.  Even better, just send the driver upstream.  :-)

>>    It's already there...

> Ouch, did I forget to convert

    It probably wasn't obvious as this driver had lived in non-BMDMA section 
of Kconfig before the recent patch:

http://marc.info/?l=linux-ide&m=129303304605907

> it or was it a merge timing problem?
> Anyways, sorry about that.  Please go ahead and fix it. :-)

WBR, Sergei
