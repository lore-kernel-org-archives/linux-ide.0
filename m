From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/16] Generic ide device flags
Date: Mon, 30 Jun 2008 22:44:52 +0200
Message-ID: <200806302244.52788.bzolnier@gmail.com>
References: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:9492 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043AbYF3VGm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jun 2008 17:06:42 -0400
Received: by gv-out-0910.google.com with SMTP id e6so215446gvc.37
        for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2008 14:06:41 -0700 (PDT)
In-Reply-To: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Sunday 29 June 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here's another series of generic ide tweaks. The biggest change in here is the
> introduction of ide_drive_t->dev_flags member which replaces all flags members
> in the drivers structs. As a result, some PC_FLAGs become useless and got
> removed, details in the respective patch descriptions below. The changes have
> been tested with the hardware i have (i.e., ide-cd and ide-floppy).

Thanks, I applied everything.

[ I made two minor changes while at it: HWGROUP(drive) is on its way out so
  was replaced by 'hwif->hwgroup' and IDE_FLAG_* were renamed to IDE_DFLAG_*
  for consistency (we already have IDE_HFLAG_* and IDE_TFLAG_*). ]

Bart
