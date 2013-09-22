From: Levente Kurusa <ilevex.linux@gmail.com>
Subject: Re: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Sun, 22 Sep 2013 17:46:03 +0200
Message-ID: <523F10BB.8020503@gmail.com>
References: <523EF645.7050808@linux.com> <20130922153959.GB28571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:60266 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab3IVPqc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 11:46:32 -0400
Received: by mail-bk0-f45.google.com with SMTP id mx11so818240bkb.4
        for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2013 08:46:31 -0700 (PDT)
In-Reply-To: <20130922153959.GB28571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org


On 2013-09-22 17:39, Tejun Heo wrote:
> On Sun, Sep 22, 2013 at 03:53:09PM +0200, Levente Kurusa wrote:
>> Hi,
>>
>> The following patch fixes a printk() call, which was originally used
>> with pr_cont, which will however fail. Fixed that with setting up a
> Why would pr_cont() fail?
>
> Thanks.
>
As far as I know pr_cont is not thread-safe. Without this patch I was 
only getting "... MAP [" and the rest would be scattered through the dmesg.


---
Regards,
Levente Kurusa
