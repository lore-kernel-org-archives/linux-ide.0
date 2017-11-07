From: Borislav Petkov <bp@alien8.de>
Subject: Re: [cdrom_check_status] BUG: unable to handle kernel NULL pointer
 dereference at 000001c0
Date: Tue, 7 Nov 2017 15:01:02 +0100
Message-ID: <20171107140102.n2pncsaer5o5hmt7@pd.tnic>
References: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
 <20171107104336.ojanuvgjgt5o53ox@pd.tnic>
 <20171107130626.dk5rxrprolvcne5w@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171107130626.dk5rxrprolvcne5w@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@sandisk.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Nov 07, 2017 at 09:06:26PM +0800, Fengguang Wu wrote:
> It turns out rather hard to reproduce -- that's the only occurrence in
> 100 boots. Perhaps we'll have to give up on this.

Right,

you could blacklist CONFIG_IDE from your randconfig testing - IDE has
been going away since forever :-)

Alternatively, we could brown-paper bag it with something like this:

---
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index a7355ab3bb22..6ff0be8cbdc9 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -867,11 +867,16 @@ static void msf_from_bcd(struct atapi_msf *msf)
 int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
 {
 	struct cdrom_info *info = drive->driver_data;
-	struct cdrom_device_info *cdi = &info->devinfo;
+	struct cdrom_device_info *cdi;
 	unsigned char cmd[BLK_MAX_CDB];
 
 	ide_debug_log(IDE_DBG_FUNC, "enter");
 
+	if (!info)
+		return -EIO;
+
+	cdi = &info->devinfo;
+
 	memset(cmd, 0, BLK_MAX_CDB);
 	cmd[0] = GPCMD_TEST_UNIT_READY;
--

but from looking at this (I had forgotten how, hm, "interesting" the
IDE code was :-)) it looks like some sort of a race where we've called
->release earlier and drive->driver_data is gone by the time the
workqueue function runs. Or something to that effect...

Anyway, you can still give me your qemu command line and I can try to
debug it, if you'd like. But yeah, it would probably be a waste of time
as IDE is long deprecated...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
