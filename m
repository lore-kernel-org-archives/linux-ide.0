From: Anton Cook <acook@tpg.com.au>
Subject: HDIO_SET_DMA, 'No DRQ after issuing WRITE'' and PCI resource collisions - kernel 2.4.19
Date: Tue, 4 Feb 2003 12:02:04 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <01C2CC45.3C7C8B40@ACOOK>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>
Cc: "'andre@linux-ide.org'" <andre@linux-ide.org>


With kernel v2.4.19 I have the following problems:

(1) dmesg: 'PCI: Device 00:1f.1 not available because of resource collisions' (IDE device)
(2) hdparm -d 1 /dev/hda gives 'HDIO_SET_DMA failed: Operation not permitted'
(3) 'No DRQ after issuing WRITE' syslog messages.
(4) lspci shows:
00:1f.1 IDE interface: Intel Corporation: Unknown device 248b (rev 02) ....
    Subsystem: Intel Corporation: Unknown device 3419
    Flags: bus master, medium devsel, latency 0, IRQ 17
    ...

The mainboard is an Intel SE7500CW2 with IDE FW82801CA chipset and 2 XEON CPUs. 
The 4 x HDDs are SEAGATE ST120023A.
Kernel options include:
CONFIG_:- 
 BLK_DEV_IDE=y, 
 BLK_DEV_IDEDISK=y,
 BLK_DEV_IDEPCI=y,
 IDEPCI_SHARE_IRQ=y, 
 BLK_DEV_IDEDMA=y, 
 BLK_DEV_ADMA=y, 

Are these  kernel problems with the above hardware and if so advice on later kernels or patches would be greatlt appreciated?

Anton
 
This email and any attachments are confidential and may be subject to
copyright, legal or some other professional privilege. They are intended
solely for the attention and use of the named addressee(s). They may only be
copied, distributed or disclosed with the consent of the copyright owner.

If you have received this email by mistake or by breach of the
confidentiality clause, please notify the sender immediately by return email
and delete or destroy all copies of the email.  Any confidentiality,
privilege or copyright is not waived or lost because this email has been
sent to you by mistake.



