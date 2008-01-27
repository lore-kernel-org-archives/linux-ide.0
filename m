From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/32] ide-tape: move historical changelog to Documentation/ide/ChangeLog.ide-tape.1995-2002
Date: Sun, 27 Jan 2008 16:18:29 +0100
Message-ID: <200801271618.29999.bzolnier@gmail.com>
References: <1201423312-2460-1-git-send-email-bbpetkov@yahoo.de> <1201423312-2460-2-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:32949 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbYA0TcL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:11 -0500
Received: by fk-out-0910.google.com with SMTP id z23so893136fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:09 -0800 (PST)
In-Reply-To: <1201423312-2460-2-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 27 January 2008, Borislav Petkov wrote:
> Also, cleanup whitespace and update comments.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied with some changes

> ---
>  Documentation/ide/ChangeLog.ide-tape.1995-2002 |  405 +++++++++++++++++++++++
>  drivers/ide/ide-tape.c                         |  414 +-----------------------
>  2 files changed, 409 insertions(+), 410 deletions(-)
> 
> diff --git a/Documentation/ide/ChangeLog.ide-tape.1995-2002 b/Documentation/ide/ChangeLog.ide-tape.1995-2002
> new file mode 100644
> index 0000000..e406762
> --- /dev/null
> +++ b/Documentation/ide/ChangeLog.ide-tape.1995-2002
> @@ -0,0 +1,405 @@
> +/*
> + * IDE ATAPI streaming tape driver.
> + *
> + * This driver is a part of the Linux ide driver and works in co-operation
> + * with drivers/block/ide.c.

I removed incorrect reference to drivers/block/ide.c

> + * The driver, in co-operation with ide.c, basically traverses the
> + * request-list for the block device interface. The character device
> + * interface, on the other hand, creates new requests, adds them
> + * to the request-list of the block device, and waits for their completion.
> + *
> + * Pipelined operation mode is now supported on both reads and writes.
> + *
> + * The block device major and minor numbers are determined from the
> + * tape's relative position in the ide interfaces, as explained in ide.c.
> + *
> + * The character device interface consists of the following devices:
> + *
> + * ht0		major 37, minor 0	first  IDE tape, rewind on close.
> + * ht1		major 37, minor 1	second IDE tape, rewind on close.
> + * ...
> + * nht0		major 37, minor 128	first  IDE tape, no rewind on close.
> + * nht1		major 37, minor 129	second IDE tape, no rewind on close.
> + * ...
> + *
> + * The general magnetic tape commands compatible interface, as defined by
> + * include/linux/mtio.h, is accessible through the character device.
> + *
> + * General ide driver configuration options, such as the interrupt-unmask
> + * flag, can be configured by issuing an ioctl to the block device interface,
> + * as any other ide device.
> + *
> + * Our own ide-tape ioctl's can be issued to either the block device or
> + * the character device interface.
> + *
> + * Maximal throughput with minimal bus load will usually be achieved in the
> + * following scenario:
> + *
> + *	1.	ide-tape is operating in the pipelined operation mode.
> + *	2.	No buffering is performed by the user backup program.

the above is not the part of the changelog

[...]

> + * Here are some words from the first releases of hd.c, which are quoted
> + * in ide.c and apply here as well:
> + *
> + * | Special care is recommended.  Have Fun!

[...]

ditto

> + * An overview of the pipelined operation mode.
> + *
> + * In the pipelined write mode, we will usually just add requests to our
> + * pipeline and return immediately, before we even start to service them. The
> + * user program will then have enough time to prepare the next request while
> + * we are still busy servicing previous requests. In the pipelined read mode,
> + * the situation is similar - we add read-ahead requests into the pipeline,
> + * before the user even requested them.
> + *
> + * The pipeline can be viewed as a "safety net" which will be activated when
> + * the system load is high and prevents the user backup program from keeping up
> + * with the current tape speed. At this point, the pipeline will get
> + * shorter and shorter but the tape will still be streaming at the same speed.
> + * Assuming we have enough pipeline stages, the system load will hopefully
> + * decrease before the pipeline is completely empty, and the backup program
> + * will be able to "catch up" and refill the pipeline again.
> + *
> + * When using the pipelined mode, it would be best to disable any type of
> + * buffering done by the user program, as ide-tape already provides all the
> + * benefits in the kernel, where it can be done in a more efficient way.
> + * As we will usually not block the user program on a request, the most
> + * efficient user code will then be a simple read-write-read-... cycle.
> + * Any additional logic will usually just slow down the backup process.
> + *
> + * Using the pipelined mode, I get a constant over 400 KBps throughput,
> + * which seems to be the maximum throughput supported by my tape.
> + *
> + * However, there are some downfalls:
> + *
> + *	1.	We use memory (for data buffers) in proportional to the number
> + *		of pipeline stages (each stage is about 26 KB with my tape).
> + *	2.	In the pipelined write mode, we cheat and postpone error codes
> + *		to the user task. In read mode, the actual tape position
> + *		will be a bit further than the last requested block.
> + *
> + * Concerning (1):
> + *
> + *	1.	We allocate stages dynamically only when we need them. When
> + *		we don't need them, we don't consume additional memory. In
> + *		case we can't allocate stages, we just manage without them
> + *		(at the expense of decreased throughput) so when Linux is
> + *		tight in memory, we will not pose additional difficulties.
> + *
> + *	2.	The maximum number of stages (which is, in fact, the maximum
> + *		amount of memory) which we allocate is limited by the compile
> + *		time parameter IDETAPE_MAX_PIPELINE_STAGES.
> + *
> + *	3.	The maximum number of stages is a controlled parameter - We
> + *		don't start from the user defined maximum number of stages
> + *		but from the lower IDETAPE_MIN_PIPELINE_STAGES (again, we
> + *		will not even allocate this amount of stages if the user
> + *		program can't handle the speed). We then implement a feedback
> + *		loop which checks if the pipeline is empty, and if it is, we
> + *		increase the maximum number of stages as necessary until we
> + *		reach the optimum value which just manages to keep the tape
> + *		busy with minimum allocated memory or until we reach
> + *		IDETAPE_MAX_PIPELINE_STAGES.
> + *
> + * Concerning (2):
> + *
> + *	In pipelined write mode, ide-tape can not return accurate error codes
> + *	to the user program since we usually just add the request to the
> + *      pipeline without waiting for it to be serviced. In case an error
> + *      occurs, I will report it on the next user request.
> + *
> + *	In the pipelined read mode, subsequent read requests or forward
> + *	filemark spacing will perform correctly, as we preserve all blocks
> + *	and filemarks which we encountered during our excess read-ahead.
> + *
> + *	For accurate tape positioning and error reporting, disabling
> + *	pipelined mode might be the best option.
> + *
> + * You can enable/disable/tune the pipelined operation mode by adjusting
> + * the compile time parameters below.
> + *
> + *
> + *	Possible improvements.
> + *
> + *	1.	Support for the ATAPI overlap protocol.
> + *
> + *		In order to maximize bus throughput, we currently use the DSC
> + *		overlap method which enables ide.c to service requests from the
> + *		other device while the tape is busy executing a command. The
> + *		DSC overlap method involves polling the tape's status register
> + *		for the DSC bit, and servicing the other device while the tape
> + *		isn't ready.
> + *
> + *		In the current QIC development standard (December 1995),
> + *		it is recommended that new tape drives will *in addition*
> + *		implement the ATAPI overlap protocol, which is used for the
> + *		same purpose - efficient use of the IDE bus, but is interrupt
> + *		driven and thus has much less CPU overhead.
> + *
> + *		ATAPI overlap is likely to be supported in most new ATAPI
> + *		devices, including new ATAPI cdroms, and thus provides us
> + *		a method by which we can achieve higher throughput when
> + *		sharing a (fast) ATA-2 disk with any (slow) new ATAPI device.
> + */

ditto

All of the above comments got moved to Documentation/ide/ide-tape.txt.
