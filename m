From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: hwif->rw_disk() method
Date: Wed, 10 Jan 2007 19:30:35 +0300
Message-ID: <45A514AB.2080605@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:14750 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S964937AbXAJQaf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jan 2007 11:30:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

Hello.

    Alan/Bart/anybody, could you enlighten me why hwif->rw_disk() method came 
into being at all?
    IIUC, hwif->dma_setup() method could have been used instead which is 
called from the ATAPI drivers and the ide-taskfile.c, while hwif->rw_disk() is 
only called from ide-disk.c.  I'm thinking about replacing this hook in 
hpt366.c (the only its user) an getting rid of it altogether...

MBR, Sergei
