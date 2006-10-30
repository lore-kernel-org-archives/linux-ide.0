From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: sata_promise TX2/TX4 cards rejecting smart auto-offline & auto-save ata cmds?
Date: Mon, 30 Oct 2006 01:50:19 -0500
Message-ID: <76366b180610292250n400fff81s76a2a9cd84d61366@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:27694 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161148AbWJ3GuU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Oct 2006 01:50:20 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1061513ugm
        for <linux-ide@vger.kernel.org>; Sun, 29 Oct 2006 22:50:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'd like to know if anyone else with a Promise SATA300 TX2/TX4 using
sata_promise is seeing problems with sending ATA cmds to
enable/disable smart auto-offline mode and/or attribute auto-saving.
(smartctl -o on -S on ...)

According to smartctl, my drives support both of these features, but
when the corresponding smart cmds are sent via the driver, the card
returns an error indicating illegal commands:

smartctl -a -d ata /dev/sda
...
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                        Auto Offline data collection
on/off support.
...
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
...

When smartd actually sends these ata cmds to the driver (with my
patched kernel to output smart error codes):

auto-offline cmd (which is obsolete in atapi-7)

ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
ata4.00: smart cmd 0xdb (obsolete or reserved feature)

auto-save cmd

ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
ata4.00: smart cmd 0xd2 (enable/disable attribute autosave)

Are these cards failing to pass through these specific cmds? These two
are the only ones which seem to show up in dmesg while using
smartctl/smartd.

Thanks -Andrew
