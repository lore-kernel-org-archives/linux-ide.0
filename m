From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: sata_promise.c missing .error_handler in port ops?
Date: Mon, 30 Oct 2006 01:23:29 -0500
Message-ID: <76366b180610292223j562ffb36n8e7df0f8ea0eaf66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:56296 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161134AbWJ3GXb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Oct 2006 01:23:31 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1059345ugm
        for <linux-ide@vger.kernel.org>; Sun, 29 Oct 2006 22:23:30 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Does anyone (Jeff?) know why sata_promise does not hook up a new-style
.error_handler to the port operations? Without this, errors fall back
to ATA-style error detection and don't seem correct. I hooked up a
handler in my kernel which just does this:

static void pdc_error_handler(struct ata_port *ap)
{
        ata_reset_fn_t hardreset = NULL;

        if (sata_scr_valid(ap))
                hardreset = sata_std_hardreset;

        ata_do_eh(ap, ata_std_prereset, ata_std_softreset,
                  hardreset, ata_std_postreset);
}

.. It seems to output proper error information after doing this:

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete

A few questions remain:

- Is there anything special going on with the existing
pdc_eng_timeout() handler?

- Does the underlying libata-eh code handle timeout cases properly by
default? (I poked around in the code but couldn't tell for sure)

- Should I just submit a patch with this change?

Thanks -Andrew
