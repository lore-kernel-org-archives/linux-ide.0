From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ide_tape: convert jiffies with jiffies_to_msecs
Date: Tue, 03 Mar 2015 02:37:27 -0800
Message-ID: <1425379047.17273.11.camel@perches.com>
References: <1425378228-6095-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425378228-6095-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 2015-03-03 at 05:23 -0500, Nicholas Mc Guire wrote:
> Use jiffies_to_msecs for converting jiffies as it handles all of the corner
> cases reliably and also helps readability. The printk format is fixed up 
> as jiffies_to_msecs returns unsigned int not unsigned long.

Then ideally you'd use %u not %d.

> Note that this patch will give a checkpatch warning due to "quoted string 
> split across lines" but thats not related to this change - not sure if this
> should be fixed - looks intentional to me.

It's not.  It'd be better coalesced.

> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
[]
> @@ -1793,11 +1793,11 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
>  	tape->best_dsc_rw_freq = clamp_t(unsigned long, t, IDETAPE_DSC_RW_MIN,
>  					 IDETAPE_DSC_RW_MAX);
>  	printk(KERN_INFO "ide-tape: %s <-> %s: %dKBps, %d*%dkB buffer, "
> -		"%lums tDSC%s\n",
> +		"%dms tDSC%s\n",
>  		drive->name, tape->name, *(u16 *)&tape->caps[14],
>  		(*(u16 *)&tape->caps[16] * 512) / tape->buffer_size,
>  		tape->buffer_size / 1024,
> -		tape->best_dsc_rw_freq * 1000 / HZ,
> +		jiffies_to_msecs(tape->best_dsc_rw_freq),
>  		(drive->dev_flags & IDE_DFLAG_USING_DMA) ? ", DMA" : "");
