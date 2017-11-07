From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [cdrom_check_status] BUG: unable to handle kernel NULL pointer
 dereference at 000001c0
Date: Wed, 8 Nov 2017 00:34:02 +0800
Message-ID: <20171107163402.k5asnntwtidzxnuf@wfg-t540p.sh.intel.com>
References: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
 <20171107104336.ojanuvgjgt5o53ox@pd.tnic>
 <20171107130626.dk5rxrprolvcne5w@wfg-t540p.sh.intel.com>
 <20171107140102.n2pncsaer5o5hmt7@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [192.55.52.88] ([192.55.52.88]:25743 "EHLO mga01.intel.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756182AbdKGQeG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 7 Nov 2017 11:34:06 -0500
Content-Disposition: inline
In-Reply-To: <20171107140102.n2pncsaer5o5hmt7@pd.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@sandisk.com>, linux-kernel@vger.kernel.org

On Tue, Nov 07, 2017 at 03:01:02PM +0100, Borislav Petkov wrote:
>On Tue, Nov 07, 2017 at 09:06:26PM +0800, Fengguang Wu wrote:
>> It turns out rather hard to reproduce -- that's the only occurrence in
>> 100 boots. Perhaps we'll have to give up on this.
>
>Right,
>
>you could blacklist CONFIG_IDE from your randconfig testing - IDE has
>been going away since forever :-)
>
>Alternatively, we could brown-paper bag it with something like this:

Tested-by: Fengguang Wu <fengguang.wu@intel.com>

I managed to reproduce the issue ~10 times with 500+ boots.
With this fix applied, the BUG no longer shows up in so many boots.

Thanks,
Fengguang

>---
>diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
>index a7355ab3bb22..6ff0be8cbdc9 100644
>--- a/drivers/ide/ide-cd.c
>+++ b/drivers/ide/ide-cd.c
>@@ -867,11 +867,16 @@ static void msf_from_bcd(struct atapi_msf *msf)
> int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
> {
> 	struct cdrom_info *info = drive->driver_data;
>-	struct cdrom_device_info *cdi = &info->devinfo;
>+	struct cdrom_device_info *cdi;
> 	unsigned char cmd[BLK_MAX_CDB];
>
> 	ide_debug_log(IDE_DBG_FUNC, "enter");
>
>+	if (!info)
>+		return -EIO;
>+
>+	cdi = &info->devinfo;
>+
> 	memset(cmd, 0, BLK_MAX_CDB);
> 	cmd[0] = GPCMD_TEST_UNIT_READY;
>--
>
>but from looking at this (I had forgotten how, hm, "interesting" the
>IDE code was :-)) it looks like some sort of a race where we've called
>->release earlier and drive->driver_data is gone by the time the
>workqueue function runs. Or something to that effect...
>
>Anyway, you can still give me your qemu command line and I can try to
>debug it, if you'd like. But yeah, it would probably be a waste of time
>as IDE is long deprecated...
>
>Thx.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
