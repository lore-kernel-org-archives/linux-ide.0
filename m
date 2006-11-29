From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] ide_scsi: allow it to be used for non CD only
Date: Wed, 29 Nov 2006 23:47:04 +0100
Message-ID: <58cb370e0611291447y36430d5bta65176eb1198cdce@mail.gmail.com>
References: <20061129144652.299f7919@localhost.localdomain>
	 <58cb370e0611291405j1e5f3eb1t4950ed0993b84c85@mail.gmail.com>
	 <20061129223518.19f6ef95@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:32040 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1758909AbWK2WrI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Nov 2006 17:47:08 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1938645uga
        for <linux-ide@vger.kernel.org>; Wed, 29 Nov 2006 14:47:04 -0800 (PST)
In-Reply-To: <20061129223518.19f6ef95@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org

On 11/29/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 29 Nov 2006 23:05:56 +0100
> "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com> wrote:
>
> > Hi,
> >
> > Nowadays, you can dynamically change driver bound to a device using
> > sysfs and it works just fine for IDE, ie:
>
> This isn't the point of this change. The point is to do this at discovery
> time. If you do it later then many horrible things happen as the device

then "hdc=ide-cdrom" at a boot time should keep ide-scsi from
binding to hdc for all cases (builtin/modular ide-cd/ide-scsi)

> names and renames itself while udev goes boom.

Uh?  I hope that udev people are informed
about these horrible things...

/dev/hdc stays there all the time
/dev/sr? addition/removal should be handled
by udev otherwise it looks like a udev bug

> Its a small clean patch and it'll solve the problem nicely until
> drivers/ide dies.

No strong feelings here about the patch.  It is indeed a clean hack. ;)
I just wanted to point out that there are already more flexible ways
to achieve the same thing.

Bart
