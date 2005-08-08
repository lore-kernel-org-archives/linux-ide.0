From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Mon, 08 Aug 2005 11:00:57 +0200
Message-ID: <42F71F49.6050005@imc-berlin.de>
References: <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de> <20050802122609.GM22569@suse.de> <42EF69AD.30201@imc-berlin.de> <20050802125437.GA11967@suse.de> <42EF6F18.4090905@imc-berlin.de> <20050802130646.GA7519@suse.de> <42EF7747.6050208@imc-berlin.de> <20050802134546.GC2408@suse.de> <42EF7AFD.9090507@imc-berlin.de> <20050802141156.GF2408@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:8200 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S1750771AbVHHJBB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Aug 2005 05:01:01 -0400
In-Reply-To: <20050802141156.GF2408@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Jens Axboe wrote:

> On Tue, Aug 02 2005, Steven Scholz wrote:
>=20
>>[PATCH] ide: kill requests when drive is not present anymore
>>
>>Signed-off-by: Steven Scholz <steven.scholz@imc-berlin.de>
>>
>>Ok?
>>
>>Change the CHANGELOG at your will.
>>
>>--
>>Steven
>=20
>=20
>>--- linux-2.6.13-rc5/drivers/ide/ide-io.c	2005-06-17 21:48:29.0000000=
00 +0200
>>+++ linux-2.6.13-rc4-at91-multiIO/drivers/ide/ide-io.c	2005-08-02 15:=
46:53.000000000 +0200
>>@@ -1230,7 +1257,17 @@ void do_ide_request(request_queue_t *q)
>> {
>> 	ide_drive_t *drive =3D q->queuedata;
>>=20
>>-	ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
>>+	if (drive->present)
>>+		ide_do_request(HWGROUP(drive), IDE_NO_IRQ);
>>+	else {
>>+		struct request	*rq;
>>+		printk(KERN_WARNING "%s: not present, killing requests\n", drive->=
name);
>>+		while ((rq =3D elv_next_request(q)) !=3D NULL) {
>>+			blkdev_dequeue_request(rq);
>>+			end_that_request_first(rq, 0, rq->hard_nr_sectors);
>>+			end_that_request_last(rq);
>>+		}
>>+	}
>> }
>>=20
>> /*
>=20
>=20
> Looks good to me now, that's one item off Barts list :-)

Will it get into 2.6.13? It's not in -rc6 though.

--
Steven





--=20
Steven Scholz

imc Measurement & Control               imc Me=DFsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland
