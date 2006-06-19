From: Tejun Heo <htejun@gmail.com>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 using	ahci	module
Date: Tue, 20 Jun 2006 02:18:19 +0900
Message-ID: <4496DC5B.6040100@gmail.com>
References: <1149787827.4180.8.camel@anja> <44890ACA.5070504@gmail.com>	 <1150108974.4020.3.camel@anja> <448D474E.6020706@gmail.com>	 <1150111457.4060.2.camel@anja>  <20060618025632.GE11755@htj.dyndns.org> <1150737053.4220.7.camel@anja>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0102.google.com ([72.14.214.193]:57359 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964811AbWFSRSZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jun 2006 13:18:25 -0400
Received: by hu-out-0102.google.com with SMTP id 34so515545hui
        for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2006 10:18:23 -0700 (PDT)
In-Reply-To: <1150737053.4220.7.camel@anja>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: aalderd.boac@wanadoo.nl
Cc: linux-ide@vger.kernel.org

Aalderd Bouwman wrote:
> Hm, I only have seen spurious interrupts when I have executed fdisk:
> 
> Now doing fdisk /dev/sda or mke2fs /dev/sda1: 
> Kernel log:
> Jun  8 18:52:19 server ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x2)

Can you double check the patch is actually applied.  irq_stat 0x8 is 
PORT_IRQ_SDB_FIS and if the patch were applied, it should have printed a 
message starting with 'spurious SDB FIS...'

> Jun  8 18:53:09 server ata1.00: qc timeout (cmd 0x2f)
> Jun  8 18:53:09 server ata1: failed to read log page 10h (errno=-5)
> Jun  8 18:53:09 server ata1.00: exception Emask 0x1 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
> Jun  8 18:53:09 server ata1.00: (irq_stat 0x40000000)
> 
> Now I am unable to do fdisk because the drive is taken offline:

The patch only adds some debug messages such that the problem can be 
analyzed better - it doesn't fix anything.

-- 
tejun
