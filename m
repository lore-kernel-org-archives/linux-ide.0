From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] ahci: implement workaround for ASUS P5W-DH Deluxe
 ahci_broken_hardreset()
Date: Thu, 25 Oct 2007 13:52:11 +0900
Message-ID: <472020FB.3050300@gmail.com>
References: <20071025030224.GE11853@htj.dyndns.org> <20071025032845.GF11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:9417 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbXJYEwV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 00:52:21 -0400
Received: by rv-out-0910.google.com with SMTP id k20so372630rvb
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 21:52:20 -0700 (PDT)
In-Reply-To: <20071025032845.GF11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> P5W-DH Deluxe has ICH9 which doesn't have PMP support but SIMG 4726
> hardwired to the second port of AHCI controller at PCI device 1f.2.
> The 4726 doesn't work as PMP but as a storage processor which can do
> hardware RAID on downstream ports.
> 
> When no device is attached to the downstream port of the 4726, pseudo
> ATA device for configuration appears.  Unfortunately, ATA emulation on
> the device is very lousy and causes long hang during boot.
> 
> This patch implements workaround for the board.  If the mainboard is
> P5W-DH Deluxe (matched using DMI), only hardreset is used on the
> second port of AHCI controller @ 1f.2 and the hardreset doesn't wait
> for the first FIS and just proceed to IDENTIFY.
> 
> This workaround has been verified in bugzilla report 8923.
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=8923

I take back this series too. :-( It seems P5W-DH workaround can use 
short wait for !BSY and CLO right after hardreset is finished.  I'll 
post an updated version soon.

Thanks.

-- 
tejun
