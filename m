From: Francois Payette <francoisp@netmosphere.net>
Subject: SATA150TX4 atat1:command timeout
Date: Mon, 14 Feb 2005 16:41:22 -0500
Message-ID: <42111B02.4010805@netmosphere.net>
Reply-To: francoisp@netmosphere.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from 65.18.135.ptr ([65.18.135.81]:35241 "EHLO isecurit.com")
	by vger.kernel.org with ESMTP id S261540AbVBNVkr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Feb 2005 16:40:47 -0500
Received: from eliza.isecurit.net (modemcable026.47-81-70.mc.videotron.ca [70.81.47.26])
	(authenticated)
	by isecurit.com (8.11.6/8.11.6) with ESMTP id j1ELUIe24134
	for <linux-ide@vger.kernel.org>; Mon, 14 Feb 2005 16:30:18 -0500
Received: from [192.168.0.7] (dice.isecurit.net [192.168.0.7])
	by eliza.isecurit.net (Postfix) with ESMTP id 2CCF0AF79B
	for <linux-ide@vger.kernel.org>; Sun, 13 Feb 2005 12:59:29 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

We have reported earlier a strange bug at bugzilla.kernel.org (#4106 
<http://bugzilla.kernel.org/show_bug.cgi?id=4106>): in our setup of a 
20318 (the SATA150 TX4, not the fastrack one) we are systematically 
getting ata1: command timeout after copying between 200 and 600GB of 
data through the controller. Our setup is with 4 maxtor 6Y200M0, 2 of 
them in raid 0, and the other 2 in a LV group over a raid 0 md array. 
When copying from one array to the other one repeatedly,  the machines 
freezes once out out of every 2 copy. We changed the drive order, but we 
still got the msg ata1 command timeout. We swapped the order of the 
cables, and still got ata1 command timeout. We got a few kernel panics 
with spin locks, but since finding this forum we added the line

writel(mask, mmio_base + PDC_INT_SEQMASK);

to pdc_interrupt, and that one was gone.

We have kernel 2.6.10-753 (fc3) with all relevant patches to the sata 
stuff, the last of which is the one Bartlomiej Zolnierkiewicz posted on 
06/02/2005. 
http://marc.theaimsgroup.com/?l=linux-ide&m=110769875419863&w=2 
<http://marc.theaimsgroup.com/?l=linux-ide&m=110769875419863&w=2>

After commenting out the line
    /* reduce TBG clock to 133 Mhz. */
    /*tmp = readl(mmio + PDC_TBG_MODE); */
    tmp &= ~0x30000; /* clear bit 17, 16*/
    tmp |= 0x10000;  /* set bit 17:16 = 0:1 */
    /*writel(tmp, mmio + PDC_TBG_MODE); */

in pdc_host_init (total shot in the dark) the setup seems more stable, 
we have now gone through 3 cycles of stress test (600GB of copying) and 
have not seen the crash.

Earlier we tried the same stress test with ATA_DEBUG and 
ATA_VERBOSE_DEBUG defined, the error did not occur  maybe because of it 
was slowed down with all the output)?

Later we tried  commenting out the line that sets bmr burst 
(PDC_FLASH_CTL) and slew rate (PDC_SLEW_CTL) in pdc_host_init, and that 
slowed the setup to half it's orignal speed, but in that case the 
problem did not show up.

We outputted the command timeout and it's  0x35 (ATA_CMD_WRITE_EXT) 
protocol is 4 (ATA_PROT_DMA).

Any ideas?
TIA,
Francois Payette
