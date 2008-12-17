From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: How to flush write-back cache in block device driver?
Date: Wed, 17 Dec 2008 09:35:41 +0100
Message-ID: <20081217083540.GE32491@kernel.dk>
References: <38D9F46DFF92C54980D2F2C1E8EE31301CB4E70F@pdsmsx503.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:12864 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbYLQIgJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Dec 2008 03:36:09 -0500
Content-Disposition: inline
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE31301CB4E70F@pdsmsx503.ccr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, Dec 17 2008, Gao, Yunpeng wrote:
> Hi all,
> 
> I'm porting a NAND flash driver to linux 2.6.27. The NAND driver is
> based on NFTL, not kernel MTD subsystem. That is, it will report to
> kernel as a standard linux block device, so it can be used as a normal
> hard disk.
> 
> The NAND driver uses an internal write-back cache to improve R/W
> performance. And it provides a function to force flush the cache. But
> as it requires in our project that, after a successful umount to ext3
> file system, even if the system encountered an un-expected power-down,
> user data stored in NAND still need to be correct after system reboot.
> 
> Now I have add some code in the driver like this:
> -----------------------------------------------------------------------------------
> static void SBD_prepare_flush(struct request_queue *q, struct request *rq)
> {
>        rq->cmd_type = REQ_TYPE_LINUX_BLOCK;
>        /* rq->timeout = 5 * HZ; */
>        rq->cmd[0] = REQ_LB_OP_FLUSH;
> }
> 
> ...
>        blk_queue_ordered(dev->queue, QUEUE_ORDERED_DRAIN_FLUSH, SBD_prepare_flush);
> ...
> 
>                while (((req = elv_next_request(q)) != NULL)) {
>                                  if (req->cmd_type == REQ_TYPE_LINUX_BLOCK &&
>                                        req->cmd[0] == REQ_LB_OP_FLUSH) {
>                                        printk(KERN_ERR "Will flush cache\n");
>                                        /* Cache flush */
>                                        if (GLOB_FTL_Flush_Cache()) {
>                                                printk(KERN_ERR "Failed to flush FTL cache\n");
>                                                end_request(req, 0);
>                                        } else
>                                                end_request(req, 1);
>                                        continue;
>                                        }
> 
>                        if (!blk_fs_request(req)) {
>                                nand_dbg_print(NAND_DBG_WARN,
>                                               "Spectra: Skip non-fs request\n");
>                                end_request(req, 0);
>                                continue;
>                        }
> 
>                        sectors_xferred = SBD_xfer_request(req);
>                        success = (sectors_xferred < 0) ? 0 : 1;
>                        __blk_end_request(req, success ? 0 : -EIO,
>                                          sectors_xferred << 9);
>                }
> 
> ...
> 
> ----------------------------------------------------------------------------------------------------
> 
> But this code doesn't work.  I mounted ext3 file system, copy a file,
> then wait for serveral minutes, then umount file system and power
> down. And during the whole process, the flush function is never
> called. I tested this in a initrd (busybox) environment.
> 
> Does I need to do something else to enable barrier support in linux kernel?
> Or, the driver should flush cache once the 'umount' or 'sync' command
> is executed? But I don't know how to do it.
> 
> It'll be very appreciated if you could give me some suggests or
> comments about this. Thank you very much.

For ext3, mount the filesystem with -o barrier=1 as an option to enable
barrier support.

-- 
Jens Axboe

