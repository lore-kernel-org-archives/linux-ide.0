From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH ide] : Increase WAIT_DRQ to support slow CF cards
Date: Mon, 26 Oct 2009 19:07:18 -0600
Message-ID: <51f3faa70910261807h54f05f73j48b67067ee3dde70@mail.gmail.com>
References: <20091026162011.GA3289@frolo.macqel> <4AE64031.5060105@gmail.com>
	 <20091026.174525.154760254.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:43277 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbZJ0BHP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 21:07:15 -0400
In-Reply-To: <20091026.174525.154760254.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: phdm@macqel.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 26, 2009 at 6:45 PM, David Miller <davem@davemloft.net> wro=
te:
> From: Robert Hancock <hancockrwd@gmail.com>
> Date: Mon, 26 Oct 2009 18:34:57 -0600
>
>> This has come up before:
>>
>> http://marc.info/?l=3Dlinux-ide&m=3D123064513313466&w=3D2
>>
>> I think this timeout should not even exist. libata has no such timeo=
ut
>> (only the overall command completion timeout), and I can't find any
>> reference in current ATA specs to the device being required to raise
>> DRQ in any particular amount of time.
>
> So is the issue that, whilst we should wait for BUSY to clear,
> waiting around for DRQ is unreasonable?
>
> It seems that WAIT_DRQ is passed to ide_wait_stat() but that
> only controls how long we wait for BUSY to clear, the ATA_DRQ
> 'bad' bit we pass there only gets probed in a fixed limit loop:
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < 10; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay(1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stat =3D tp_ops->read_status(hwif);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (OK_STAT(stat, good, bad)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*rstat =3D stat;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0*rstat =3D stat;
> =A0 =A0 =A0 =A0return -EFAULT;
>
> Therefore, if increasing WAIT_DRQ helps things for people, it's
> because the BUSY bit needs that much time to clear in these
> cases.
>
> The talking in that thread seems to state that the ATA layer
> waits only for BUSY to clear, it does not wait for DRQ. =A0But
> from the data we're seeing here, it is in fact BUSY which needs
> so much more time to clear so removing the DRQ bit probe to
> be more like ATA won't fix anything.

Hmm, I think you're right.. seems it expects BSY to be de-asserted
within 100ms when issuing a write, which is fairly ridiculous. Maybe
not a problem for a hard drive in typical cases, but if a CF or SSD is
in an erase cycle or something it's quite possible for this not to
work.

Of course, just jacking up the timeout may make the problem alluded to
in the comment in __ide_wait_stat more evident ("This routine should
get fixed to not hog the cpu during extra long waits"), as it just
does a tight loop polling the status with no sleeps.

libata only busy-waits for 50 microseconds, if not set then it sleeps
for 2ms and polls for another 10 microseconds, if still not set it
tries the whole thing again at 16ms intervals. Only after (typically)
30 seconds does it give up.
