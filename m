From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: hdparm ATA Security Options return errors
Date: Mon, 17 Oct 2005 22:52:17 +0200
Message-ID: <43540F01.8090608@gmx.de>
References: <S1750797AbVJQQjQ/20051017163916Z+71@vger.kernel.org> <4353DBF1.1060001@gmx.de> <4353E257.5060104@gmx.de> <43540A36.2080404@rtr.ca>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:53989 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932317AbVJQUwn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Oct 2005 16:52:43 -0400
In-Reply-To: <43540A36.2080404@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> I think the entire set of ATA security patches that were
> sent to me for hdparm are bogus -- I lack the setup here
> to try them, but another kind person is preparing patches
> for hdparm to fix them.

great :)

> 
> Along the way, he has also discovered bugs in the ATA_TASKFILE
> ioctls, but we have yet to work out a good description/patch
> for the broken bits there.

yes, ive just tried to debug this for the last hours, but ive more
trivial problems here, cant run suid root executables anymore, same with
cdrecord *shame*

dont expect too much, ive to read about this taskfile stuff first.
but i can test with an older 20gb ata-6 seagate...

> 
> Cheers
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

y
tom
