From: Mark Lord <liml@rtr.ca>
Subject: sata_mv & pmp support
Date: Mon, 14 Apr 2008 16:52:57 -0400
Message-ID: <4803C429.6070201@rtr.ca>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3960 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471AbYDNUw7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Apr 2008 16:52:59 -0400
In-Reply-To: <48023462.1050305@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Tejun Heo wrote:
>Currently, SATA softresets should do link onlineness check before
>actually performing SRST protocol but it doesn't really belong to
>softreset.
>
>This patch moves onlineness check in softreset to ata_eh_reset() and
>ata_eh_followup_srst_needed() to clean up code and help future sata_mv
>changes which need clear separation between SCR and TF accesses. 

Jeff Garzik wrote:
>Mark, let us know how we stand WRT sata_mv PMP needs, this should help.
 
Mark Lord wrote:
> I plan to spend Monday updating the sata_mv PMP support over
> to the newly restructured libata helpers from Tejun, so we'll
> know for sure at that time.  Should be good, though.

Well, I've spent much of the day porting to the new interfaces,
and then trying to get things working again.

One port multiplier card turned out to be totally dead.
It was never found (today) by libata, and got quite hot for some reason.
Since it is probably now toast, I've set it aside.

The other port multiplier here is different, and was not used
in the first round of tests.  So far, it gets detected by libata,
but I'm temporarily stuck on the old issue of libata not finding
any of the connected drives.  So I probably don't have the myriad
of pre/hard/soft/pmp/post reset handlers configured just right yet.

To establish some kind of baseline, I'm going to reimplement the
pmp_read/write hooks I used to have, and see if things come alive
again with those.  And then figure out again what has to change
to get rid of them.


Tejun:

Do you have any recommendations on exactly what should be in
mv_pmp_softreset() and mv_softreset() and mv_hardreset() under this scheme?

My basic attempt was to try this:

No prereset or postreset handlers of any kind.

mv_hardreset():  as in the hardreset rework patch (yet to be picked up
by Jeff), plus a call to mv_select_pmp(link->ap, SATA_PMP_CTRL_PORT)
before the sata_link_hardreset() wrapper loop.

mv_softreset():
First do mv_select_pmp(link->ap, SATA_PMP_CTRL_PORT),
and then call ata_sff_softreset().

mv_pmp_softreset():
First do mv_select_pmp(link->ap, link->pmp),
and then call ata_sff_softreset().

Resets of the pmp ports always fail with SRST failed (errno=-16).


