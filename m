From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA DVD drive problem on ICH8M
Date: Fri, 21 Nov 2008 17:37:30 +0900
Message-ID: <4926734A.5050707@kernel.org>
References: <291f35090811140246y674de2b1p23a9a650f8c7ef3a@mail.gmail.com>	 <491FE21C.7020904@kernel.org> <291f35090811170047w7cade8aci2676a878168835df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52707 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbYKUIhf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Nov 2008 03:37:35 -0500
In-Reply-To: <291f35090811170047w7cade8aci2676a878168835df@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maxim Gorbachyov <maxim.gorbachyov@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

Sorry about the delay.

Maxim Gorbachyov wrote:
> On Sun, Nov 16, 2008 at 12:04 PM, Tejun Heo <tj@kernel.org> wrote:
> 
>>> I have a problem with SATA DVD drive and ICH8M on ASUS F80L. I insert
>>> a disk, try mounting it, mount fails. Then the drive gets lost, and I
>>> can't even eject the tray until power cycle. Kernel is vanilla
>>> 2.6.27.6. See dmesg, lspci, lshw output and kernel config attached.
>>> Let me know if more info is needed.
>> Looks like your drive doesn't like hald polling for media presence.
>> Does hal-disable-polling /dev/sr0 help?
> 
> It doesn't. The thing changed is I get this:
> 
> [145864.448091] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [145864.448103] ata2.00: cmd a0/01:00:00:00:08/00:00:00:00:00/a0 tag 0
> dma 2048 in
> [145864.448104]          cdb 28 00 00 00 00 11 00 00  01 00 00 00 00 00 00 00
> [145864.448106]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask
> 0x4 (timeout)
> [145864.448109] ata2.00: status: { DRDY }
> [145864.448116] ata2: hard resetting link
> [145869.808081] ata2: link is slow to respond, please be patient (ready=0)
> [145874.468074] ata2: COMRESET failed (errno=-16)
> [145874.468084] ata2: hard resetting link
> [145879.828096] ata2: link is slow to respond, please be patient (ready=0)
> [145884.476079] ata2: COMRESET failed (errno=-16)
> [145884.476090] ata2: hard resetting link
> [145889.836093] ata2: link is slow to respond, please be patient (ready=0)
> [145919.516093] ata2: COMRESET failed (errno=-16)
> [145919.516103] ata2: limiting SATA link speed to 1.5 Gbps
> [145919.516106] ata2: hard resetting link
> [145924.540080] ata2: COMRESET failed (errno=-16)
> [145924.540089] ata2: reset failed, giving up
> [145924.540092] ata2.00: disabled
> [145924.540107] ata2: EH complete
> [145924.540148] sr 1:0:0:0: [sr0] Result: hostbyte=DID_BAD_TARGET
> driverbyte=DRIVER_OK,SUGGEST_OK
> [145924.540153] end_request: I/O error, dev sr0, sector 68
> [145924.540181] UDF-fs: No VRS found
> 
> after mount attempt (not right after disk is inserted).

Ehhh... I really don't have much idea at this point.  Does
"libata.force=udma4" make any difference?  If not, how about
"libata.force=pio4"?  Note that depending on your distro, you need to do
different things to pass parameters to modules loaded from initrd.  If
ahci is built into the kernel, simple libata.force=xxx on kernel boot
prompt will do.

Does the drive work in other environments (ie. windows)?

-- 
tejun
