From: Matthieu CASTET <matthieu.castet@sagem.com>
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_[PATCH_01=2F12]_libata=3A_add_msec=5Fto=5F?=
 =?ISO-8859-1?Q?jiffies=28=29?=
Date: Mon, 17 Jul 2006 14:39:12 +0200
Message-ID: <OF816710D5.C86216D1-ONC12571AE.00456F29-C12571AE.00458245@sagem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.sagem.com ([62.160.59.241]:1421 "EHLO mx2.sagem.com")
	by vger.kernel.org with ESMTP id S1750764AbWGQMjS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jul 2006 08:39:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, htejun@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-ide-owner@vger.kernel.org, lkml@rtr.ca

> Add msec_to_jiffies() to drivers/scsi/libata.h and use it in
> ata_wait_register().

Why aren't you using the one from jiffies.h ?
