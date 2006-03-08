From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 07 Mar 2006 22:23:28 -0500
Message-ID: <440E4E30.409@rtr.ca>
References: <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046013.7070503@rtr.ca> <4404BAD6.3060009@tmr.com> <440E4803.7070808@rtr.ca> <20060308031829.GB5411@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:53135 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932422AbWCHDXe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2006 22:23:34 -0500
In-Reply-To: <20060308031829.GB5411@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Mark Lord <liml@rtr.ca>, Bill Davidsen <davidsen@tmr.com>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, axboe@suse.de, albertcc@tw.ibm.com

Dave Jones wrote:
>
> looks like our userspace includes aren't up to date with some of the kernel
> changes, so currently they're lacking the ide_task_request_t and related
> taskfile bits.
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=184349

Ahh.. Thanks, Dave.

hdparm-6.6 being released *now*, with that stuff #ifdef'd out when
the necessary header structs are missing.

It builds/runs for me, on RHEL4 at least.

Cheers
