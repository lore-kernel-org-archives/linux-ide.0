From: "Kuan Luo" <kluo@nvidia.com>
Subject: RE: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Fri, 26 Oct 2007 13:18:41 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B059FE1DA@hkemmail01.nvidia.com>
References: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net>    <35163.86.7.220.119.1193312862.squirrel@wmbeta.mxes.net>    <200710251406.05804.bzolnier@gmail.com>    <200710251411.42546.bzolnier@gmail.com> <32932.86.7.220.119.1193345936.squirrel@wmbeta.mxes.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.145]:17276 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbXJZFSq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 01:18:46 -0400
In-Reply-To: <32932.86.7.220.119.1193345936.squirrel@wmbeta.mxes.net>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, Andrew <andrew@nelless.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Andrew wrote:
> 
> On Thu, October 25, 2007 13:11, Bartlomiej Zolnierkiewicz wrote:
> >
> >
> > a better version
> >
> > [PATCH] sata_nv: respect swncq_enabled setting
> >
> >
> > SWNCQ is always used despite swncq_enabled setting (which 
> is disabled by
> > default).  Fix it by using GENERIC nv_port_info[] entry for 
> SWNCQ controllers if swncq_enabled
> > is not enabled.
> >
> 
> This patch worked a treat, thanks.
> 
> -
> Andrew
> 
>
I just reviewed your mails and  simply analysed the message from
http://andotnet.nfshost.com/linux/2.6.24-rc1-swncq.txt.

I saw that the "Using SWNCQ mode" didn't appear, so the swncq should be
equal to 0 and nv_swncq_host_init  wasnt' called.
>From the message "ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth
31/32) "
, i know the libata layer should use ncq protocol. Because the
nv_port_info set ATA_FLAG_NCQ flag and the sata support ncq,
ata_dev_config_ncq  will set dev->flags |= ATA_DFLAG_NCQ and print
(depth 31/32);

When a ncq command is transferred to sata_nv, sata_nv with mcp51 in
SWNCQ will handle it using ncq software flow  whatever value the swncq
is.
The error maybe happens  if sata_nv does ncq , but the
nv_swncq_host_init isn't called and bios either doesn't initialize the
ncq register. 

Best regards,
Kuan Luo
  
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
