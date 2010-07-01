From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] ahci,ata_generic: let ata_generic handle
 new MBP w/ MCP89
Date: Thu, 01 Jul 2010 15:35:33 -0400
Message-ID: <4C2CEE05.3000803@pobox.com>
References: <4C19EDFE.8040202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44275 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab0GATfn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 15:35:43 -0400
Received: by gye5 with SMTP id 5so46757gye.19
        for <linux-ide@vger.kernel.org>; Thu, 01 Jul 2010 12:35:41 -0700 (PDT)
In-Reply-To: <4C19EDFE.8040202@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pchen@nvidia.com, grapz666@gmail.com, tixetsal@juno.com, damien.cassou@gmail.com, gschwind@gnu-log.net, andreas_graf@csgraf.de, stable <stable@kernel.org>

On 06/17/2010 05:42 AM, Tejun Heo wrote:
> For yet unknown reason, MCP89 on MBP 7,1 doesn't work w/ ahci under
> linux but the controller doesn't require explicit mode setting and
> works fine with ata_generic.  Make ahci ignore the controller on MBP
> 7,1 and let ata_generic take it for now.
>
> Reported in bko#15923.
>
>    https://bugzilla.kernel.org/show_bug.cgi?id=3D15923
>
> NVIDIA is investigating why ahci mode doesn't work.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Peer Chen<pchen@nvidia.com>
> Cc: stable@kernel.org
> Reported-by: Anders =D8sthus<grapz666@gmail.com>
> Reported-by: Andreas Graf<andreas_graf@csgraf.de>
> Reported-by: Benoit Gschwind<gschwind@gnu-log.net>
> Reported-by: Damien Cassou<damien.cassou@gmail.com>
> Reported-by: tixetsal@juno.com
> ---
>   drivers/ata/ahci.c        |   10 ++++++++++
>   drivers/ata/ata_generic.c |    6 ++++++
>   include/linux/pci_ids.h   |    1 +
>   3 files changed, 17 insertions(+)

applied 1-2


