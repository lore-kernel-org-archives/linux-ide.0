From: Tejun Heo <htejun@gmail.com>
Subject: What's needed for PMP support?
Date: Tue, 13 Nov 2007 10:09:09 +0900
Message-ID: <4738F935.1000708@gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.178]:33251 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbXKMBJV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 20:09:21 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1683060roc
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 17:09:20 -0800 (PST)
In-Reply-To: <4738827D.9060405@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

(cc'd linux-ide and changed subject a bit)

Hello,

Mark Lord wrote:
> Can you spare a minute to udpate me on what is typically needed to get
> a SATA driver to support port multipliers ?

Sure thing.

> And which LLDs currently have it already?
> I have a sata_sil24 driven ExpressCard (for notebook) here that I may
> try out..

Currently only two driver support PMP.  One is sata_sil24 and the other
is ahci.  sata_sil24 supports FIS-based switching while ahci only
supports command based switching.

The following things are needed for a LLD to support PMP.

1. PMP aware reset sequence.  The controller must issue hardreset first,
followed by softreset with PMP==15.  The first part is automatically
done if the LLD tells libata that you support PMP by setting ATA_FLAG_PMP.

2. Reset methods for downstream ports.  A LLD needs prereset, hardreset,
softreset and postreset for downstream ports.  sata_pmp_std_prereset(),
sata_pmp_std_hardreset() and sata_pmp_std_postreset() can be used
without any modification unless the controller is really weird.  The
only thing a LLD has to implement is pmp_softreset method which does the
same SRST protocol as regular softreset but with SRST set to link->pmp.

3. An error handler to combine all methods from #1 and #2.  The error
handler should call sata_pmp_do_eh() with methods from #1 and #2.

4. PMP aware command issue.  qc_prep and qc_issue should be modified
such that when it issues commands via H2D Reg FIS, it sets the PMP field
according to qc->dev->link->pmp.

5. qc_defer method.  Use sata_pmp_qc_defer_cmd_switch() if it's command
based switching.  ata_std_qc_defer() can be used if the controller is
FIS based switching without any further restriction.

6. PMP aware irq / error handling.  The irq handler should be able to
handle completions for different ports.  There doesn't need to be much
change for command switching.  Error triggering / handling needs to be
updated too.  Again, cmd-based switching won't need too much change.
One thing to note is to attribute errors to the correct link (e.g. link
errors detected by host should be recorded to ehi of the upstream link
while any error condition triggered by the device should probably be
attributed to downstream link.)

I think that's about it.  Feel free to ask if something isn't clear.

Thanks.

-- 
tejun
