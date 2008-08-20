From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: 2.6.27-rc3: IP: [<ffffffffa0038b77>] init_irq+0x18d/0x31c [ide_core]
Date: Wed, 20 Aug 2008 14:34:47 -0500
Message-ID: <48AC71D7.8050604@lwfinger.net>
References: <20080820173122.GA7335@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:34280 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753270AbYHTTeq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Aug 2008 15:34:46 -0400
In-Reply-To: <20080820173122.GA7335@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org

Martin Michlmayr wrote:
> I get the following with 2.6.27-rc3 when inserting a CF card into my
> PCMCIA slot:
> 
> [  144.983810] pccard: PCMCIA card inserted into slot 0
> [  144.983942] cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xe0000-0xfffff
> [  144.989008] cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
> [  144.989008] cs: memory probe 0xa0000000-0xa0ffffff: clean.
> [  145.008898] cs: memory probe 0xe0100000-0xe03fffff: excluding 0xe0100000-0xe012ffff
> [  145.021508] pcmcia: registering new device pcmcia0.0
> [  145.284012] Probing IDE interface ide1...
> [  145.576063] hdc: TOSHIBA THNCF512MMA, CFA DISK drive
> [  146.248065] BUG: unable to handle kernel NULL pointer dereference at 00000000000000f8
> [  146.248065] IP: [<ffffffffa0038b77>] init_irq+0x18d/0x31c [ide_core]

Please do the following, which will require the package containing 
objdump. First of all, do the command

objdump -d -l drivers/ide/ide-core.o > ide_core.dump

Next, open ide_core.dump with less or your favorite editor and search 
for the start of init_irq. Note that address. Add your offset of 0x18D 
to that value and find the instruction at that address. Move up in the 
file until you find a line that looks like

/home/finger/linux-2.6/drivers/ide/ide-probe.c:1054

That will be the source line that oopsed. Post that information.

Thanks,

Larry


Once this is open, search
