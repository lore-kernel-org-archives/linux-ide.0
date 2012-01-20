From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: How does libata handles an 'ATA_ABORTED' error?
Date: Fri, 20 Jan 2012 16:00:56 +0100
Message-ID: <201201201600.56794.jbe@pengutronix.de>
References: <201112140948.03859.jbe@pengutronix.de> <4EEAC85C.1080501@teksavvy.com> <CADLC3L1nLgM=f2YXf39s20N_JiLy8YZs=eO4kOtf3pvhFOA6iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42654 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab2ATPCZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2012 10:02:25 -0500
In-Reply-To: <CADLC3L1nLgM=f2YXf39s20N_JiLy8YZs=eO4kOtf3pvhFOA6iA@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Robert Hancock <hancockrwd@gmail.com>, Mark Lord <kernel@teksavvy.com>

Hi,

Robert Hancock wrote:
> On Thu, Dec 15, 2011 at 10:26 PM, Mark Lord <kernel@teksavvy.com> wrote:
> > On 11-12-15 01:38 PM, Robert Hancock wrote:
> >> On Thu, Dec 15, 2011 at 5:01 AM, Juergen Beisert <jbe@pengutronix.de>
> >> wrote:
> >
> > ..
> >
> >>> As far as I understand the problem of this kind of errors is for the
> >>> multi sector write case. The framework does not know what sectors
> >>> fails, so the question is: does it repeat the whole multi sector
> >>> sequence or what else it does?
> >>
> >> The entire request should get retried.
> >
> > I'm not so sure that is correct.
> >
> > The Linux IDE stack will not retry the completed sectors
> > (those which were successfully transfered in multiple-sector blocks).
> >
> > Not sure what libata does here.
>
> I don't know of any logic in libata that tries to do selective
> retries. In many cases we wouldn't know where in the request it failed
> in any case. There's no real reason to do this anyway as redoing a bit
> of I/O after a device error shouldn't be a big deal.

Some info about the real behaviour. I added some code for fault injection into
the libata to simulate the error report the CF card does when it is in trouble
with its internal flash memory. And at least for the PIO mode case the whole
transfer gets repeated in the case of this error:

[...]
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x84 0x8A 0x1 <-- this is the transfer
ata_sff_hsm_move HSM_ST_FIRST                         <-- state machine starts
FAULT_INJECTION: forcing a failure                    <-- fault injection happens
ata_sff_hsm_move HSM_ST_ERR                           <-- state machine enters ERROR detection
ata_sff_tf_read: 'ABORT' flag reported                <-- simulated error type
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata1.00: failed command: WRITE SECTOR(S)
ata1.00: cmd 30/00:00:84:8a:01/00:00:00:00:00/e0 tag 0 pio 131072 out
         res 58/04:b6:ce:8a:01/00:00:00:00:00/e0 Emask 0x3 (HSM violation)
ata1.00: status: { DRDY DRQ }
ata1.00: error: { ABRT }
ata1: soft resetting link
ata1.00: configured for PIO1
ata1: EH complete
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x84 0x8A 0x1 <-- the same transfer again \o/
[...]

Now I'm going to check the DMA case. Currently it looks a bit different to me.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
