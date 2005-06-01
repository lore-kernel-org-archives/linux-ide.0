From: Tobias Reinhard <tracer@robotech.de>
Subject: Re: Problem with concurrent SATA-Writes
Date: Thu, 02 Jun 2005 00:40:38 +0200
Message-ID: <429E3966.2050208@robotech.de>
References: <429DECA2.6020609@robotech.de> <429DF174.2000002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutvdom.kundenserver.de ([212.227.126.249]:22238 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261356AbVFAWkp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Jun 2005 18:40:45 -0400
In-Reply-To: <429DF174.2000002@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org



Jeff Garzik wrote:
> Yes, I think this is the third time I've read your email.  You can stop 
> posting it now.
> 
> Sometimes we just don't have time to read and respond to every support 
> request.  If you absolutely require support, please use a paid support 
> channel like SuSE or Red Hat.
Sorry if I annoyed or bothered You or any other one on the list.

I didn't expect that You or any other immediately care about my problems 
and solve them or already have a solution. I could try to fix the driver 
myself but as it seems to be a SIL-specific Problem I need the help or 
some hints from someone who has the (nda-)docs. Maybe they already noted 
this as an errata for which some kind of quirk is needed.

I worked-around the problem by putting the discs on a different 
controller. It seems that this only happens with these Samsung-drives on 
this controller.

Just in case you face this or a similar Problem in the future or find 
the time to investigate it...

BTW: with the siimage driver the transfer-rate is low (20MB/s instead of 
45MB/s) but at least it's working.

BTW2: same with 2.6.12-rc5-mm2


	Tobias



