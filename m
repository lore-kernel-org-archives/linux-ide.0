From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH 13/13] sata_mv use hweight16() for bit counting (V2)
Date: Fri, 2 May 2008 11:31:47 -0700
Message-ID: <da824cf30805021131t777745b1wf90dfa396ee8301b@mail.gmail.com>
References: <481AAF84.40501@rtr.ca> <481AB0A1.3040009@rtr.ca>
	 <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca>
	 <481AB12A.3030102@rtr.ca> <481AB15D.5020201@rtr.ca>
	 <481AB189.3070705@rtr.ca> <481AB1B4.7050508@rtr.ca>
	 <481B55DF.1000208@rtr.ca> <481B5734.4070000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:39180 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780AbYEBSby (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 14:31:54 -0400
Received: from zps77.corp.google.com (zps77.corp.google.com [172.25.146.77])
	by smtp-out.google.com with ESMTP id m42IVmZh011158
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 19:31:50 +0100
Received: from wf-out-1314.google.com (wfg24.prod.google.com [10.142.7.24])
	by zps77.corp.google.com with ESMTP id m42IUtaV024676
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 11:31:47 -0700
Received: by wf-out-1314.google.com with SMTP id 24so1428680wfg.18
        for <linux-ide@vger.kernel.org>; Fri, 02 May 2008 11:31:47 -0700 (PDT)
In-Reply-To: <481B5734.4070000@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

On Fri, May 2, 2008 at 11:02 AM, Mark Lord <liml@rtr.ca> wrote:
> Some tidying as suggested by Grant Grundler.
>
>  Nuke local bit-counting function from sata_mv in favour of using
> hweight16().
>  Also add a short explanation for the 15msec timeout used when waiting for
> empty/idle.
>
>  Signed-off-by: Mark Lord <mlord@pobox.com>

Acked-by: Grant Grundler <grundler@google.com>

>  ---
>  Respin/repost of original patch 13: added #include <linux/bitops.h> for
> safety.
>
>  --- old/drivers/ata/sata_mv.c   2008-05-01 20:29:40.000000000 -0400
>  +++ linux/drivers/ata/sata_mv.c 2008-05-02 13:58:47.000000000 -0400
>  @@ -65,6 +65,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/ata_platform.h>
>  #include <linux/mbus.h>
>  +#include <linux/bitops.h>
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_device.h>
>  @@ -903,6 +904,10 @@
>
>         /*
>          * Wait for the EDMA engine to finish transactions in progress.
>  +        * No idea what a good "timeout" value might be, but measurements
>  +        * indicate that it often requires hundreds of microseconds
>  +        * with two drives in-use.  So we use the 15msec value above
>  +        * as a rough guess at what even more drives might require.
>          */
>         for (i = 0; i < timeout; ++i) {
>                 u32 edma_stat = readl(port_mmio + EDMA_STATUS_OFS);
>  @@ -1640,17 +1645,6 @@
>         return readl(port_mmio + SATA_TESTCTL_OFS) >> 16;
>  }
>
>  -static int mv_count_pmp_links(unsigned int pmp_map)
>  -{
>  -       unsigned int link_count = 0;
>  -
>  -       while (pmp_map) {
>  -               link_count += (pmp_map & 1);
>  -               pmp_map >>= 1;
>  -       }
>  -       return link_count;
>  -}
>  -
>  static void mv_pmp_eh_prep(struct ata_port *ap, unsigned int pmp_map)
>  {
>         struct ata_eh_info *ehi;
>  @@ -1701,7 +1695,7 @@
>                 pp->delayed_eh_pmp_map = new_map;
>                 mv_pmp_eh_prep(ap, new_map & ~old_map);
>         }
>  -       failed_links = mv_count_pmp_links(new_map);
>  +       failed_links = hweight16(new_map);
>
>         ata_port_printk(ap, KERN_INFO, "%s: pmp_map=%04x qc_map=%04x "
>                         "failed_links=%d nr_active_links=%d\n",
>
