From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/3] ahci: add missing nv IDs
Date: Wed, 17 Mar 2010 13:47:50 -0400
Message-ID: <4BA115C6.7000900@garzik.org>
References: <4B98575C.5050508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f200.google.com ([209.85.222.200]:52982 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab0CQRrw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2010 13:47:52 -0400
Received: by pzk38 with SMTP id 38so1041510pzk.33
        for <linux-ide@vger.kernel.org>; Wed, 17 Mar 2010 10:47:52 -0700 (PDT)
In-Reply-To: <4B98575C.5050508@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pchen@nvidia.com, kernel-bugzilla.20.drkshadow@spamgourmet.com

On 03/10/2010 09:37 PM, Tejun Heo wrote:
> bko#15481 shows that we're missing some NVIDIA ahci PCI IDs.  Peer
> Chen confirms that IDs 0x580-0x58f are reserved for cases where Linux
> ID option is selected in the BIOS and are only used for mcp65-73.  Add
> 0x0581-0x058f.
>
>    http://bugzilla.kernel.org/show_bug.cgi?id=15481
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Peer Chen<pchen@nvidia.com>
> ---
>   drivers/ata/ahci.c |   15 +++++++++++++++
>   1 file changed, 15 insertions(+)

applied #upstream-fixes


