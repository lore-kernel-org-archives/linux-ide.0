From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Sil3124: IRQ loss errata on PCI-X
Date: Mon, 13 Aug 2007 13:53:21 -0600
Message-ID: <8202f4270708131253o506ec8ffqb97ee9d6e6557816@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:39379 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763662AbXHMTxW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Aug 2007 15:53:22 -0400
Received: by nf-out-0910.google.com with SMTP id g13so570754nfb
        for <linux-ide@vger.kernel.org>; Mon, 13 Aug 2007 12:53:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi,

In sata_sil24.c, there's a special flag as shown below:
	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
Could someone explain the error condition and the rational behind the fix?

Thanks,
Fajun
