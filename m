Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257BD134BE
	for <linux-ide@vger.kernel.org>; Sun,  7 Jan 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz5Vv4Ls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F506C433C8;
	Sun,  7 Jan 2024 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704640514;
	bh=4KRMvQYTvJjPZHYBGQdvnFP2xapAPnE7ms8bghBrE/g=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fz5Vv4Ls2y83y+fXouLa/Cr4+nA8t2GWdKBUvlZCUkkGTXCI/Kzc2Tw+dqixySTgz
	 bCgpIbneV9FWywevx6EKYusR7mtY0YlxU89m+LUbEPDcFH8FUZd6zlFdAAtA4T2XNo
	 foH8h415VLd5oWewKRYyUQMjw2seM45HlFlv03Lnudrf8vLM1CIKOZk5dJx6e9Rv9Z
	 vcC/quaQABTyYZLWULQ/ylOJLhpoFH7coaZgYHWCzYveajIOdv99kkb21TeCEsDWW0
	 Fn/fJe4T/A8a33qxm4haU68aOOGPrsTviqsUTclpKlkeUxz5JbHnEXVitfx0krSJwJ
	 TfGmknGp/PwLA==
Message-ID: <c855f20a-b049-4b62-ac50-db4897166a42@kernel.org>
Date: Mon, 8 Jan 2024 00:15:11 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ATA link drop-outs
Content-Language: en-US
To: Anthony Rossomano <trossoma2@gmail.com>, linux-ide@vger.kernel.org
References: <CA+H-W5JDJ4zBM3de0KF177eusLZ10o5fZ-To=J5a+aNgt8=O+w@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CA+H-W5JDJ4zBM3de0KF177eusLZ10o5fZ-To=J5a+aNgt8=O+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/24 16:17, Anthony Rossomano wrote:
> Hello.. Been chasing an issue with ATA link drop-outs and wanted to
> run this by some SMEs.
> System Information
> Distro: AlmaLinux 8.8
> Kernel: 4.18.0-477.13.1
> Arch: x64
> OpenZFS Version: 2.1.5-1

Unless you can recreate this issue with the latest kernel (6.7-rc8, soon to be
6.7.0), check if the issue is still there or not, and bisect if it not, there is
not much we can do for such an old kernel. We are certainly not going to debug
it directly. But if you can bisect to a fix patch, we can have that patch
backported to LTS. But even then 4.18 is *not* an LTS kernel, so you will need
to work with your distribution vendor to get that fixed in their distribution
kernel.

Looking at the error message, I would suggest you try disabling NCQ (echo 1 >
/sys/block/sdX/device/queue_depth).

> 
> The dropouts are occurring with SSD drives that are attached to
> Marvell 88SE9235 SATA controllers via Marvell 88SM9705 port
> multipliers. The SSD drives are M.2 form factor and are typically
> models from WD or SanDisk. When the issue occurs, communication with
> all SSD drives (5) connected to port multiplier is lost and the driver
> performs recovery steps in order to re-establish connection with the
> SSD drives. This results in ZFS I/O errors being reported from zpool
> status. Multiple events with unsuccessful recovery steps by driver can
> lead to pool suspension.
> 
> The issue occurs with both small and large I/O workloads, though
> usually takes longer to manifest with small I/O workload.
> 
> The issue DOES NOT occur with older version of CentOS and ZFS running
> on same hardware.
> System Information
> Distribution: CentOS 7.9
> Kernel Version: 3.10.0-1160.15.2
> Architecture: x64
> OpenZFS Version: 0.8.6-1
> 
> Have tried the following, in different combinations but issue still occurs:
> Disabling NCQ
> Lowering SATA speed to 3.0
> Upgrading ZFS to 2.1.13
> Upgrading to AlmaLinux 8.9
> Changing SATA power management from max_performance -> medium_power
> Changing I/O scheduler from None -> mq-deadline
> Change max_sectors_kb -> 512
> 
> The issue can be reproduced as follows:
> Small I/O workload: Boot-up system w/ apps that generate small
> sustained I/O load on the ZFS pool and let it run w/o interaction
> Large I/O workload: Use fio to generate heavy I/O workload on ZFS pool
> 
> Partial snippet from syslog that shows initial messages when drop-outs occur:
> Dec 17 07:41:00.384 test01 kernel: ata7.00: failed to read SCR 1 (Emask=0x40)
> Dec 17 07:41:00.384 test01 kernel: ata7.01: failed to read SCR 1 (Emask=0x40)
> Dec 17 07:41:00.384 test01 kernel: ata7.02: failed to read SCR 1 (Emask=0x40)
> Dec 17 07:41:00.384 test01 kernel: ata7.03: failed to read SCR 1 (Emask=0x40)
> Dec 17 07:41:00.384 test01 kernel: ata7.04: failed to read SCR 1 (Emask=0x40)
> Dec 17 07:41:00.384 test01 kernel: ata7.00: exception Emask 0x100 SAct
> 0x4200000 SErr 0x0 action 0x6 frozen
> Dec 17 07:41:00.384 test01 kernel: ata7.00: failed command: WRITE FPDMA QUEUED
> Dec 17 07:41:00.384 test01 kernel: ata7.00: cmd
> 61/0b:a8:da:66:d1/00:00:08:00:00/40 tag 21 ncq dma 5632 out
>          res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> Dec 17 07:41:00.384 test01 kernel: ata7.00: status: { DRDY }
> Dec 17 07:41:00.384 test01 kernel: ata7.00: failed command: WRITE FPDMA QUEUED
> Dec 17 07:41:00.384 test01 kernel: ata7.00: cmd
> 61/15:d0:28:26:fe/00:00:06:00:00/40 tag 26 ncq dma 10752 out
>          res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> Dec 17 07:41:00.384 test01 kernel: ata7.00: status: { DRDY }
> 
> Any input on this would be greatly appreciated!
> 

-- 
Damien Le Moal
Western Digital Research

