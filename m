From: Ingo Molnar <mingo@elte.hu>
Subject: Re: convert some IDE semaphores to mutexes
Date: Thu, 12 Jan 2006 23:48:58 +0100
Message-ID: <20060112224858.GB8237@elte.hu>
References: <1136973401.2929.27.camel@laptopd505.fenrus.org> <58cb370e0601110315y7623e019t33d0569b0d8b5fc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:14053 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161384AbWALWsp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jan 2006 17:48:45 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e0601110315y7623e019t33d0569b0d8b5fc6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org


* Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On 1/11/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > IDE uses some semaphores only in a mutex way; use the new
> > mutexes for this
> >
> > Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Could you also convert drivers/scsi/ide-scsi.c and add it to the patch?

yeah - we've got that patch in our conversion patch-queue:

-----
From: Arjan van de Ven <arjan@infradead.org>

 drivers/scsi/ide-scsi.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

Index: linux/drivers/scsi/ide-scsi.c
===================================================================
--- linux.orig/drivers/scsi/ide-scsi.c
+++ linux/drivers/scsi/ide-scsi.c
@@ -47,6 +47,7 @@
 #include <linux/ide.h>
 #include <linux/scatterlist.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -109,7 +110,7 @@ typedef struct ide_scsi_obj {
 	unsigned long log;			/* log flags */
 } idescsi_scsi_t;
 
-static DECLARE_MUTEX(idescsi_ref_sem);
+static DEFINE_MUTEX(idescsi_ref_mutex);
 
 #define ide_scsi_g(disk) \
 	container_of((disk)->private_data, struct ide_scsi_obj, driver)
@@ -118,19 +119,19 @@ static struct ide_scsi_obj *ide_scsi_get
 {
 	struct ide_scsi_obj *scsi = NULL;
 
-	down(&idescsi_ref_sem);
+	mutex_lock(&idescsi_ref_mutex);
 	scsi = ide_scsi_g(disk);
 	if (scsi)
 		scsi_host_get(scsi->host);
-	up(&idescsi_ref_sem);
+	mutex_unlock(&idescsi_ref_mutex);
 	return scsi;
 }
 
 static void ide_scsi_put(struct ide_scsi_obj *scsi)
 {
-	down(&idescsi_ref_sem);
+	mutex_lock(&idescsi_ref_mutex);
 	scsi_host_put(scsi->host);
-	up(&idescsi_ref_sem);
+	mutex_unlock(&idescsi_ref_mutex);
 }
 
 static inline idescsi_scsi_t *scsihost_to_idescsi(struct Scsi_Host *host)
