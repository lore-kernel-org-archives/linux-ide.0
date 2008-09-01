From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH] ide: Build fix for CONFIG_IDE_PROC_FS=n
Date: Tue, 02 Sep 2008 00:52:55 +0200
Message-ID: <878wub1nso.fsf@denkblock.local>
References: <20080829213217.4826.91622.stgit@denkblock.local>
	<200808311752.06818.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:48180 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbYIAWxS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Sep 2008 18:53:18 -0400
In-Reply-To: <200808311752.06818.bzolnier@gmail.com> (Bartlomiej
	Zolnierkiewicz's message of "Sun, 31 Aug 2008 17:52:05 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On Friday 29 August 2008, Elias Oltmanns wrote:
>> Recent changes have broken compilation when CONFIG_IDE_PROC_FS is not set.
>> 
>> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
>
> Thanks!
>
> I integrated your fixes into guilty patches ("ide-floppy: move /proc handling
> to ide-floppy_proc.c" and "ide-disk: move /proc handling to ide-disk_proc.c")
> to preserve bisection.

Yes, that's fine with me, but in the case of ide-disk_proc.h things
apparently went wrong. As of next-20080901, I still have the line

ide-disk_mod-y += ide-disk.o ide-disk_ioctl.o ide-disk_proc.o

in the Makefile. Could you please truncate that line appropriately?

Regards,

Elias
