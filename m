From: Tejun Heo <htejun@gmail.com>
Subject: Re: Slow perfs with IDE SSD
Date: Thu, 13 Jul 2006 01:32:57 +0900
Message-ID: <44B52439.80408@gmail.com>
References: <loom.20060712T102252-777@post.gmane.org> <44B52182.3020008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:48008 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750809AbWGLQbx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Jul 2006 12:31:53 -0400
Received: by nz-out-0102.google.com with SMTP id l1so167556nzf
        for <linux-ide@vger.kernel.org>; Wed, 12 Jul 2006 09:31:53 -0700 (PDT)
In-Reply-To: <44B52182.3020008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RnJhbsOnb2lzLUp1bGllbiBNYXJiYXVk?= <fbourget@irisa.fr>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Fran=C3=A7ois-Julien Marbaud wrote:
>> Hi !
>>
>> I'm doing an internship in a research lab, and we are trying to use =
a=20
>> P.ATA SSD
>> in order to speed-up a genome computation software.
>>
>> We got a performance problem, expecially with access time : access=20
>> time is about
>> 800us, and according to the manufacturer it should be about 40us. Th=
e=20
>> bandwith
>> is OK.
>>
>> The SSD is a 2.5' flash hard drive, the slave of the first IDE chann=
el.
>>
>> We wonder if that could be the because P.ATA driver is not really do=
ne=20
>> for small
>> access times, so we got such a poor time. In that case, I guess we=20
>> would have to
>> have a closer look at the driver ...=20
>=20
> First of all, try noop elevator.
>=20
>   echo noop > /sys/block/hdx/queue/scheduler
>=20
> Depending on your workload, adjusting plugging delay/threshold=20
> parameters might help.  These are initialized in the kernel source fi=
le=20
> block/ll_rw_blk.c::blk_queue_make_request().  q->unplug_thresh and=20
> q->unplug_delay.
>=20

And one more thing, if a 67MB~4GB SDD drive speeds up the computation,=20
something is wrong.  4GB main memory will be much better than 4GB SDD=20
for such purposes.

--=20
tejun
