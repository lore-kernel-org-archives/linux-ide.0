From: Tejun Heo <htejun@gmail.com>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710,
 pcmcia based sata_sil24, PMP, and NCQ drive
Date: Tue, 29 Aug 2006 22:35:14 +0900
Message-ID: <44F44292.30306@gmail.com>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com> <20060829045816.GA21746@geeks.org> <20060829075454.GA22899@geeks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:58352 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964969AbWH2NgJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 09:36:09 -0400
Received: by py-out-1112.google.com with SMTP id n25so2896401pyg
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2006 06:36:08 -0700 (PDT)
In-Reply-To: <20060829075454.GA22899@geeks.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derek Taubert <taubert@geeks.org>
Cc: linux-ide@vger.kernel.org

Derek Taubert wrote:
> The sd cache_type is set to "write back" for this drive.  I suspect that
> the reads are coming from the block driver attempting to fill lines.
> 
> # cat /sys/bus/scsi/devices/0:0:0:0/scsi_disk:0:0:0:0/cache_type
> write back

That's the cache inside the harddrive.  To libata and SCSI, it's 
(almost) transparent and doesn't cause such problems.

> Also, a problem here:
> 
> # echo "none" > /sys/bus/scsi/devices/0:0:0:0/scsi_disk:0:0:0:0/cache_type
> echo: write error: invalid argument
> 
> dmesg says:
> 
> sda: Current: sense key: Illegal Request
>     Additional sense: Invalid field in cdb

libata doesn't support that sysfs node (yet).

-- 
tejun
