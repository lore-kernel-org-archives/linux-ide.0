From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem with ahci and a external sata disk
Date: Sun, 09 Mar 2008 14:17:12 +0900
Message-ID: <47D372D8.2010708@gmail.com>
References: <200802191646.39277.jareguero@telefonica.net> <200803071515.43686.jareguero@telefonica.net> <200803072333.12877.jareguero@telefonica.net> <200803080220.20565.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:1400 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbYCIFRS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 00:17:18 -0500
Received: by rv-out-0910.google.com with SMTP id k20so722814rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 08 Mar 2008 21:17:18 -0800 (PST)
In-Reply-To: <200803080220.20565.jareguero@telefonica.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jose Alberto Reguero <jareguero@telefonica.net>
Cc: linux-ide@vger.kernel.org

Jose Alberto Reguero wrote:
> [root@jar Pls]# hdparm -I /dev/sdd
> 
> /dev/sdd:
> 
> ATA device, with non-removable media
>         Model Number:       ST3750640AS
>         Serial Number:      5QD3Q2AZ
>         Firmware Revision:  3.AFM
>
> How can be so diferent that the one make with esata?

That's because your enclosure is emulating IDENTIFY command when
attached via SATA.  It's emulating USB mass storage device when
connected via USB but your enclosure is good enough to implement ATA
command passthrough and as hdparm issues IDENTIFY using command
passthrough, it gets to the actual drive and returns the result directly.

-- 
tejun
