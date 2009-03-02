From: Roel Kluin <roel.kluin@gmail.com>
Subject: ide_timer_expiry() - shouldn't 'wait' be int?
Date: Mon, 02 Mar 2009 15:18:40 +0100
Message-ID: <49ABEAC0.40407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:62264 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbZCBOSo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2009 09:18:44 -0500
Received: by fxm24 with SMTP id 24so1996538fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2009 06:18:41 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

vi drivers/ide/ide-io.c +906 and note:

void ide_timer_expiry (unsigned long data)
{
	ide_expiry_t *expiry = hwif->expiry;
	...
	unsigned long   wait = -1;
		...
		if (expiry) {
			...
			wait = expiry(drive);
			if (wait > 0) { /* continue */

also note that in include/linux/ide.h:883:

typedef int (ide_expiry_t)(ide_drive_t *);

doesn't this mean that expiry returns int, and wait therefore should
be int as well?

Roel
