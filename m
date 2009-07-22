From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 3/3] ide-tape: fix handling of postponed rqs
Date: Wed, 22 Jul 2009 07:56:57 +0200
Message-ID: <20090722055657.GA15465@liondog.tnic>
References: <1247910917-5237-1-git-send-email-petkovbb@gmail.com>
 <1247910917-5237-4-git-send-email-petkovbb@gmail.com>
 <20090721.204704.123531717.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756408AbZGVF5H@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090721.204704.123531717.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jul 21, 2009 at 08:47:04PM -0700, David Miller wrote:

> drivers/ide/ide-tape.c: In function =E2=80=98ide_tape_stall_queue=E2=80=
=99:
> drivers/ide/ide-tape.c:379: warning: unused variable =E2=80=98rq=E2=80=
=99

Sorry about that, rq is used only in the debug statement and I forgot t=
o
do a non-debug build, my bad.

--
=46rom: Borislav Petkov <petkovbb@gmail.com>
Date: Wed, 22 Jul 2009 07:38:29 +0200
Subject: [PATCH 3/3] ide-tape: fix handling of postponed rqs

ide-tape used to hit

[   58.614854] ide-tape: ht0: BUG: Two DSC requests queued!

due to the fact that another rq was being issued while the driver was
waiting for DSC to get set for the device executing ATAPI commands whic=
h
set the DSC to 1 to indicate completion.

Here's a sample output of that case:

issue REZERO_UNIT

[  143.088505] ide-tape: ide_tape_issue_pc: retry #0, cmd: 0x01
[  143.095122] ide: Enter ide_pc_intr - interrupt handler
[  143.096118] ide: Packet command completed, 0 bytes transferred
[  143.106319] ide-tape: ide_tape_callback: cmd: 0x1, dsc: 1, err: 0
[  143.112601] ide-tape: idetape_postpone_request: cmd: 0x1, dsc_poll_f=
req: 2000

we stall the ide-tape queue here waiting for DSC

[  143.119936] ide-tape: ide_tape_read_position: enter
[  145.119019] ide-tape: idetape_do_request: sector: 4294967295, nr_sec=
tors: 0

and issue the new READ_POSITION rq and hit the check.

[  145.126247] ide-tape: ht0: BUG: Two DSC requests queued!
[  145.131748] ide-tape: ide_tape_read_position: BOP - No
[  145.137059] ide-tape: ide_tape_read_position: EOP - No

Also, ->postponed_rq used to point to that postponed request. To make
things worse, in certain circumstances the rq it was pointing to got
replaced unterneath it by swiftly reusing the same rq from the mempool
of the block layer practically confusing stuff even more.

However, we don't need to keep a pointer to that rq but simply wait for
DSC to be set first before issuing the follow-up request in the drive's
queue. In order to do that, we make idetape_do_request() first check th=
e
DSC and if not set, we stall the drive queue giving the other device on
that IDE channel a chance.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   33 +++++++++++----------------------
 1 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 08f09f5..96c93b0 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -155,7 +155,8 @@ typedef struct ide_tape_obj {
 	 * other device. Note that at most we will have only one DSC (usually
 	 * data transfer) request in the device request queue.
 	 */
-	struct request *postponed_rq;
+	bool postponed_rq;
+
 	/* The time in which we started polling for DSC */
 	unsigned long dsc_polling_start;
 	/* Timer used to poll for dsc */
@@ -372,15 +373,14 @@ static int ide_tape_callback(ide_drive_t *drive, =
int dsc)
  * Postpone the current request so that ide.c will be able to service =
requests
  * from another device on the same port while we are polling for DSC.
  */
-static void idetape_postpone_request(ide_drive_t *drive)
+static void ide_tape_stall_queue(ide_drive_t *drive)
 {
 	idetape_tape_t *tape =3D drive->driver_data;
-	struct request *rq =3D drive->hwif->rq;
=20
 	ide_debug_log(IDE_DBG_FUNC, "cmd: 0x%x, dsc_poll_freq: %lu",
-		      rq->cmd[0], tape->dsc_poll_freq);
+		      drive->hwif->rq->cmd[0], tape->dsc_poll_freq);
=20
-	tape->postponed_rq =3D rq;
+	tape->postponed_rq =3D true;
=20
 	ide_stall_queue(drive, tape->dsc_poll_freq);
 }
@@ -394,7 +394,7 @@ static void ide_tape_handle_dsc(ide_drive_t *drive)
 	tape->dsc_poll_freq =3D IDETAPE_DSC_MA_FAST;
 	tape->dsc_timeout =3D jiffies + IDETAPE_DSC_MA_TIMEOUT;
 	/* Allow ide.c to handle other requests */
-	idetape_postpone_request(drive);
+	ide_tape_stall_queue(drive);
 }
=20
 /*
@@ -567,7 +567,6 @@ static ide_startstop_t idetape_do_request(ide_drive=
_t *drive,
 	ide_hwif_t *hwif =3D drive->hwif;
 	idetape_tape_t *tape =3D drive->driver_data;
 	struct ide_atapi_pc *pc =3D NULL;
-	struct request *postponed_rq =3D tape->postponed_rq;
 	struct ide_cmd cmd;
 	u8 stat;
=20
@@ -583,18 +582,6 @@ static ide_startstop_t idetape_do_request(ide_driv=
e_t *drive,
 		goto out;
 	}
=20
-	if (postponed_rq !=3D NULL)
-		if (rq !=3D postponed_rq) {
-			printk(KERN_ERR "ide-tape: ide-tape.c bug - "
-					"Two DSC requests were queued\n");
-			drive->failed_pc =3D NULL;
-			rq->errors =3D 0;
-			ide_complete_rq(drive, 0, blk_rq_bytes(rq));
-			return ide_stopped;
-		}
-
-	tape->postponed_rq =3D NULL;
-
 	/*
 	 * If the tape is still busy, postpone our request and service
 	 * the other device meanwhile.
@@ -612,7 +599,7 @@ static ide_startstop_t idetape_do_request(ide_drive=
_t *drive,
=20
 	if (!(drive->atapi_flags & IDE_AFLAG_IGNORE_DSC) &&
 	    !(stat & ATA_DSC)) {
-		if (postponed_rq =3D=3D NULL) {
+		if (!tape->postponed_rq) {
 			tape->dsc_polling_start =3D jiffies;
 			tape->dsc_poll_freq =3D tape->best_dsc_rw_freq;
 			tape->dsc_timeout =3D jiffies + IDETAPE_DSC_RW_TIMEOUT;
@@ -629,10 +616,12 @@ static ide_startstop_t idetape_do_request(ide_dri=
ve_t *drive,
 					tape->dsc_polling_start +
 					IDETAPE_DSC_MA_THRESHOLD))
 			tape->dsc_poll_freq =3D IDETAPE_DSC_MA_SLOW;
-		idetape_postpone_request(drive);
+		ide_tape_stall_queue(drive);
 		return ide_stopped;
-	} else
+	} else {
 		drive->atapi_flags &=3D ~IDE_AFLAG_IGNORE_DSC;
+		tape->postponed_rq =3D false;
+	}
=20
 	if (rq->cmd[13] & REQ_IDETAPE_READ) {
 		pc =3D &tape->queued_pc;
--=20
1.6.3.3


--=20
Regards/Gruss,
    Boris.
