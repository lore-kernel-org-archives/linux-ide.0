From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_mv driver support for Marvell Hercules II controller in
 newer kernels
Date: Wed, 17 Feb 2010 01:52:49 -0500
Message-ID: <4B7B9241.9070101@garzik.org>
References: <549084.45576.qm@web45206.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:53657 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933779Ab0BQG6R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Feb 2010 01:58:17 -0500
In-Reply-To: <549084.45576.qm@web45206.mail.sp1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: The Government <the_g0vernment@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

On 02/16/2010 10:44 PM, The Government wrote:
> Hey guys,
>
> I'm using a Supermicro aoc-sat2-mv8, which is supposedly supported by the Linux kernel by "sata_mv" driver. Unfortunately, I've been unable to troubleshoot why newer distros (and thus kernels) are not detecting/using sata_mv for this card. I tried an (older) Slackware 12.1 install disk, that for some reason works by use of sata_mv (12.1 was released may 2008, when I think sata_mv was still beta). Anyhow, I've tried many newest releases from Slackware, Arch, etc - and it seems newer kernels do not properly recognize this card. I'm not sure what to make of the newer kernels saying "adaptec aacraid driver" is being used (an incorrectly detected driver?). Anyway, I was told this chipset had great linux support - does it still? Thanks a lot.
>
> (please CC me for replies, thanks a lot)

(cc linux-ide added)

We need a lot more hard detail, such as lspci and dmesg output.

	Jeff


