From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: Dreaded PDC irq nobody cared
Date: Sat, 8 Oct 2005 13:17:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44.0510081313300.28615-100000@coffee.psychology.mcmaster.ca>
References: <1128590441.5964.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:51661 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S932133AbVJHRR5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Oct 2005 13:17:57 -0400
Received: from coffee.psychology.mcmaster.ca (coffee.Psychology.McMaster.CA [130.113.218.59])
	by coriana6.cis.mcmaster.ca (8.12.11/8.12.11) with ESMTP id j98HHtc7018587
	for <linux-ide@vger.kernel.org>; Sat, 8 Oct 2005 13:17:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by coffee.psychology.mcmaster.ca (Postfix) with ESMTP id 42C6A8B25
	for <linux-ide@vger.kernel.org>; Sat,  8 Oct 2005 13:17:55 -0400 (EDT)
In-Reply-To: <1128590441.5964.37.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

> > >  - The difference between having or having not the stuck interrupt seems
> > > to be the forced cooling of the attached harddisks; I find this also
...
>  - various people have this problem with various brands and models disks
>  - the temperature of the disks is ~40 C, without cooling, and also ~40
> C with cooling (?!) according to smartctl attribute 195, so either the
> temperature sensors are wrong (silly location?) or it really doesn't
> matter?!
>  - I cannot pinpoint the problem to one harddisk, and probably never
> will, because the problem only occurs with > 1 harddisk
> connected :-( (as the other people experience)
>  - the temperature in the case is not very cool but also not extremely
> hot, imho it shouldn't bother the harddisks.

you added ventilation to your case, and the problem went away.
this doesn't mean the problem was disk temperature, especially
since your disks report no real change.  instead, I suggest that 
your PSU was too hot and regulating poorly.  greater airflow 
resulted in better regulation, and made the disks happier.
(note another recent message here regarding a similar problem machine
which was fixed by providing better power...)

regards, mark hahn.

