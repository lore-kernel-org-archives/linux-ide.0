From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Mon, 20 Feb 2017 19:15:34 +0100
Message-ID: <1548730.TDiBKU8UQt@amdc3058>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAMuHMdWX-PT_8a==rqAvc5Hx_1PNWPwvLGPeERUXvsMcEarziQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37490 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdBTSPk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2017 13:15:40 -0500
In-reply-to: <CAMuHMdWX-PT_8a==rqAvc5Hx_1PNWPwvLGPeERUXvsMcEarziQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tejun Heo <tj@kernel.org>, Michael Schmitz <schmitzmic@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>


Hi,

On Wednesday, February 15, 2017 09:45:53 AM Geert Uytterhoeven wrote:
> On Fri, Dec 30, 2016 at 3:01 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > This patchset adds m68k/Atari Falcon PATA support to libata.
> > The major difference in the new libata's pata_falcon host
> > driver when compared to legacy IDE's falconide host driver is
> > that we are using polled PIO mode and thus avoiding the need
> > for STDMA locking magic altogether.
> >
> > Tested under ARAnyM emulator.
> >
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> >
> >
> > Bartlomiej Zolnierkiewicz (3):
> >   ata: allow subsystem to be used on m68k arch
> >   ata: pass queued command to ->sff_data_xfer method
> >   ata: add Atari Falcon PATA controller driver
> 
> drivers/ata/pata_falcon.c:57:18: error: 'struct request' has no member
> named 'cmd_type'
> drivers/ata/pata_falcon.c:57:32: error: 'REQ_TYPE_FS' undeclared
> (first use in this function)
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/12936876/

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] pata_falcon: build fix for block layer changes

commit aebf526b53ae ("block: fold cmd_type into the REQ_OP_
space") from the block tree removes cmd_type so pata_falcon
needs the following trivial update to make it build again.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Tejun, I guess that you may need to fold this fix into
your pull request for 4.11 (block layer pull request has
been already sent by Jens so it will be most likely merged
first).

 drivers/ata/pata_falcon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_falcon.c
===================================================================
--- a/drivers/ata/pata_falcon.c	2017-02-20 18:40:04.174989455 +0100
+++ b/drivers/ata/pata_falcon.c	2017-02-20 18:42:59.482993870 +0100
@@ -54,7 +54,7 @@ static unsigned int pata_falcon_data_xfe
 	bool swap = 1;
 
 	if (dev->class == ATA_DEV_ATA && cmd && cmd->request &&
-	    cmd->request->cmd_type == REQ_TYPE_FS)
+	    !blk_rq_is_passthrough(cmd->request))
 		swap = 0;
 
 	/* Transfer multiple of 2 bytes */

