From: Martin Michlmayr <tbm@cyrius.com>
Subject: ide-cs: Trying to free nonexistent resource... with 2.6.26+
Date: Tue, 26 Aug 2008 11:28:55 +0300
Message-ID: <20080826082855.GD2607@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:2829 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbYHZI3Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 04:29:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org

With 2.6.26 and current git I'm getting "Trying to free nonexistent
resource" messages when I remove my CF card from my PCMCIA slot:

[   96.007976] pccard: PCMCIA card inserted into slot 0
[   96.007993] cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xe0000-0xfffff
[   96.015904] cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
[   96.015904] cs: memory probe 0xa0000000-0xa0ffffff: clean.
[   96.031903] cs: memory probe 0xe0100000-0xe03fffff: excluding 0xe0100000-0xe012ffff
[   96.045818] pcmcia: registering new device pcmcia0.0
[   96.247039] Probing IDE interface ide1...
[   96.539870] hdc: TOSHIBA THNCF512MMA, CFA DISK drive
[   97.212024] ide1 at 0x3100-0x3107,0x310e on irq 18
[   97.212160] hdc: max request size: 128KiB
[   97.212172] hdc: 1000944 sectors (512 MB) w/2KiB Cache, CHS=993/16/63
[   97.212242]  hdc: hdc1
[   97.217062] ide-cs: hdc: Vpp = 0.0
[  100.992866] pccard: card ejected from slot 0
[  100.992866] Trying to free nonexistent resource <000000000000310e-000000000000310e>
[  100.992866] Trying to free nonexistent resource <0000000000003100-0000000000003107>

I didn't get this with 2.6.25:

[   82.884543] pccard: PCMCIA card inserted into slot 0
[   82.884559] cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xe0000-0xfffff
[   82.894865] cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
[   82.894906] cs: memory probe 0x88000000-0x8bffffff: excluding 0x88000000-0x8bffffff
[   82.894949] cs: memory probe 0xa0000000-0xa0ffffff: clean.
[   82.909177] cs: memory probe 0xe0100000-0xe03fffff: excluding 0xe0100000-0xe012ffff
[   82.922905] pcmcia: registering new device pcmcia0.0
[   83.003658] Probing IDE interface ide1...
[   83.427096] hdc: TOSHIBA THNCF512MMA, CFA DISK drive
[   84.099621] ide1 at 0x3100-0x3107,0x310e on irq 18
[   84.099748] hdc: max request size: 128KiB
[   84.099758] hdc: 1000944 sectors (512 MB) w/2KiB Cache, CHS=993/16/63
[   84.099825]  hdc: hdc1
[   84.108317] ide-cs: hdc: Vpp = 0.0
[   88.847258] pccard: card ejected from slot 0

(Note that "memory probe" differs between 2.6.25 and 2.6.26)
-- 
Martin Michlmayr
http://www.cyrius.com/
