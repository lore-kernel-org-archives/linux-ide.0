From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] honor IDE drive write cache settings
Date: Tue, 19 Oct 2004 19:15:27 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101910153f179edc@mail.gmail.com>
References: <200410191615.i9JGFEXI010445@falcon10.austin.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.205]:33334 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269905AbUJSRP1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Oct 2004 13:15:27 -0400
Received: by mproxy.gmail.com with SMTP id 79so319506rnk
        for <linux-ide@vger.kernel.org>; Tue, 19 Oct 2004 10:15:27 -0700 (PDT)
In-Reply-To: <200410191615.i9JGFEXI010445@falcon10.austin.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>, dwm@maxeymade.com

Hi Doug,

On Tue, 19 Oct 2004 11:15:14 -0500, Doug Maxey <dwm@austin.ibm.com> wrote:
> 
> Bart,
> 
> here is a patch that handles drives that come with write cache disabled,
> both as modular and builtin drivers.

This patch seems to be trying to do too much in one go and we've learned
(by experience :) that write cache related changes should be done in small
steps.  Please split your patch to:

* HDIO_DRIVE_CMD fix
* honor disk write cache fix
* "barrier" fix (this one needs some more thinking)

Do you care to also make "disable write cache by default" patch?

+static inline sector_t idedisk_capacity (ide_drive_t *drive) {
+	return drive->capacity64 - drive->sect0;
+}
+
+static inline int ide_drive_has_flush_cache (ide_drive_t *drive) {
+	return ((drive->addressing && (idedisk_capacity (drive) > (1ULL << 28)) &&
+		    (ide_id_has_flush_cache_ext(drive->id))) ||
+		(ide_id_has_flush_cache(drive->id)));
+}

please fix it to be more readable
(see Documentation/CodingStyle)

foo()
{
}

+	 * If we have a drive that does not support write cache, do not
+	 * attempt to change the write cache setting.
+	 */
+
+	if (!(drive->id->command_set_1 & (1 << 5)))
+		return -EIO;	/* Would prefer ENXIO for command not supported... */

Is this enough?  IMO it is the best to leave it alone for now...

+	if ((args[2] == SETFEATURES_EN_WCACHE) ||
+	    (args[2] == SETFEATURES_DIS_WCACHE)) {
+		/*
+		 * Call the handler to support settings in the block layer.
+		 */
+		err = ide_write_cache (drive, (args[2] == SETFEATURES_EN_WCACHE));
+		return err;
+	}

This check is only valid for XFER_SETFEATURES command...

The rest of the patch looks OK.

Oh, and please inline patches instead of attaching them.

Thanks,
Bartlomiej
