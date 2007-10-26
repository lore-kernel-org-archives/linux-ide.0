From: "Andrew" <andrew@nelless.net>
Subject: RE: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Fri, 26 Oct 2007 14:26:27 +0100 (BST)
Message-ID: <36009.86.7.220.119.1193405187.squirrel@wmbeta.mxes.net>
References: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net>   
    <35163.86.7.220.119.1193312862.squirrel@wmbeta.mxes.net>   
    <200710251406.05804.bzolnier@gmail.com>   
    <200710251411.42546.bzolnier@gmail.com>
    <32932.86.7.220.119.1193345936.squirrel@wmbeta.mxes.net>
    <15F501D1A78BD343BE8F4D8DB854566B059FE1DA@hkemmail01.nvidia.com>
Reply-To: "Andrew" <andrew@nelless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout-04.mxes.net ([216.86.168.179]:1134 "EHLO
	mxout-04.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbXJZN03 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 09:26:29 -0400
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B059FE1DA@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, bzolnier@gmail.com

On Fri, October 26, 2007 06:18, Kuan Luo wrote:
>
>
> When a ncq command is transferred to sata_nv, sata_nv with mcp51 in
> SWNCQ will handle it using ncq software flow  whatever value the swncq
> is. The error maybe happens  if sata_nv does ncq , but the
> nv_swncq_host_init isn't called and bios either doesn't initialize the ncq register.
>
> Best regards,
> Kuan Luo
>

Kuan,

Following your email I checked to see whether it would now work
with sata_nv.swncq=1 passed to the kernel, now that Bartlomiej
Zolnierkiewicz's patch, is applied...and it does, of course.

Thank you all.

--
Andrew



