From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Wed, 25 Sep 2013 16:40:30 +0200
Message-ID: <CAAsK9AF_sJFcNTkCAR1vE5O80bJ0OoUL2AykqOoUvZt=5AYnxQ@mail.gmail.com>
References: <523EF645.7050808@linux.com>
	<20130922153959.GB28571@htj.dyndns.org>
	<523F10BB.8020503@gmail.com>
	<20130922160551.GD28571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51102 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab3IYOkb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2013 10:40:31 -0400
Received: by mail-vc0-f174.google.com with SMTP id gd11so4384278vcb.5
        for <linux-ide@vger.kernel.org>; Wed, 25 Sep 2013 07:40:30 -0700 (PDT)
In-Reply-To: <20130922160551.GD28571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

I am getting the following output:
[    2.236379] ata_piix 0000:00:1f.2: MAP [
[    2.236492]  P0 P2 -- -- ]
Instead of the expected:
[    2.236379] ata_piix 0000:00:1f.2: MAP [ P0 P2 -- -- ]

This might be a minor problem, but I think it is better the second way.
Of course, now that I better understand the code, I see that my fix to this,
is not the best. I will make a new patch, if you think this should be fixed.

Regards,
Levente Kurusa

2013/9/22 Tejun Heo <tj@kernel.org>:
> On Sun, Sep 22, 2013 at 05:46:03PM +0200, Levente Kurusa wrote:
>> As far as I know pr_cont is not thread-safe. Without this patch I
>> was only getting "... MAP [" and the rest would be scattered through
>> the dmesg.
>
> Continuations are now properly handled by printk.  Please see commits
> leading to eab072609e11a357181806ab5a5c309ef6eb76f5.
>
> Thanks.
>
> --
> tejun
