From: =?UTF-8?B?U3ZlbiBLw7ZobGVy?= <sven.koehler@gmail.com>
Subject: Re: Samsung 840 EVO
Date: Mon, 04 May 2015 18:45:04 +0300
Message-ID: <mi845v$r46$1@ger.gmane.org>
References: <5547685F.7000103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43168 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbbEDPuH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 May 2015 11:50:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1YpIdB-000178-7Y
	for linux-ide@vger.kernel.org; Mon, 04 May 2015 17:50:05 +0200
Received: from 132.70.228.38 ([132.70.228.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 04 May 2015 17:50:05 +0200
Received: from sven.koehler by 132.70.228.38 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 04 May 2015 17:50:05 +0200
In-Reply-To: <5547685F.7000103@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Am 04.05.2015 um 15:38 schrieb G=C3=BCnter Waller:
> But there is also a big concern for Linux users which this FW version
> seems to introduce. The link below points to a warning (backed by
> others, elsewhere on the web) that fstrim in combination with this FW
> will wreck your drive.
> http://www.overclock.net/t/1507897/samsung-840-evo-read-speed-drops-o=
n-old-written-data-in-the-drive/2640%23post_23827674
> (search for fstrim)
> I raised this in a discussion thread of the Ubuntu MATE community and
> was pointed to the SSD blacklist that is part of the module
> libata-core.c which names you as the maintainer. I wonder if you coul=
d
> take a look at this issue - maybe you want to add the device to the
> blacklist thereafter if need be.
> If you find the time and find this worthwhile to investigate I would
> appreciate a brief notification of the outcome. For now I am holding
> back the FW update.

Here is a discussion of the issue and a patch:
https://bugs.launchpad.net/ubuntu/+source/fstrim/+bug/1449005

Apparently, TRIM in combination with NCQ is broken with the new
firmware. Having the discard mount option enabled didn't wreck my drive=
,
but it kept my machine from booting. I had to disable that option and
the patch given at the URL above seems to disable NCQ specifically for
TRIM only. So the performance hit might be minimal.

The patch should really be applied asap and it should be backported to
all stable branched as far as possible.


Regards,
  Sven

