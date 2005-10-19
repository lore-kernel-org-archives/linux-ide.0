From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: hdparm ATA Security Options return errors
Date: Wed, 19 Oct 2005 09:56:24 +0200
Message-ID: <4355FC28.2020704@gmx.de>
References: <S1750797AbVJQQjQ/20051017163916Z+71@vger.kernel.org> <4353DBF1.1060001@gmx.de> <4353E257.5060104@gmx.de> <43540A36.2080404@rtr.ca>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40161 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751566AbVJSH4m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2005 03:56:42 -0400
In-Reply-To: <43540A36.2080404@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Mark Lord wrote:
> I think the entire set of ATA security patches that were
> sent to me for hdparm are bogus -- I lack the setup here
> to try them, but another kind person is preparing patches
> for hdparm to fix them.
> 
> Along the way, he has also discovered bugs in the ATA_TASKFILE
> ioctls, but we have yet to work out a good description/patch
> for the broken bits there.
> 
> Cheers
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

if no one mentioned before:

these security features should be TODO for linux-usb, scsi-emu ata, too,
to lock external usb harddrives or SATA for (relative secure) transport.

theres some work for enabling S.M.A.R.T for external usb drives and SATA
going on.

suggest integrating the efforts, if not done yet.

y
tom



