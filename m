From: Tejun Heo <tj@kernel.org>
Subject: Re: libata-core: devslp fails on ATP mSATA
Date: Tue, 1 Dec 2015 11:17:15 -0500
Message-ID: <20151201161715.GA12922@mtj.duckdns.org>
References: <20151201092234.GB29791@awelinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151201092234.GB29791@awelinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
List-Id: linux-ide@vger.kernel.org

(cc'ing Hannes and Margin)

Hello,

On Tue, Dec 01, 2015 at 10:22:34AM +0100, Andreas Werner wrote:
> Hi,
> i have a question regarding the devslp feature in several SATA devices.
> 
> I currently working on an embedded board with a Freescale P1013/P1022.
> I have a mSATA Device from ATP which is connected to the SATA port.
> The Yocot Kernel 3.14.26 is used in the system.
> 
> This mSata failed with the following log messages:
...
> The device is not recognized by the System, and i do not have access to it.
> 
> I have also tested the mSATA using a 3.14 Kernel and a 4.2 Kernel on
> a Intel Atom E3825. On this system, the mSATA is working perfectly.
> 
> Next test was to use a 3.4.18 Kernel (which was the old BSP) on the P1013.
> With this Kernel the mSATA is also working correctly.
> 
> 
> During some deeper debuggin in libata-core.c i find that the problem is
> regarding the devslp.
> 
> /* Check and mark DevSlp capability. Get DevSlp timing variables
> * from SATA Settings page of Identify Device Data Log.
> */
> if (ata_id_has_devslp(dev->id)) {
> u8 *sata_setting = ap->sector_buf;
> int i, j;
> 
> dev->flags |= ATA_DFLAG_DEVSLP;
> err_mask = ata_read_log_page(dev,
>         ATA_LOG_SATA_ID_DEV_DATA,
>         ATA_LOG_SATA_SETTINGS,
>         sata_setting,
>         1);
> if (err_mask)
>  ata_dev_dbg(dev,
>       "failed to get Identify Device Data, Emask 0x%x\n",
>       err_mask);
> else
>  for (i = 0; i < ATA_LOG_DEVSLP_SIZE; i++) {
>   j = ATA_LOG_DEVSLP_OFFSET + i;
>   dev->devslp_timing[i] = sata_setting[j];
>  }
> }
> 
> 
> If i comment out this code, the device is recognized correctly. I figured out
> that only the "ata_read_log_page" return a AC_ERR_DEV, and makes the device
> malfunction (-> failed to set xfermode).
> 
> I am not that familiar with SATA and did not understand why the "ata_read_log_page" can
> corrupt my mSATA device.
> 
> The only thing what i can imagine is, that the Host controller does not support devslp
> (which is the case).
> 
> Does anybody of you have hint for me to fixe that problem in a clean way?

So, I suppose this is a fallout from 9faa643855df ("libata: use
READ_LOG_DMA_EXT").  The description just says "we should try use it"
but is there any benefit from using NCQ variant of read log page?  I
mean, it's used during config and error handling, so it's not like
queueing is gonna help anything.  It ends up issuing NCQ commands on
controllers which don't support NCQ and causes failures on devices
which lie about supporting the feature.

Thanks.

-- 
tejun
