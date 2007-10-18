From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 0/3] ide: Fix use of paired device
Date: Thu, 18 Oct 2007 15:54:59 +0400
Message-ID: <47174993.4010108@ru.mvista.com>
References: <1192668978.21882.719539599813.qpush@grosgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42634 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755726AbXJRLyu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 07:54:50 -0400
In-Reply-To: <1192668978.21882.719539599813.qpush@grosgo>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Hello.

Benjamin Herrenschmidt wrote:

> At least 2 drivers (siimage and cs5535) have a bug where they use
> the construct:

> 	ide_drive_t *pair	= &hwif->drives[drive->dn ^ 1];

> To access the other drive in a master/slave pair. This is bogus
> because drive->dn is not the unit number, but the global drive
> number, thus can be 2 & 3 for ide1, 4 & 5 for ide2 etc...

    Huh? With drive->dn calculated as:

         for (unit = 0; unit < MAX_DRIVES; ++unit) {
                 ide_drive_t *drive = &hwif->drives[unit];
                 drive->dn = (hwif->channel ? 2 : 0) + unit;

(with MAX_DRIVES always being 2) how comes it may be 4 or 5?!

> Please apply to 2.6.24 if no objection.

    I object. :-)

MBR, Sergei
