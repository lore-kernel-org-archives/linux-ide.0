From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata DMADIR support
Date: 17 May 2004 12:48:41 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084819720.4328.86.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:52871 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261981AbUEQSs5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 14:48:57 -0400
Received: from royntex01.iomegacorp.com (franklin [10.1.1.83])
	by email.iomega.com (Postfix) with ESMTP id 8A1C01C83
	for <linux-ide@vger.kernel.org>; Mon, 17 May 2004 12:48:56 -0600 (MDT)
In-Reply-To: <40A7F641.3070809@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I remember I promised cross-references into the t13.org theories.  Over
time I hope to walk back thru ATA/PI 7, 6, 5, and 4.  Here first is most
of a DMADIR grep in ATA/PI 7, quoted below.

I think I see that text:

(a) requires a DMADIR device to tell legacy hosts that the device talks
PIO only

(b) requires a DMADIR device to tell new hosts that the device does not
talk SWDMA/ MWDMA

(c) claims a DMADIR device should reward a host confused over direction
with nothing more violent than SK 5 "ILLEGAL REQUEST", and

(d) lets a not-DMADIR device choose to rudely fail classic UDMA Data In
commands, when a host chooses to help by setting the Features & x04
DMADIR bit.

Pat LaVarre

----- d1532v1r4b ATA-ATAPI-7.pdf
...

21 April 2004 
...

[page 169 of 390]

6.18 IDENTIFY PACKET DEVICE [xA1]

...

6.18.18  Word 49: Capabilities

...

Bit 15 of word 49 is used to indicate that the device supports
interleaved DMA data transfer for overlapped  DMA commands. Devices
which require the DMADIR bit in the Packet command shall clear this bit
to 0.

...

Bit 8 of word 49 indicates that DMA is supported. Devices which require
the DMADIR bit in the Packet  command shall clear this bit to 0 

...

6.18.24  Word 62: DMADIR

ATAPI devices that use a serial ATA bridge chip for connection to a
serial ATA host may require use of the  DMADIR bit to indicate transfer
direction for Packet DMA commands.  Word 62 is used to indicate if such 
support is required. 

If bit 15 of word 62 is set to one, then DMADIR bit in the Packet
Command  is required by the device for  Packet DMA and Bits 2:0 of word
63, bits 15 and 8 in word 49, and bits 6:0 of word 88 shall be cleared
to 0,.

If bit 15 of word 62 is cleared to 0, DMADIR bit in the PACKET command
is not required. If bit 15 of word 62  is cleared to zero, then all bits
of word 62 shall be cleared to zero.

Bits (14:11) are reserved.

Bits (10:1) indicate DMA mode support.  Since the DMADIR bit is only
used for a Serial ATAPI device, all of  these bits are set to 1.

...

6.18.25  Word 63: Multiword DMA transfer

...

If the serial interface is implemented, this bit  shall be set to one
except this bit shall be cleared 0 for Serial ATAPI devices requiring
the DMADIR bit in the  PACKET command.   

...

6.18.41  Word 88:Ultra DMA modes

Word 88 shall have the content described for word 88 of the IDENTIFY
DEVICE command, except  bits 6:0 shall be cleared to 0 for Serial ATAPI
devices which require the DMADIR bit in the Packet command. 
...

[page 186 of 390]

6.25 PACKET [xA0]

...

6.25.4 Inputs

...

Features register -

DMADIR -

This bit indicates Packet DMA direction and is used only for devices
that implement the  Packet Command feature set with a Serial ATA bridge
that require direction indication from the  host. Support for this bit
is determined by reading bit 15 of word 62 in the IDENTIFY PACKET 
DEVICE data.  If bit 15 of word 62 is set to 1, the device requires the
use of the DMADIR bit for  Packet DMA commands.

If the device requires the DMADIR bit to be set for Packet DMA
operations and the current  operations is DMA (i.e. bit 0, the DMA bit,
is set), this bit indicates the direction of data transfer  (0 =
transfer to the device; 1 = transfer to the host). If the device
requires the DMADIR bit to be  set for Packet DMA operations but the
current operations is PIO (i.e. bit 0, the DMA bit, is  cleared), this
bit is ignored.

Since the data transfer direction will be set by the host as the command
is constructed, the  DMADIR bit should not conflict with the data
transfer direction of the command.  If a conflict  between the command
transfer direction and the DMADIR bit occurs, the device should return 
with an ABORTED command, and the sense key set to ILLEGAL REQUEST.

If the device does not require the DMADIR bit for Packet DMA operations,
this bit should be  cleared to 0.

A device that does not support the DMADIR feature may abort a command if
the DMADIR bit is  set to 1. 

...

----


