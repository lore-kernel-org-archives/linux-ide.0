From: Tejun Heo <htejun@gmail.com>
Subject: Re: Another SATA device with spurious NCQ completions
Date: Tue, 03 Jul 2007 16:42:30 +0900
Message-ID: <4689FDE6.2080806@gmail.com>
References: <46800AD3.7050803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:21714 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbXGCHnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 03:43:53 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2657801wah
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 00:43:53 -0700 (PDT)
In-Reply-To: <46800AD3.7050803@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Chuck Ebbert wrote:
> From:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=245512
> 
> 
> The following error consistently appears at apparently random intervals in syslog:
> 
> kernel: ata1.00: exception Emask 0x2 SAct 0x1001 SErr 0x0 action 0x2 frozen
> kernel: ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x1001
> FIS=004040a1:00000800)
> kernel: ata1.00: cmd 61/08:00:39:2b:cc/00:00:08:00:00/40 tag 0 cdb 0x0 data 4096 out
> kernel:          res 40/00:00:39:2b:cc/00:00:08:00:00/40 Emask 0x2 (HSM violation)
> kernel: ata1.00: cmd 61/08:60:e1:2b:cc/00:00:08:00:00/40 tag 12 cdb 0x0 data
> 4096 out
> kernel:          res 40/00:00:39:2b:cc/00:00:08:00:00/40 Emask 0x2 (HSM violation)
> 
> Controller is ATI SB600 using the AHCI driver.
> 64-bit DMA is disabled.
> Disk is:
> ata1.00: ATA-7: ST3160812AS, 3.ADJ, max UDMA/133
> 
> 
> Can't we just turn off NCQ automatically when this happens?

After sever such occasions, NCQ will be turned off automatically.
Hmm... It's a bit surprising to see this on a Seagate drive tho.  Can
someone crosscheck this by attaching the drive to an intel ahci?

-- 
tejun
