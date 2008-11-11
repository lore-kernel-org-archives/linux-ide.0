From: Tejun Heo <htejun@gmail.com>
Subject: Re: Promise Card Issue
Date: Tue, 11 Nov 2008 11:25:15 +0900
Message-ID: <4918ED0B.5020808@gmail.com>
References: <5e62adb50811090353p6c36df9cn800e94e22bb0a873@mail.gmail.com>	 <491797A6.6050404@gmail.com> <5e62adb50811100841v3a9d0d9cr154206a444debed6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:23377 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbYKKCZW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Nov 2008 21:25:22 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1716585tic.23
        for <linux-ide@vger.kernel.org>; Mon, 10 Nov 2008 18:25:20 -0800 (PST)
In-Reply-To: <5e62adb50811100841v3a9d0d9cr154206a444debed6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: -X- <4bove.and.beyond@gmail.com>
Cc: linux-ide@vger.kernel.org

-X- wrote:
> Thanks for your reply.
> I just added the adress you gave me to the cc.
> Last night it happened again to the same disk on the same port. So just
> a few hours ago when i got home from work I put in a different 500g
> drive. The raid is rebuilding as we speak.
> So in 6-7 hours from now I can start testing/using it and see if it
> remains stable.
> The plan from there:
> If in that case this other 500g harddisk fails too, then I know its the
> card (or the driver in the current kernel).
> I guess then the cheapest solution would be to upgrade to 8.10 and hope
> that the bug will be gone in the new kernel. If its not, then I will
> have to go with a "el cheapo" sata controller card to have a 4th disk
> located on a different controller.
> As I see it this is a througput problem with the card not being able to
> keep up on normal PCI speed?

I don't think it has anything to do with throughput.

> I will keep you updated.
> 
> Btw here is the full kernel log:
> 
> Nov  8 19:51:31 xpc kernel: [540485.041242] ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x180000 action 0xa frozen
> Nov  8 19:51:31 xpc kernel: [540485.041248] ata2.00: hotplug_status 0x2
> Nov  8 19:51:31 xpc kernel: [540485.041250] ata2: SError: { 10B8B Dispar }

Host side detected inconsistencies on ATA bus.

> Nov  8 19:51:31 xpc kernel: [540485.041255] ata2.00: cmd
> c8/00:08:cf:55:e1/00:00:00:00:00/e5 tag 0 dma 4096 in
> Nov  8 19:51:31 xpc kernel: [540485.041256]          res
> ff/ff:ff:ff:ff:ff/00:00:00:00:00/ff Emask 0x12 (ATA bus error)
> Nov  8 19:51:31 xpc kernel: [540485.041258] ata2.00: status: { Busy }
> Nov  8 19:51:31 xpc kernel: [540485.041259] ata2.00: error: { ICRC UNC
> IDNF ABRT }

The drive aborted the command with all f's.  I don't know whether
that's what the drive actually transmitted or something the controller
came up with on receiving malformed D2H Reg FIS for command
completion.  The latter is more likely.

> Nov  8 19:51:37 xpc kernel: [540491.106403] ata2: port is slow to respond, please be patient (Status 0xff)
> Nov  8 19:51:41 xpc kernel: [540495.077085] ata2: device not ready (errno=-16), forcing hardreset
> Nov  8 19:51:41 xpc kernel: [540495.077090] ata2: hard resetting link
> Nov  8 19:51:48 xpc kernel: [540501.677451] ata2: port is slow to respond, please be patient (Status 0xff)
> Nov  8 19:51:51 xpc kernel: [540505.088601] ata2: COMRESET failed (errno=-16)
> Nov  8 19:51:51 xpc kernel: [540505.088605] ata2: hard resetting link
> Nov  8 19:51:58 xpc kernel: [540511.674660] ata2: port is slow to respond, please be patient (Status 0xff)
> Nov  8 19:52:01 xpc kernel: [540515.084525] ata2: COMRESET failed (errno=-16)
> Nov  8 19:52:01 xpc kernel: [540515.084531] ata2: hard resetting link
> Nov  8 19:52:08 xpc kernel: [540521.670044] ata2: port is slow to respond, please be patient (Status 0xff)
> Nov  8 19:52:36 xpc kernel: [540550.049959] ata2: COMRESET failed (errno=-16)
> Nov  8 19:52:36 xpc kernel: [540550.049966] ata2: limiting SATA link speed to 1.5 Gbps
> Nov  8 19:52:36 xpc kernel: [540550.049968] ata2: hard resetting link
> Nov  8 19:52:41 xpc kernel: [540555.065889] ata2: COMRESET failed (errno=-16)
> Nov  8 19:52:41 xpc kernel: [540555.065895] ata2: reset failed, giving up
> Nov  8 19:52:41 xpc kernel: [540555.065898] ata2.00: disabled

Then the controller fails to recover the device.  This is a bug which
is fixed recently.

Transmission problems on ATA bus are not too uncommon on certain
configurations.  It could be power problem, the drive just doesn't
like the way the controller is talking (there are a few compatibility
problems on 3Gbps depending on the combination).  As long as they
don't occur often and are recovered properly, it's not nice but should
be okay.

-- 
tejun
