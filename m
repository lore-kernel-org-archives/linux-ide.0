From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/8] libata: separate out sil24_poll_register()
Date: Fri, 7 Apr 2006 01:48:06 +0900
Message-ID: <20060406164806.GG31998@htj.dyndns.org>
References: <1144243742725-git-send-email-htejun@gmail.com> <4435450E.2080600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:45643 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932190AbWDFQsL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 12:48:11 -0400
Received: by zproxy.gmail.com with SMTP id o37so194115nzf
        for <linux-ide@vger.kernel.org>; Thu, 06 Apr 2006 09:48:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4435450E.2080600@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

On Thu, Apr 06, 2006 at 12:42:54PM -0400, Jeff Garzik wrote:
> Tejun Heo wrote:
> >This will be used by later patches.
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> >
> >---
> >
> > drivers/scsi/sata_sil24.c |   34 +++++++++++++++++++++++-----------
> > 1 files changed, 23 insertions(+), 11 deletions(-)
> >
> >dbf21a7fbc3fe926671416fecebfea70aef78c8a
> >diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
> >index 86233ac..0941f74 100644
> >--- a/drivers/scsi/sata_sil24.c
> >+++ b/drivers/scsi/sata_sil24.c
> >@@ -431,6 +431,24 @@ static void sil24_tf_read(struct ata_por
> > 	*tf = pp->tf;
> > }
> > 
> >+static int sil24_poll_register(void __iomem *reg, u32 mask, u32 val,
> >+			       unsigned long interval_msec,
> >+			       unsigned long timeout_msec)
> >+{
> >+	unsigned long timeout;
> >+	u32 tmp;
> >+
> >+	timeout = jiffies + (timeout_msec * HZ) / 1000;
> >+	do {
> >+		tmp = readl(reg);
> >+		if ((tmp & mask) == val)
> >+			return 0;
> >+		msleep(interval_msec);
> >+	} while (time_before(jiffies, timeout));
> >+
> 
> Let's not duplicate code in AHCI.  Initially the common code could live 
> in libata, but let's think about the best place in the kernel for this 
> function to live.
> 

Three copies are my tipping point.  Yeah, but two are good enough for
me too.  Any ideas where this utility should live?

-- 
tejun
