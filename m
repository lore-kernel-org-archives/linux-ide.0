From: Mark Lord <liml@rtr.ca>
Subject: Re: WARNING: at drivers/ata/libata-sff.c:1016
Date: Sat, 19 Apr 2008 08:01:21 -0400
Message-ID: <4809DF11.2010309@rtr.ca>
References: <4807F96F.8060500@rtr.ca> <48093681.7050100@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3261 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150AbYDSMBY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 08:01:24 -0400
In-Reply-To: <48093681.7050100@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
>
> Mmmm.. got another one, slightly different line perhaps,
> though maybe it just moved around (latest libata-dev#upstream this 
> morning).
> 
> 
> ata201: SATA link down (SStatus 0 SControl 300)
> ata202: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ------------[ cut here ]------------
> WARNING: at drivers/ata/libata-sff.c:1211 ata_sff_hsm_move+0x595/0x628()
..
> [ata_pio_task+168/185] ata_pio_task+0xa8/0xb9 
..
> ata202.15: failed to read PMP GSCR[0] (Emask=0x10)
> ata202: failed to recover some devices, retrying in 5 secs
> ata202: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
..

That's from here in libata-sff.c:1211:

        case HSM_ST_LAST:
                if (unlikely(!ata_ok(status))) {
                        qc->err_mask |= __ac_err_mask(status);
                        ap->hsm_task_state = HSM_ST_ERR;
                        goto fsm_start;
                }
                /* no more data to transfer */
                DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
                        ap->print_id, qc->dev->devno, status);
 >>>>>>         WARN_ON(qc->err_mask);
                ap->hsm_task_state = HSM_ST_IDLE;
		...
I thought that maybe this might have been my LLD (sata_mv) noticing that
the device (PM in this case) got unplugged mid-stride, and set the qc->err_mask
for it.  But te LLD doesn't touch polled PIO commands, and there was no log
message from the LLD preceding this one, or following it either.

However, there were three of these same WARN_ONs in a row,
so perhaps libata-eh was just cancelling the outstanding commands
or something, and ???.

No big deal, it didn't crash or anything, and I was abusively unplugging/replugging
things rather rapidly at the time.  :)

Expect to see the sata_mv IRQ/EH/hotplug patches here in a day or three,
after I wind them up and through Marvell's people first.

I'm beginning to *like* this driver, and might actually have to remove
the "HIGHLY EXPERIMENTAL" label from it soon-ish.  :)
