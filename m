From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Tue, 6 Sep 2005 10:54:28 +0900
Message-ID: <20050906015428.GA13521@htj.dyndns.org>
References: <loom.20050904T095233-120@post.gmane.org> <20050904140239.GA11855@htj.dyndns.org> <loom.20050905T024247-999@post.gmane.org> <431BC732.2010907@gmail.com> <20050905134311.GA15419@est.epita.fr> <20050905230234.GA543@htj.dyndns.org> <20050905231753.GA1003@htj.dyndns.org> <20050906011254.GA23144@est.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:19448 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750981AbVIFByk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Sep 2005 21:54:40 -0400
Received: by zproxy.gmail.com with SMTP id 13so932443nzn
        for <linux-ide@vger.kernel.org>; Mon, 05 Sep 2005 18:54:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050906011254.GA23144@est.epita.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <mb@opensc.org>
Cc: linux-ide@vger.kernel.org

On Tue, Sep 06, 2005 at 03:12:54AM +0200, Marc Bevand wrote:
> Tejun Heo wrote:
> |  Hello, Marc.
> | 
> |  To eliminate one more possibility, can you please try the following
> | patch?
> | 
> | diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
> | --- a/drivers/scsi/sata_sil24.c
> | +++ b/drivers/scsi/sata_sil24.c
> | @@ -720,6 +720,8 @@ static int sil24_init_one(struct pci_dev
> |  				       pci_name(pdev));
> |  		}
> |  
> | +		writel(0x0300, port + PORT_SCONTROL);
> | +
> |  		/* Zero error counters. */
> |  		writel(0x8000, port + PORT_DECODE_ERR_THRESH);
> |  		writel(0x8000, port + PORT_CRC_ERR_THRESH);
> 
> I tried that. No changes.
> 
> | diff --git a/include/linux/libata.h b/include/linux/libata.h
> 
> It looks like your patch has been truncated: what did you want
> to modify in libata.h ?

 Nothing.  Only timestamp has changed and 'git diff' still ran diff on
it, so the empty diff for libata.h.

> PS: I am going to test a 32-bit kernel later in the day.

 I'll backport new sil24 to sil24-original tree so that we can
eliminate all other factors and compare two drivers again to find the
offending difference.  I'm currently in the middle of something so it
may take me a day or so.

 Thanks.

-- 
tejun
