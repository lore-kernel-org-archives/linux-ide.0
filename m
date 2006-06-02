From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 1/n] libata-core.c conversion to new debugging scheme, part 1 (25% done)
Date: Fri, 2 Jun 2006 09:32:32 +0200
Message-ID: <20060602073232.GA8402@gollum.tnic>
References: <20060531054633.GA4875@zmei.tnic> <20060531063957.GD14179@havoc.gtf.org> <20060601053849.GB8523@gollum.tnic> <447E849B.8020208@gmail.com> <20060601061433.GC5869@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp107.plus.mail.re2.yahoo.com ([206.190.53.32]:35005 "HELO
	smtp107.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751137AbWFBHcf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 03:32:35 -0400
Content-Disposition: inline
In-Reply-To: <20060601061433.GC5869@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Borislav Petkov <bbpetkov@yahoo.de>, linux-ide@vger.kernel.org

On Thu, Jun 01, 2006 at 02:14:33AM -0400, Jeff Garzik wrote:
> The ata_msg_xxx level and KERN_xxx level are not perfectly mapped, nor
> should they be, so the proposed scheme may not work out once we have all
> the message levels integrated.

How about the folowing mapping for ATA-to-printk debugging levels:

ATA_MSG_DRV		----> KERN_INFO
ATA_MSG_INFO

ATA_MSG_PROBE	----> KERN_DEBUG
ATA_MSG_MALLOC
ATA_MSG_CTL
ATA_MSG_INTR

since those are in their nature debugging infos containing ENTER/EXIT
function_name calls

ATA_MSG_WARN	----> KERN_WARNING

ATA_MSG_ERR		----> KERN_ERR

but this I could do after the whole conversion thing is done so we have the new
dbg infrastructure first.

Regards,
	Boris.

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

