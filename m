From: Tejun Heo <htejun@gmail.com>
Subject: Re: PROBLEM: SATA hotplugging not working with nForce MCP61
Date: Sat, 02 Feb 2008 14:29:24 +0900
Message-ID: <47A3FFB4.2010509@gmail.com>
References: <20080128074336.GB2736@solitudo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:20545 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760548AbYBBF3c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 00:29:32 -0500
Received: by rv-out-0910.google.com with SMTP id k20so969341rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 21:29:31 -0800 (PST)
In-Reply-To: <20080128074336.GB2736@solitudo.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tuomas Jormola <tj@solitudo.net>
Cc: linux-ide@vger.kernel.org

Tuomas Jormola wrote:
> Hello,
> 
> [1.] One line summary of the problem:
> SATA hotplugging does not seem to work with NVIDIA nForce MCP61.
> 
> [2.] Full description of the problem/report:
> I have a machine with ASRock 939NF6G-VSTA motherboard (more info:
> http://www.asrock.com/mb/overview.asp?Model=939NF6G-VSTA). The SATA
> functionality of the board is enabled by sata_nv driver. However, when I
> tested hot plugging of a SATA hard disk, no hotplugging events were
> generated when I detached the SATA cable from the disk. I tested the same
> disk with an older machine which has MSI Neo Platinium motherboard with
> nForce3 250Gb chipset, also driven by sata_nv driver, and hot plugging
> was ok. Both experiments were done on the same kernel, Ubuntu gutsy
> desktop installer/live CD was used to boot the machines. The attached
> file sata_nv_hotplug_ok.txt is the kernel log of the latter system. At
> around 814 the cable was detached from the drive and by 827 the disk was
> removed from the running configuration. Then at around 871 the cable was
> re-attached, and by 887 the disk was usable again. The file
> sata_nv_hotplug_not_ok.txt contains kernel log of the machine with the
> MCP61 chipset. When the cable is detached, nothing will be printed to the
> log. I hope there is a solution to this problem.

Can you please post the result of 'lspci -nn'?

-- 
tejun
