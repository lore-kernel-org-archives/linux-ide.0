From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata-nv hotplug feature
Date: Mon, 12 Mar 2007 14:41:57 +0900
Message-ID: <45F4E825.6050603@gmail.com>
References: <000401c762de$7baf5b60$6400a8c0@foxbat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:21052 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965150AbXCLFl6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 01:41:58 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1286155nze
        for <linux-ide@vger.kernel.org>; Sun, 11 Mar 2007 22:41:57 -0700 (PDT)
In-Reply-To: <000401c762de$7baf5b60$6400a8c0@foxbat>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rweeks@razorwire.ca
Cc: 'Jim Paris' <jim@jtan.com>, linux-ide@vger.kernel.org

Hello,

Russ Weeks wrote:
> Thanks, Jim, Tejun.  Upgrading to 2.6.20 solved all my problems.

Great.

> What I observe now is that once the drive is plugged in again, 2-3
> minutes may pass before the device entry appears in /dev.  This isn't a
> problem for me, but if you have time to explain I'd be interested to
> know why.

Please post the result of dmesg and lspci -nn.

> Also, if you have any tips on 'best practices' for drive yanking, I'd
> appreciate 'em.  So far I'm just doing 'sdparm --command=stop'.

That should do the job.

-- 
tejun
