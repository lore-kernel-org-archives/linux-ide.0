From: Tejun Heo <tj@kernel.org>
Subject: Re: [libata/sata_sil] Error on startup
Date: Mon, 15 Sep 2008 03:10:31 -0700
Message-ID: <48CE3497.4000604@kernel.org>
References: <c58a7a270809120334r16164e3ej9f8ab769a09742ed@mail.gmail.com>	 <c58a7a270809120427p2af9885eo9cbc2d4455372882@mail.gmail.com>	 <48CBB831.9030403@ru.mvista.com>	 <c58a7a270809131023g6c5dad8em8cee2ace3b678209@mail.gmail.com>	 <48CE2389.9080205@kernel.org> <c58a7a270809150249qa0bb8e5ifdbfeb7fb5ef0565@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58005 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbYIOKM7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Sep 2008 06:12:59 -0400
In-Reply-To: <c58a7a270809150249qa0bb8e5ifdbfeb7fb5ef0565@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Gonzalez <langabe@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Hello,

Alex Gonzalez wrote:
> :<6> sda:0:msdos_partition: sector_size=1
> 0:read_dev_sector: mapping = 87946cac
> 0:__read_cache_page:cached_page=83a15580
> 0:read_cache_page: page=83a15580
> 0:lock_page
> 0:sync_page on mm/filemap.c
> 0:block_sync_page
> 0:blk_run_backing_dev()
> 0:blk_backing_dev_unplug()
> 0:scsi_request_fn
> 0:scsi_dispatch_cmd
> 0:ata_scsi_queuecmd
> 0:ata_scsi_translate
> 0:***ata_qc_prep***
> 0:***ata_check_status***
> 0:***ata_std_dev_select***
> 0:***ata_check_status***
> 0:***ata_check_status***
> 0:***ata_tf_load
> 0:***ata_bmdma_setup***
> 0:***ata_exec_command***
> 0:***ata_bmdma_start***
> 0:Dispatched cmd 8b64eba0 with rth 0
> 
> <PAUSE>
> 
> 0:***sil_freeze()***
> 0:***ata_bmdma_error_handler***

This is libata error handling kicking in after detecting command
timeout.

> 0:***ata_bmdma_status***
> 0:***ata_bmdma_stop***

And EH tries to stop the bmdma engine.

> *********************************************
> cpu_0 received a bus/cache error
> *********************************************
> Bridge: Phys Addr = 0x0000000000, Device_AERR = 0x00000000
> Bridge: The devices reporting AERR are:
> CPU: (XLR specific) Cache Error log = 0x0000007800004601, Phy Addr =
> 0x00f0000088
> CPU: epc = 0x83435dfc, errorepc = 0x835bf054, cacheerr = 0x00000000
> Can not handle bus/cache error - Halting cpu

Which triggers bus/cache error.  Hmmm... When the booting works, does
the drive keep working after boot?  ie. if you put the drive under
stress test, does the system survive.  Also, error handling shouldn't
trigger bus/cache error.  Do you know what the bus/cache error means?

Thanks.

-- 
tejun
