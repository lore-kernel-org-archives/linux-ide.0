From: Jiri Slaby <jirislaby@gmail.com>
Subject: OOPS: deref 0x14 at pdc_port_start+0x82 [Was: 2.6.20-rc1-mm1]
Date: Fri, 15 Dec 2006 15:45:55 +0059
Message-ID: <4582B53A.8010809@gmail.com>
References: <20061214225913.3338f677.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:12604 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbWLOOqa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Dec 2006 09:46:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so829441uga
        for <linux-ide@vger.kernel.org>; Fri, 15 Dec 2006 06:46:29 -0800 (PST)
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Andrew Morton wrote:
> Temporarily at
> 
> 	http://userweb.kernel.org/~akpm/2.6.20-rc1-mm1/
> 
> Will appear later at
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/

The kernel panics at boot in pdc_port_start+0x82 with deref of 0x14:
http://www.fi.muni.cz/~xslaby/sklad/pdc_oops.png

ATA port is not connected, only 2 SATA disks on my
# lspci -vvxs 02:01.0
02:01.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300
TX2plus) (rev 02)
        Subsystem: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (1000ns min, 4500ns max), Cache Line Size: 4 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at 8000 [size=128]
        Region 2: I/O ports at 8400 [size=256]
        Region 3: Memory at fb025000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fb000000 (32-bit, non-prefetchable) [size=128K]
        [virtual] Expansion ROM at 50000000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 73 3d 07 00 30 02 02 00 80 01 01 48 00 00
10: 01 80 00 00 00 00 00 00 01 84 00 00 00 50 02 fb
20: 00 00 00 fb 00 00 00 00 00 00 00 00 5a 10 73 3d
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 04 12

2.6.19-rc6-mm2 is OK (2.6.19-mm1 untested and won't be)

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
