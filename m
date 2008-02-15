From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH 0/4] ide: generic packet command representation
Date: Fri, 15 Feb 2008 15:04:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802151503580.30301@fbirervta.pbzchgretzou.qr>
References: <1202718880-1793-1-git-send-email-petkovbb@gmail.com>
 <200802120109.24152.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:40208 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133AbYBOOEt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 09:04:49 -0500
In-Reply-To: <200802120109.24152.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Borislav Petkov <petkovbb@googlemail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


On Feb 12 2008 01:09, Bartlomiej Zolnierkiewicz wrote:
>
>> On a different note, i noticed ide-scsi might also need a cleanup
>> similar to the other drivers. It is next on my TODO list in case
>> you don't have anything with a higher prio.
>
>I was actually hoping that you'll continue unifying ATAPI handling...
>
>[ ide-scsi is orphaned and has (probably) unfixable problems
>  (because of having dependencies on both IDE and SCSI subsystems)
>  so it is not worth IMO but I will of course accept patches... ]

So, why is ide-scsi still in the tree? Is there some use case besides
cdrecord? (Which can use /dev/hda already without the ide-scsi blob...)
