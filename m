From: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] ppc32/ide: Add support for MPC52xx on-chip ATA controller
Date: Sun, 23 Apr 2006 21:27:11 +0200
Message-ID: <444BD50F.1040702@246tNt.com>
References: <0.20060330_215150_2026_tnt@patchsend.246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmx028.isp.belgacom.be ([195.238.5.49]:32706 "EHLO
	outmx028.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751446AbWDWT12 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Apr 2006 15:27:28 -0400
Received: from outmx028.isp.belgacom.be (localhost [127.0.0.1])
        by outmx028.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k3NJRKsp010044
        for <linux-ide@vger.kernel.org>; Sun, 23 Apr 2006 21:27:21 +0200
        (envelope-from <tnt@246tNt.com>)
In-Reply-To: <0.20060330_215150_2026_tnt@patchsend.246tNt.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Linux IDE list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Hi all,


Any follow up on that ?


    Sylvain



Sylvain Munaut wrote:
> Hi Bartlomiej,
> Hi everyone,
>
>
> This patch adds support for the integrated IDE controller on the
> Freescale MPC52xx SoC. It has already been posted on the
> ppc-embedded mailings list and was tested and reported working
> by several people.
>
> Could you review it and if it's ok push it upstream ?
>
> Many thanks,
>
> 	Sylvain
>
> ---
> ppc32/ide: Add support for MPC52xx on-chip ATA controller
>
> This patch adds initial support for Freescale MPC52xx on-chip ATA
> controller. It's currently PIO-mode only and all the erratas are
> not handled since some of them requires hw tricks ...
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> ---
> commit f3180ffadd5dddcfa9d11da4f7637e3e907e6aaa
> tree d9bf294057a0dcdda25ba6c6ea3fcc9748d87e93
> parent 67015426ff51ba857b7678a993f4ffd6def1941e
> author Sylvain Munaut <tnt@246tNt.com> 1139147442 +0100
> committer Sylvain Munaut <tnt@246tNt.com> 1143312600 +0100
>
>  drivers/ide/Kconfig                |    4 
>  drivers/ide/Makefile               |    1 
>  drivers/ide/ppc/mpc52xx_ide.c      |  420 +++++++++++++++++++++++++++++++++++++
>  drivers/ide/ppc/mpc52xx_ide.h      |  129 +++++++++++
>  drivers/ide/ppc/mpc52xx_ide_iops.c |  151 +++++++++++++
>  include/linux/ide.h                |    2 
>  6 files changed, 706 insertions(+), 1 deletion(-)
>
> ---
>   
[patch snipped, cfr original post]


