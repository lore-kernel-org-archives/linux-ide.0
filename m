From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: Re: CPU usage is very high while io'ing a sata disk
Date: Wed, 30 Nov 2005 08:06:03 +0200
Message-ID: <5d96567b0511292206x79dac574t7ad4a339926093d6@mail.gmail.com>
References: <5d96567b0511291323j4fa468d7t66d1cdd7e47061a7@mail.gmail.com>
	 <Pine.LNX.4.44.0511291810180.30872-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.201]:21256 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750763AbVK3GGE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Nov 2005 01:06:04 -0500
Received: by wproxy.gmail.com with SMTP id 71so94024wri
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2005 22:06:03 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44.0511291810180.30872-100000@coffee.psychology.mcmaster.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-ide@vger.kernel.org

cilly me. i went and reread the vmstat manual and they say that the id
field includes the wa field.
thank you guys.
Raz.

On 11/30/05, Mark Hahn <hahn@physics.mcmaster.ca> wrote:
> > there is a huge impact over the cpu usage.
>
> nah.
>
> > dd if=/dev/sdb of=/dev/zero bs=1M count=1000
> > it ended after 16 seconds.
>
> 66 MB/s, which is OK.
>
> > during that time cpu usage was nearly 100% usage.
>
> no, that's the only problem: you're misunderstanding the output.
> during the dd, one process (dd, of course) was almost always in
> short wait, which is traditionally counted towards loadavg,
> and shows up in your 'wa' column.  note that the actual cpu used
> (us+sy) is fairly low, around 9%.
>
> > that most of the time it spends in mwait_idle ( 98%) which is vert odd
>
> not so odd, since the machine _is_ idle.  vmstat and related user-level
> tools simply report an IO-blocked process as in wait.
>
> > use a hardware raid the cpu usage is logically low ( since it is a
> > scsi driver ).
>
> no: the nature of the driver would not effect this, which is purely
> a semantic issue of how to interpret processes blocked on IO.
>
>


--
Raz
