From: Aaron Pace <kodiakuppercut@gmail.com>
Subject: eng_timeout ?
Date: Mon, 7 Jun 2010 13:53:59 -0600
Message-ID: <AANLkTinT7ovu4uCaF2K9Te9hko6AowWu8pqZouBK4K8j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49055 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab0FGTyA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2010 15:54:00 -0400
Received: by iwn37 with SMTP id 37so3767136iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 07 Jun 2010 12:54:00 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

ATA/IDE/SCSI is not my forte, however, I've run into what I think may
be a bug in the latest 2.6.32 stable (2.6.32.15 to be precise).   I
took the briefest of looks, and this appears to also exist in
linux-next.

In the definition of ata_port_operations in libata.h are two items
preceded by a comment 'Obsolete'.  These two items are phy_reset and
eng_timeout.
I did a symbol search through the kernel, and the only other place
that eng_timeout is mentioned is when it is called, unchecked in an
error condition in ata_scsi_error.
I hit this and had an OOPS.
Is this a leftover relic of some previous work, or (as is often the
case) am I missing something obvious?

Thanks,
Aaron
