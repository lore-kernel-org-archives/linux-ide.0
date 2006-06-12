From: Tejun Heo <htejun@gmail.com>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 using ahci	module
Date: Mon, 12 Jun 2006 19:51:58 +0900
Message-ID: <448D474E.6020706@gmail.com>
References: <1149787827.4180.8.camel@anja>  <44890ACA.5070504@gmail.com> <1150108974.4020.3.camel@anja>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:54001 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751845AbWFLKwF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 06:52:05 -0400
Received: by nz-out-0102.google.com with SMTP id r28so1280314nza
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 03:52:04 -0700 (PDT)
In-Reply-To: <1150108974.4020.3.camel@anja>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: aalderd.boac@wanadoo.nl
Cc: linux-ide@vger.kernel.org

Aalderd Bouwman wrote:
> Jun 12 12:27:24 server ata13.00: (irq_stat 0x40000000)
> Jun 12 12:27:24 server ata13.00: tag 0 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
> Jun 12 12:27:24 server ata13.00: tag 1 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
> Jun 12 12:27:24 server ata13.00: tag 3 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
> Jun 12 12:27:24 server ata13: soft resetting port
> Jun 12 12:27:24 server ata13: softreset failed (1st FIS failed)
> Jun 12 12:27:24 server ata13: softreset failed, retrying in 5 secs
> Jun 12 12:27:29 server ata13: hard resetting port
> 
> Remove sata-connector and then the power-connector of the Seagate drive.
> (Note that I also have problems with hotplug the Maxtor-drive.
>  I will post that problem later this day.)

Can you remove and then replug those?  I wanna see whether the 
controller is locked up or the drive.

-- 
tejun
