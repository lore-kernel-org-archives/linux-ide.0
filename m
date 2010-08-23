From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci port hangs while hard resetting link
Date: Mon, 23 Aug 2010 11:31:32 +0200
Message-ID: <4C723FF4.1020208@kernel.org>
References: <201008230010.48355.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53202 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab0HWJgV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2010 05:36:21 -0400
In-Reply-To: <201008230010.48355.anssi.hannula@iki.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: linux-ide@vger.kernel.org

Hello,

On 08/22/2010 11:10 PM, Anssi Hannula wrote:
> 22:52:18 : ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe 
> frozen
> 22:52:18 : ata6: irq_stat 0x00400040, connection status changed
> 22:52:18 : ata6: SError: { RecovComm PHYRdyChg CommWake DevExch }
> 22:52:18 : ata6: hard resetting link
> 22:52:28 : ata6: softreset failed (device not ready)
> 22:52:28 : ata6: hard resetting link
> 22:52:38 : ata6: softreset failed (device not ready)
> 22:52:38 : ata6: hard resetting link
> 22:52:49 : ata6: link is slow to respond, please be patient (ready=0)
> 22:53:13 : ata6: softreset failed (device not ready)
> 22:53:13 : ata6: limiting SATA link speed to 1.5 Gbps
> 22:53:13 : ata6: hard resetting link
> =====================
> I disconnect the drive for a few moments, but nothing is output by kernel.
> I reconnect it again, but again, nothing is output by the kernel.
> I run: echo "- - -" > 
> /sys/devices/pci0000:00/0000:00:1f.2/host5/scsi_host/host5/scan
> However, it appeared stuck and still no messages in the kernel log, so
> I disconnected the device again. Still nothing is output, and the
> following messages started to be output, indicating that the process
> had become stuck:

Looks like EH got stuck somehow.  Maybe the timeout calculation is
wrong?  Can you please trigger sysrq-t while the system is stuck and
post the result?

Thanks.

-- 
tejun
