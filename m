From: Tejun Heo <htejun@gmail.com>
Subject: Re: Slow perfs with IDE SSD
Date: Thu, 13 Jul 2006 01:21:22 +0900
Message-ID: <44B52182.3020008@gmail.com>
References: <loom.20060712T102252-777@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:5269 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750775AbWGLQUT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Jul 2006 12:20:19 -0400
Received: by nz-out-0102.google.com with SMTP id l1so164068nzf
        for <linux-ide@vger.kernel.org>; Wed, 12 Jul 2006 09:20:18 -0700 (PDT)
In-Reply-To: <loom.20060712T102252-777@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RnJhbsOnb2lzLUp1bGllbiBNYXJiYXVk?= <fbourget@irisa.fr>
Cc: linux-ide@vger.kernel.org

=46ran=C3=A7ois-Julien Marbaud wrote:
> Hi !
>=20
> I'm doing an internship in a research lab, and we are trying to use a=
 P.ATA SSD
> in order to speed-up a genome computation software.
>=20
> We got a performance problem, expecially with access time : access ti=
me is about
> 800us, and according to the manufacturer it should be about 40us. The=
 bandwith
> is OK.
>=20
> The SSD is a 2.5' flash hard drive, the slave of the first IDE channe=
l.
>=20
> We wonder if that could be the because P.ATA driver is not really don=
e for small
> access times, so we got such a poor time. In that case, I guess we wo=
uld have to
> have a closer look at the driver ...=20

=46irst of all, try noop elevator.

   echo noop > /sys/block/hdx/queue/scheduler

Depending on your workload, adjusting plugging delay/threshold=20
parameters might help.  These are initialized in the kernel source file=
=20
block/ll_rw_blk.c::blk_queue_make_request().  q->unplug_thresh and=20
q->unplug_delay.

--=20
tejun
