From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2.6.23-rc3] pata_pdc2027x: PLL detection fixes
Date: Fri, 24 Aug 2007 20:29:17 +0400
Message-ID: <46CF075D.5090205@ru.mvista.com>
References: <200708191717.l7JHHtMO021933@harpo.it.uu.se> <46C8832D.8040801@ru.mvista.com> <46C89E55.90708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:43844 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754654AbXHXQ0m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Aug 2007 12:26:42 -0400
In-Reply-To: <46C89E55.90708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, alan@lxorguk.ukuu.org.uk, albertl@mail.com, linux-ide@vger.kernel.org

Hello.

Jeff Garzik wrote:

>>    What have really surpried me about Promise was that they gave their 
>> SATA chip docs to Jeff who made them public and yet they continue to 
>> conceal the old PATA chip docs... :-/

> They probably just need to be poked.  I've been sitting on the sata_sx4 

    It's not tat MV not poked them but al we've got was a hard copy of one 
section under an agreement to ship the calibration code only to the 
customer... :-/
     Luckily, there were Albert's patches floating around by rhis time. :-)

> docs and cards, waiting on them to give me permission to post the SX4 
> docs since January.  Previous doc pokings were successful, but sometimes 
> they disappear for months at a time.

>     Jeff

MBR, Sergei
