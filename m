From: Mark Lord <liml@rtr.ca>
Subject: Re: libata and PATA devices
Date: Mon, 15 Aug 2005 17:39:04 -0400
Message-ID: <43010B78.7050807@rtr.ca>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>	 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain>	 <42FBB33D.8050003@pobox.com>	 <1123932640.4378.10.camel@localhost.localdomain>	 <42FE12D6.1070600@pobox.com>	 <1123948250.11048.9.camel@localhost.localdomain>	 <42FE1828.4000104@pobox.com>	 <1123949005.11048.16.camel@localhost.localdomain>	 <42FE2380.5040508@pobox.com> <1123951997.15215.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:13061 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S964985AbVHOVit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Aug 2005 17:38:49 -0400
In-Reply-To: <1123951997.15215.1.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Erik Slagter wrote:
>
> I already had it working this way, actually, but it has a bad habit of
> locking up solid every now and then. So I'll wait and in the meantime
> use my patched kernel (=all drives on IDE).

That's a different problem, with a one-liner fix recently
posted to address it -- Jeff even has the one-liner out
for 2.6.13 now, I believe.

-ml


diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -385,6 +385,7 @@ int ata_scsi_error(struct Scsi_Host *hos
           * appropriate place
           */
          host->host_failed--;
+       INIT_LIST_HEAD(&host->eh_cmd_q);

          DPRINTK("EXIT\n");
          return 0;
