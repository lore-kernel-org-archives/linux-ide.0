From: Christoph Hellwig <hch@lst.de>
Subject: Re: [ide] ec7d9c9ce8:
 WARNING:at_fs/proc/generic.c:#remove_proc_entry
Date: Thu, 20 Dec 2018 17:18:32 +0100
Message-ID: <20181220161832.GA19486@lst.de>
References: <20181220091931.zcibvplow3oxzacs@inn2.lkp.intel.com> <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com> <bd9cad88-08c6-ee65-abef-eaa8a4540019@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd9cad88-08c6-ee65-abef-eaa8a4540019@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>, David Miller <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, lkp@01.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Dec 20, 2018 at 09:14:50AM -0700, Jens Axboe wrote:
> Maybe the the tiny subset of IDE users don't actually have the proc
> stuff enabled? A few months ago I did plenty of IDE testing with the
> MQ conversion, but I never saw anything like this. I'm guessing that
> I, too, did not have IDE_PROC_FS enabled.

Or the tiny subset of ide users basically doesn't exist and the
few platforms that use ide are basically bitrotting?

> Christoph, do you want to post the one-liner fix for this one?

See below:

--
>From c3550c617ffc48079fe6364a4fa3c7f75a09028b Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 20 Dec 2018 17:16:53 +0100
Subject: ide: fix a typo in the settings proc file name

Fixes: ec7d9c9ce8 ("ide: replace ->proc_fops with ->proc_show")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 45c997430332..0e51803de0e7 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -544,7 +544,7 @@ void ide_proc_port_register_devices(ide_hwif_t *hwif)
 		drive->proc = proc_mkdir(drive->name, parent);
 		if (drive->proc) {
 			ide_add_proc_entries(drive->proc, generic_drive_entries, drive);
-			proc_create_data("setting", S_IFREG|S_IRUSR|S_IWUSR,
+			proc_create_data("settings", S_IFREG|S_IRUSR|S_IWUSR,
 					drive->proc, &ide_settings_proc_fops,
 					drive);
 		}
-- 
2.19.2
