From: Darren Stevens <darren@stevens-zone.net>
Subject: Re: libata-sff: Don't scan disabled ports when checking for legacy
 mode.
Date: Sun, 22 Jan 2017 19:40:28 +0000 (GMT)
Message-ID: <4978cb9057c.50a2e729@auth.smtp.1and1.co.uk>
References: <497610a8448.441e0a10@auth.smtp.1and1.co.uk>
 <20170120204136.GD9280@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:63674 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdAVTlD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2017 14:41:03 -0500
In-Reply-To: <20170120204136.GD9280@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hello Tejun

On 20/01/2017, Tejun Heo wrote:
> The patch is damaged and maybe just using two if statements would read
> easier?

Thanks for reviewing, I've made the changes you suggested, and resumbitted,
this time I have attached the patches so my emailer won't mangle them.

Both have come from my git tree and are tested as far as I can.

Regards
Darren

