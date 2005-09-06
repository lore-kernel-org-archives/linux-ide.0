From: Marc Bevand <mb@opensc.org>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Tue, 6 Sep 2005 03:12:54 +0200
Message-ID: <20050906011254.GA23144@est.epita.fr>
References: <loom.20050904T095233-120@post.gmane.org> <20050904140239.GA11855@htj.dyndns.org> <loom.20050905T024247-999@post.gmane.org> <431BC732.2010907@gmail.com> <20050905134311.GA15419@est.epita.fr> <20050905230234.GA543@htj.dyndns.org> <20050905231753.GA1003@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.255.125]:15367 "HELO
	deliver.epitech.net") by vger.kernel.org with SMTP id S965039AbVIFBNO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Sep 2005 21:13:14 -0400
Content-Disposition: inline
In-Reply-To: <20050905231753.GA1003@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
|  Hello, Marc.
| 
|  To eliminate one more possibility, can you please try the following
| patch?
| 
| diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
| --- a/drivers/scsi/sata_sil24.c
| +++ b/drivers/scsi/sata_sil24.c
| @@ -720,6 +720,8 @@ static int sil24_init_one(struct pci_dev
|  				       pci_name(pdev));
|  		}
|  
| +		writel(0x0300, port + PORT_SCONTROL);
| +
|  		/* Zero error counters. */
|  		writel(0x8000, port + PORT_DECODE_ERR_THRESH);
|  		writel(0x8000, port + PORT_CRC_ERR_THRESH);

I tried that. No changes.

| diff --git a/include/linux/libata.h b/include/linux/libata.h

It looks like your patch has been truncated: what did you want
to modify in libata.h ?

PS: I am going to test a 32-bit kernel later in the day.

-- 
 Marc Bevand                              http://epita.fr/~bevand_m
 Computer Science School EPITA - System, Network and Security Dept.
