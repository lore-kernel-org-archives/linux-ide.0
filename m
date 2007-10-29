From: Tejun Heo <htejun@gmail.com>
Subject: Re: blacklisting ST3500630AS as not able to do NCQ
Date: Mon, 29 Oct 2007 15:14:34 +0900
Message-ID: <47257A4A.1000806@gmail.com>
References: <1993911428.20071007225627@coral.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:33715 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbXJ2GOn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 02:14:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1977270wah
        for <linux-ide@vger.kernel.org>; Sun, 28 Oct 2007 23:14:43 -0700 (PDT)
In-Reply-To: <1993911428.20071007225627@coral.dnsalias.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: diego torres <dtorres@coral.dnsalias.org>
Cc: linux-ide@vger.kernel.org

diego torres wrote:
> Hi there,
> 
> This seagate drive ST3500630AS is being recognized as NCQ capable by
> hdparm, and has the default queue_depth of 31, so i think it should
> work ok. But there are some problems when using smartmontools (for
> example in short test mode) as seen in dmesg:
> 
> ata2.00: exception Emask 0x2 SAct 0x9 SErr 0x0 action 0x2 frozen
> ata2.00: (spurious completions during NCQ issue=0x0 SAct=0x9 FIS=004040a1:00000004)
> ata2.00: cmd 61/08:00:f4:28:4e/00:00:00:00:00/40 tag 0 cdb 0x0 data 4096 out
>          res 40/00:00:f4:28:4e/00:00:00:00:00/40 Emask 0x2 (HSM violation)
> ata2.00: cmd 61/08:18:dc:c8:d7/00:00:00:00:00/40 tag 3 cdb 0x0 data 4096 out
>          res 40/00:00:f4:28:4e/00:00:00:00:00/40 Emask 0x2 (HSM violation)
> ata2: soft resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/133
> ata2: EH complete
> sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> 
> All this problems dissapear when setting queue_depth to 1.
> 
> After cheking the seagate website, there is no mention to NCQ in the
> spec sheet of this drive, although there are models tagged as using
> NCQ interface, for example ST3500620AS

How reproducible is the problem?

-- 
tejun
