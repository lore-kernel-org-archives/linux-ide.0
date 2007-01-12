From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
 libata-core.c
Date: Fri, 12 Jan 2007 09:48:19 +0900
Message-ID: <200701120045.l0C0jq8T011886@toshiba.co.jp>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
 <200701111008.34866.arnd@arndb.de>
 <200701110928.l0B9SUri015056@toshiba.co.jp>
 <20070111171706.GG6177@austin.ibm.com>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:54579 "EHLO
	inet-tsb5.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbXALAp4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 19:45:56 -0500
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0C0jrm5009455
	for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 09:45:53 +0900 (JST)
Received: (from root@localhost)
	by tsb-wall.toshiba.co.jp  id l0C0jsbD028368
	for linux-ide@vger.kernel.org; Fri, 12 Jan 2007 09:45:54 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0C0jrNI005106
	for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 09:45:53 +0900 (JST)
In-Reply-To: (Your message of "Thu, 11 Jan 2007 11:17:06 -0600")
  <20070111171706.GG6177@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linas@austin.ibm.com, Arnd Bergmann <arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org

Hi, Linas-san, Arnd-san.

>Why is it that other drivers did not need this functions? Did they
>copy them?  Or maybe they don't need them?

As I mentioned in PATCH 1/2, main reason is that this PATA controller
supports only 32bit accesses and that I need to copy all functions
which have low-level access in ata_scc.c.
In these functions, static functions I exported are used.
I thought exporting them was better than copying them.

But other drivers can use functions which have low-level access as it is.
Therefore they don't need to export static functions.

Now, I am trying to implement low-level calls in struct ata_port_operations
to deal with this problem. Please wait a moment.


>-static unsigned int
>+unsigned int
> ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)

I use this in scc_std_softreset(), which is almost same as
ata_std_softreset(). But I cannot use it because ata_devchk() and
ata_bus_softreset() called by it use low-level access.


>-static void ata_pio_sectors(struct ata_queued_cmd *qc)
>+void ata_pio_sectors(struct ata_queued_cmd *qc)
..
>-static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
>+void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
..
>-static void atapi_pio_bytes(struct ata_queued_cmd *qc)
>+void atapi_pio_bytes(struct ata_queued_cmd *qc)

I use them in scc_hsm_move(), which is almost same as ata_hsm_move().
ata_hsm_move() calls ata_hsm_qc_complete() and it calls ata_irq_on().
There is a low-level access in ata_irq_on(), so I cannot use it.


Best regards,
Akira Iguchi
