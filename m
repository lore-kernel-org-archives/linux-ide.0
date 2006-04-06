From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 8/8] sata_sil24: reimplement hardreset
Date: Fri, 7 Apr 2006 01:53:11 +0900
Message-ID: <20060406165311.GH31998@htj.dyndns.org>
References: <11442437423316-git-send-email-htejun@gmail.com> <4435456E.6060504@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:24706 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932193AbWDFQxR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 12:53:17 -0400
Received: by pproxy.gmail.com with SMTP id f28so218330pyf
        for <linux-ide@vger.kernel.org>; Thu, 06 Apr 2006 09:53:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4435456E.6060504@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

On Thu, Apr 06, 2006 at 12:44:30PM -0400, Jeff Garzik wrote:
> >+
> >+	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
> >+		reason = "device not ready";
> >+		goto err;
> >+	}
> >+
> >+	/* SStatus is a bit sluggish (reports 0) on sil24, wait for it */
> >+	sil24_poll_register(port + PORT_SSTATUS, 0xf, 0x0, 10, 100);
> 
> Its weird to poll BSY before polling SStatus.
> 

It turned out that the above delay is not enough.  SStatus oscillates
between zero and valid status for short duration after hardreset
resulting in weird messages like 'ata2: SATA link up <unknown>
(SStatus 0 Scontrol 310)".  I've added unconditional msleep(100) right
afer hardreset and removed this code.

> 
> >+	/* no classification, just return */
> 
> bad comment?

How about...

	/* Sil24 hardreset doesn't report device signature, leave
	 * classes[] alone.
	 */
?

> >+	return 0;
> > 
> >-	/* sil24 doesn't report device signature after hard reset */
> >-	return sata_std_hardreset(ap, &dummy_class);
> >+ err:
> >+	printk(KERN_ERR "ata%u: hardreset failed (%s)\n", ap->id, reason);
> >+	return -EIO;
> > }
> > 
> > static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes)
> 

Thanks.

-- 
tejun
