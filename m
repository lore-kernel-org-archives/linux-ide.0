From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: Bug 11581
Date: Mon, 10 Nov 2008 07:34:43 +0100
Message-ID: <20081110063443.GA17946@gollum.tnic>
References: <Pine.LNX.4.64.0810141314590.2555@cantor.unex.es> <9ea470500810140453m6e1f7eb6raf179ee78414e19e@mail.gmail.com> <Pine.LNX.4.64.0810141709450.4529@cantor.unex.es> <20081026154657.GA2578@gollum.tnic> <Pine.LNX.4.64.0810281202010.24944@cantor.unex.es>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:60638 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbYKJGex (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Nov 2008 01:34:53 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2155284fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 09 Nov 2008 22:34:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0810281202010.24944@cantor.unex.es>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Santiago Vila <sanvila@unex.es>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

On Tue, Oct 28, 2008 at 12:04:19PM +0100, Santiago Vila wrote:

[.. ]

> [    4.756000] ide-cd: Call ide_do_rw_cdrom, rq->cmd[0]: 0x46, rq->flags: 0x2988, block: 0
> [    4.756000] BLOCK PC:
> [    4.756000] Original rq: : dev hdc: flags = REQ_SOFTBARRIER REQ_NOMERGE REQ_STARTED REQ_ELVPRIV REQ_BLOCK_PC 
> [    4.756000] sector 0, nr/cnr 0/0
> [    4.756000] bio cffc2480, biotail cffc2480, buffer 00000000, data 00000000, len 8
> [    4.756000] cdb: 46 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 
> [    4.756000] rq->cmd_len: 10
> [    4.756000] GET_CONFIGURATION cmd!
> [    4.756000]  [<d086d89b>] ide_do_rw_cdrom+0x4cd/0x5b7 [ide_cd]
> [    4.756000]  [<c01be540>] __delay+0x6/0x7
> [    4.756000]  [<d08460a0>] ide_wait_stat+0xbc/0xf5 [ide_core]
> [    4.760000]  [<d0844668>] ide_do_request+0x554/0x711 [ide_core]
> [    4.760000]  [<d08440e3>] ide_end_request+0xc7/0xcf [ide_core]
> [    4.760000]  [<d086e100>] cdrom_newpc_intr+0x27c/0x2d4 [ide_cd]
> [    4.760000]  [<d086e20c>] cdrom_pc_intr+0xb4/0x1ef [ide_cd]
> [    4.760000]  [<d0844a8f>] ide_intr+0x167/0x190 [ide_core]
> [    4.760000]  [<c013f81b>] handle_IRQ_event+0x23/0x49
> [    4.760000]  [<c013f8d4>] __do_IRQ+0x93/0xe8
> [    4.760000]  [<c010512d>] do_IRQ+0x43/0x52
> [    4.760000]  [<c01036fe>] common_interrupt+0x1a/0x20
> [    4.760000]  [<d081935f>] acpi_safe_halt+0x14/0x20 [processor]
> [    4.760000]  [<d081951f>] acpi_processor_idle+0x15f/0x380 [processor]
> [    4.760000]  [<c0101b4d>] cpu_idle+0x9f/0xb9
> [    4.760000]  [<c0305707>] start_kernel+0x383/0x38a
> [    4.760000] ide-cd: Call cdrom_do_block_pc, rq->cmd[0]: 0x46, rq->flags: 0x2988, rq->bio: cffc2480
> [    4.760000] ide-cd: Turning off dma for cmd 0x46,rq->data_len: 0x8, addr: 0xcf67d000mask: 0x1f
> [    4.760000] ide-cd: Call cdrom_start_packet_command: xferlen: 8
> [    4.760000] ide-cd: Call cdrom_transfer_packet_command, rq->cmd[0]: 0x46
> [    4.760000] ide-cd: Call cdrom_decode_status, stat: 0x59, good_stat: 0x0, rq->cmd[0]: 0x46,rq->flags: 0x12988, err: 0x20
> [    4.760000] ide-cd: Call cdrom_queue_request_sense
> [    4.760000] ide-cd: cdrom_queue_request_sense: failed_cmd: 0x46
> [    4.760000] ide-cd: Call ide_do_rw_cdrom, rq->cmd[0]: 0x43, rq->flags: 0x11108, block: 0
> [    4.760000] ide-cd: Call cdrom_start_packet_command: xferlen: 4
> [    4.760000] ide-cd: Call cdrom_transfer_packet_command, rq->cmd[0]: 0x43
> [    4.764000] ide-cd: Call cdrom_decode_status, stat: 0x51, good_stat: 0x0, rq->cmd[0]: 0x43,rq->flags: 0x11108, err: 0x20
> [    4.764000] ide-cd: Call cdrom_queue_request_sense
> [    4.764000] ide-cd: cdrom_queue_request_sense: failed_cmd: 0x43
> [    4.764000] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }

Ok, so it looks like your drive gets puzzled again by a
GET_CONFIGURATION command despite 2.6.18 which used to work, as you say.
But I think it fails this time because you've updated to debian testing
and, correct me if I'm wrong, but the udev utility cdrom_id came with
the update and it sends all those GET_CONFIGURATION commands. Have you
thought of updating the drive's firmware - that helps sometimes?

-- 
Regards/Gruss,
    Boris.
