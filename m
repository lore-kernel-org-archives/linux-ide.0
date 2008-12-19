From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/8] ide-cd: first conversion batch
Date: Fri, 19 Dec 2008 21:15:40 +0100
Message-ID: <200812192115.41068.bzolnier@gmail.com>
References: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:35102 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbYLSUkS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Dec 2008 15:40:18 -0500
In-Reply-To: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Thursday 18 December 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here's the first batch of conversion patches. Now ide_issue_pc/ide_transfer_pc
> are almost completely aligned to their ide-cd counterparts
> cdrom_start_packet_command/cdrom_transfer_packet_command. The only thing

Looks good generally but I need more time for detailed review.

[ Your super-quick action on this has caught me unprepared. ;) ]

> missing is the setting of the irq handler through ide_set_handler but this
> is not that trivial since if i'd moved ide-cd's irq handler to ide-atapi
> that would suck in a bunch of other ide-cd functions which is not what we
> want, (yes/no)? and I'm going to have to ponder a little bit more on that.

Yes, we don't want to move them over.  In worst case we can add
ide_handler_t *__old_pc_handler to ide_drive_t and set it in ide-cd
(an acceptable hack this time) but there might be better options.

Thanks,
Bart
