From: Ricky Beam <jfbeam@bluetronic.net>
Subject: Re: [PATCH] re-fix sata_sil quirk (w/ description)
Date: Tue, 22 Jun 2004 21:05:09 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.33.0406222059490.25702-100000@sweetums.bluetronic.net>
References: <40D8D38F.8010308@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sweetums.bluetronic.net ([24.199.150.42]:9724 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265907AbUFWBLm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jun 2004 21:11:42 -0400
In-Reply-To: <40D8D38F.8010308@pobox.com>
Content-ID: <Pine.GSO.4.33.0406222059492.25702@sweetums.bluetronic.net>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

On Tue, 22 Jun 2004, Jeff Garzik wrote:
>Bart, I'm not going to bother with a 'better fix'.  Since this only
>affects 3112 controllers, I will be adding code to make sure that the
>mod15write quirk does not activate for the other controllers (3512, 3114).

Actually, it does effect other controllers ... I'm using a 3114.  And it's
currently only known to effect Seagate drives.  It may still happen to
other drives and my not effect Seagate drives with some future firmware
revision.

Current activity using buffered writes:
Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda            1694.95         0.00     10438.68          0     626112
sdb            1694.33         0.00     10438.68          0     626112
sdc            1643.23         0.00     10438.68          0     626112
sdd            1631.01         0.00     10438.68          0     626112
md_d0         26096.70         0.00     46974.06          0    2817504
md_d0p2       20877.36         0.00     41754.72          0    2504448

That's certainly acceptable -- and in fact right at the edge of what the
3114 can do with all four port lit up.

--Ricky


