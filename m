From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH6-M libata disk timeouts 2.6.18 -> 2.6.19
Date: Tue, 27 Feb 2007 23:54:30 +0900
Message-ID: <45E44626.6060800@gmail.com>
References: <27103.1168657787@mdt.dhcp.pit.laurelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:29802 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbXB0Oyc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 09:54:32 -0500
Received: by an-out-0708.google.com with SMTP id b33so1142074ana
        for <linux-ide@vger.kernel.org>; Tue, 27 Feb 2007 06:54:32 -0800 (PST)
In-Reply-To: <27103.1168657787@mdt.dhcp.pit.laurelnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Accetta <maccetta@laurelnetworks.com>
Cc: linux-ide@vger.kernel.org

Mike Accetta wrote:
> The version of hdparm on this box gives
>     dev/sdb:
>      operation not supported on SCSI disks
> against the SCSI disk name.  With the controller in compatible mode,
> here is the 'hdparm -I /dev/hdb' output on the same disk:
> 
> ATA device, with non-removable media
>         Model Number:       FUJITSU MHT2060BH
>         Serial Number:      NR0YT53258G8
>         Firmware Revision:  0000104A

Sorry about late late late response.  :-)

2.6.21 will behave better and turn off NCQ automatically in such cases.
 It also reports proper model and firmware revision, so we'll be able to
blacklist it from info contained in the dmesg.

Does your drive always work reliably if queue depth is set to one?  And
often fails when queue depth is 31?

Thanks.

-- 
tejun
