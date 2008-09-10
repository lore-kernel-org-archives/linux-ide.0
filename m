From: "Renato S. Yamane" <yamane@diamondcut.com.br>
Subject: Re: Laptop shock detection and harddisk protection
Date: Wed, 10 Sep 2008 16:43:50 -0300
Message-ID: <48C82376.8020804@diamondcut.com.br>
References: <48C7FCEE.8060404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755348AbYIJTov@vger.kernel.org>
In-Reply-To: <48C7FCEE.8060404@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: multinymous@gmail.com, Elias Oltmanns <eo@nebensachen.de>, Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, roy@marples.name
List-Id: linux-ide@vger.kernel.org

Tejun Heo escreveu:
> I browsed a little bit for HDAPS one and it seems all the pieces are
> there but scattered.  The latest effort seems tp_smapi which Shem
> Multinymous is working on.

I have a Lenovo Thinkpad T61 running tp_smapi and hdapsd over 2.6.26.2
Kernel with Elias patch:
<http://article.gmane.org/gmane.linux.drivers.hdaps.devel/1324/raw>

If you need some info, pls let me know.

> 1. How should the shock interface look like?  As we're gonna need
>    userland daemon one way or the other, we can use the userland
>    daemon to glue all the interfaces but it would be much better to
>    have a unified interface.  Although there seem to be several
>    different variants, they don't differ all that much and creating a
>    new interface every time is painful.  I think we can get by with a
>    sysfs interface with notification.

IMHO, userland daemon need only inform users when hdd heads was parking.
This is what KHDAPSMonitor do (<http://roy.marples.name/node/269>).
A daemon like this is used in Windows, but one more feature is present:
Is possible choose "Manual Unlock" (hdd heads is kept parked until I
click over daemon to unlock).

Best regards,
Renato S. Yamane
