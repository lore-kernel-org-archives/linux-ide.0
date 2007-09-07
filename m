From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA_PIIX - soft resetting port, port is slow to respond, machine
 "freezes" for a few seconds
Date: Fri, 07 Sep 2007 11:18:52 +0900
Message-ID: <46E0B50C.3010101@gmail.com>
References: <46D94BBB.9080403@wpkg.org>	 <6b9952490709010500q2a93156cq399434a3a44a2d25@mail.gmail.com>	 <46D95A6F.6060808@wpkg.org> <6b9952490709010707i33e49d19o2fa44f5bec4e367d@mail.gmail.com> <46D9D055.9070901@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:6542 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682AbXIGCTD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 22:19:03 -0400
Received: by wa-out-1112.google.com with SMTP id v27so383139wah
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 19:19:02 -0700 (PDT)
In-Reply-To: <46D9D055.9070901@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joris <joris@v5.be>
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Linux IDE <linux-ide@vger.kernel.org>

Tomasz Chmielewski wrote:
> Joris schrieb:
>> Btw, out on a limb here: my board has specific combinations of sata
>> port usage leading to a reset. Avoiding to use sata0 (sda) (unplug the
>> cable) works perfectly.
>> Do you have the same symptoms?
> 
> No idea, no SATA here.

Joris, can you please post more details about the reset failure you're
seeing?

-- 
tejun
