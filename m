From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] Re: SATA ATAPI work in progress
Date: 15 May 2004 07:10:26 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084626626.3079.13.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455  
	9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.534
	 3.	26.camel@patibmrh9> <1084579362.3271.5.camel@patibmrh9><40A56869.203060
	8@pobox.com>  <1084626505.3079.11.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:19687 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262438AbUEONKt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 09:10:49 -0400
In-Reply-To: <1084626505.3079.11.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Ouch we're sync'ed enough, but not wholly:

$ <~/patch.6 patch -p1
patching file drivers/scsi/libata-core.c
patching file drivers/scsi/libata-scsi.c
patching file include/linux/ata.h
patching file include/linux/libata.h
$
$ <~/patch.7 patch -p1
patching file drivers/scsi/libata-core.c
Hunk #1 succeeded at 2670 (offset 3 lines).
$

Pat LaVarre


