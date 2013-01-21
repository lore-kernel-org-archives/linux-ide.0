From: xiangliang yu <yxlraid@gmail.com>
Subject: Libahci kernel panic in interrupt context when enable FBS feature
Date: Mon, 21 Jan 2013 15:45:17 +0800
Message-ID: <CAP0P+NWTxGO2kvANSVw4dGLt2jS1=sguQzxuvdvVjDrRKzQ4Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:41954 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab3AUHpS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2013 02:45:18 -0500
Received: by mail-bk0-f47.google.com with SMTP id j4so2837739bkw.6
        for <linux-ide@vger.kernel.org>; Sun, 20 Jan 2013 23:45:17 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi, Jgarzik

When enable FBS feature, ahci_port_intr function will kernel panic if
have PORT_IRQ_ERROR error. I can't capture the log, but the code patch
is very clear:

            ata_exec_internal  [ the function might sleep ]
             sata_pmp_read
             sata_pmp_scr_read
             sata_scr_read
             ata_phys_link_online
             ata_link_online
             ahci_error_intr
             ahci_port_intr

Now, i can't find the best method to fix the issue, so, please help
fix the issue. Thanks!
