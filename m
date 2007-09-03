From: "Maurizio Monge" <maurizio.monge@gmail.com>
Subject: HSM violation with ahci+WDC WD1600BEVS-22RST0
Date: Mon, 3 Sep 2007 04:06:33 +0200
Message-ID: <e4c519350709021906x5a17c5demff2b2cc4bf1097f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:5805 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbXICCGf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 22:06:35 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1244981fkz
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 19:06:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, i'm getting this error in dmesg from time to time, i'm sending it
here because i don't know any better list for doing so.
Please let me know if i can run any test (or provide additional
infomation) to help fixing this!
Thanks.

ata1.00: exception Emask 0x2 SAct 0x33 SErr 0x0 action 0x2 frozen
ata1.00: spurious completions during NCQ issue=0x0 SAct=0x33
FIS=004040a1:00000008
ata1.00: cmd 60/08:00:78:89:b7/00:00:0f:00:00/40 tag 0 cdb 0x0 data 4096 in
         res 40/00:24:5f:d4:8b/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
ata1.00: cmd 60/08:08:6f:d2:8b/00:00:0a:00:00/40 tag 1 cdb 0x0 data 4096 in
         res 40/00:24:5f:d4:8b/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
ata1.00: cmd 60/08:20:5f:d4:8b/00:00:0a:00:00/40 tag 4 cdb 0x0 data 4096 in
         res 40/00:24:5f:d4:8b/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
ata1.00: cmd 60/08:28:5f:d2:8b/00:00:0a:00:00/40 tag 5 cdb 0x0 data 4096 in
         res 40/00:24:5f:d4:8b/00:00:0a:00:00/40 Emask 0x2 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA


-- 
Ciao
Maurizio
http://stregatto.wordpress.com

"Well we all shine on
Like the moon and the stars and the sun" (John Lennon)
