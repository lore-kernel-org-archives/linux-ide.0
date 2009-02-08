From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 09/15] ide: add "flagged" taskfile flags to struct ide_taskfile
Date: Sun, 8 Feb 2009 12:38:18 +0100
Message-ID: <200902081238.18970.bzolnier@gmail.com>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain> <20090201175012.19144.87417.sendpatchset@localhost.localdomain> <20090206170425.201346e6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:50659 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZBHMgh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Feb 2009 07:36:37 -0500
In-Reply-To: <20090206170425.201346e6.sfr@canb.auug.org.au>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Friday 06 February 2009, Stephen Rothwell wrote:
> Hi Bart,
> 
> On Sun, 01 Feb 2009 18:50:12 +0100 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> >
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: add "flagged" taskfile flags to struct ide_taskfile
> > 
> > * Add ->ftf_flags field to struct ide_taskfile
> >   and convert flags for TASKFILE ioctl to use it.
> > 
> > * Rename "flagged" taskfile flags:
> >   - IDE_TFLAG_FLAGGED -> IDE_FTFLAG_FLAGGED
> 
> There were several places where this transformation did not take place as
> shown by today's linux-next build.

Thanks, it is now fixed with v2 of the patch, interdiff below:

...
v2:
* Remember to fully update ide-h8300.c, scc_pata.c and tx493{8,9}ide.c
  (thanks to Stephen Rothwell for noticing).

There should be no functional changes caused by this patch.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
...
diff -u b/drivers/ide/ide-h8300.c b/drivers/ide/ide-h8300.c
--- b/drivers/ide/ide-h8300.c
+++ b/drivers/ide/ide-h8300.c
@@ -51,7 +51,7 @@
 	struct ide_taskfile *tf = &task->tf;
 	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
 
-	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+	if (task->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
 	if (task->ftf_flags & IDE_FTFLAG_OUT_DATA)
diff -u b/drivers/ide/scc_pata.c b/drivers/ide/scc_pata.c
--- b/drivers/ide/scc_pata.c
+++ b/drivers/ide/scc_pata.c
@@ -672,7 +672,7 @@
 	struct ide_taskfile *tf = &task->tf;
 	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
 
-	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+	if (task->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
 	if (task->ftf_flags & IDE_FTFLAG_OUT_DATA)
diff -u b/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
--- b/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -89,7 +89,7 @@
 	struct ide_taskfile *tf = &task->tf;
 	u8 HIHI = task->tf_flags & IDE_TFLAG_LBA48 ? 0xE0 : 0xEF;
 
-	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+	if (task->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
 	if (task->ftf_flags & IDE_FTFLAG_OUT_DATA) {
diff -u b/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
--- b/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -474,7 +474,7 @@
 	struct ide_taskfile *tf = &task->tf;
 	u8 HIHI = task->tf_flags & IDE_TFLAG_LBA48 ? 0xE0 : 0xEF;
 
-	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+	if (task->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
 	if (task->ftf_flags & IDE_FTFLAG_OUT_DATA) {

