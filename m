From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA150TX4 atat1:command timeout
Date: Mon, 14 Feb 2005 17:35:08 -0500
Message-ID: <4211279C.5070205@pobox.com>
References: <42111B02.4010805@netmosphere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45790 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261243AbVBNWf3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Feb 2005 17:35:29 -0500
In-Reply-To: <42111B02.4010805@netmosphere.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: francoisp@netmosphere.net
Cc: linux-ide@vger.kernel.org

Francois Payette wrote:
> Hi,
> 
> We have reported earlier a strange bug at bugzilla.kernel.org (#4106 
> <http://bugzilla.kernel.org/show_bug.cgi?id=4106>): in our setup of a 
> 20318 (the SATA150 TX4, not the fastrack one) we are systematically 
> getting ata1: command timeout after copying between 200 and 600GB of 
> data through the controller. Our setup is with 4 maxtor 6Y200M0, 2 of 
> them in raid 0, and the other 2 in a LV group over a raid 0 md array. 
> When copying from one array to the other one repeatedly,  the machines 
> freezes once out out of every 2 copy. We changed the drive order, but we 
> still got the msg ata1 command timeout. We swapped the order of the 
> cables, and still got ata1 command timeout. We got a few kernel panics 
> with spin locks, but since finding this forum we added the line
> 
> writel(mask, mmio_base + PDC_INT_SEQMASK);
> 
> to pdc_interrupt, and that one was gone.

The latest kernel (2.6.11-rc4) includes this code change.


> We have kernel 2.6.10-753 (fc3) with all relevant patches to the sata 
> stuff, the last of which is the one Bartlomiej Zolnierkiewicz posted on 
> 06/02/2005. 
> http://marc.theaimsgroup.com/?l=linux-ide&m=110769875419863&w=2 
> <http://marc.theaimsgroup.com/?l=linux-ide&m=110769875419863&w=2>
> 
> After commenting out the line
>    /* reduce TBG clock to 133 Mhz. */
>    /*tmp = readl(mmio + PDC_TBG_MODE); */
>    tmp &= ~0x30000; /* clear bit 17, 16*/
>    tmp |= 0x10000;  /* set bit 17:16 = 0:1 */
>    /*writel(tmp, mmio + PDC_TBG_MODE); */
> 
> in pdc_host_init (total shot in the dark) the setup seems more stable, 
> we have now gone through 3 cycles of stress test (600GB of copying) and 
> have not seen the crash.
> 
> Earlier we tried the same stress test with ATA_DEBUG and 
> ATA_VERBOSE_DEBUG defined, the error did not occur  maybe because of it 
> was slowed down with all the output)?

Correct, all that debug output introduces delays.  Introducing delays 
often "band-aids" a problem enough that it appears to work.

IOW, you can decrease performance to the point where bugs stop 
appearing, even though they still exist.


> Later we tried  commenting out the line that sets bmr burst 
> (PDC_FLASH_CTL) and slew rate (PDC_SLEW_CTL) in pdc_host_init, and that 
> slowed the setup to half it's orignal speed, but in that case the 
> problem did not show up.

Any chance you can test 2.6.11-rc4, either vanilla or only with your 
changes to sata_promise.c, and report the results?

	Jeff


