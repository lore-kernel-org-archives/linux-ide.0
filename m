From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform
 driver
Date: Thu, 13 May 2010 23:30:42 +0100
Message-ID: <20100513233042.64defe12@lxorguk.ukuu.org.uk>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com>
	<4BE6910D.9070504@ru.mvista.com>
	<4BE69C81.2070703@gmail.com>
	<4BE6BA74.10200@mvista.com>
	<4BE74EEE.5060307@gmail.com>
	<4BE7D714.9010006@ru.mvista.com>
	<20100511105531.39670354@lxorguk.ukuu.org.uk>
	<4BEB0FFD.1090701@ru.mvista.com>
	<20100513001315.149bbb66@lxorguk.ukuu.org.uk>
	<4BEB7B79.9050808@gmail.com>
	<4BEC6D92.8080309@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50238 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759531Ab0EMWYH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 May 2010 18:24:07 -0400
In-Reply-To: <4BEC6D92.8080309@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Graeme Russ <graeme.russ@gmail.com>, linux-ide@vger.kernel.org

>     You should have looked at 8250.c first -- there's still lot of 
> pollution left because old accessors were all left in place, including 
> the unfortunate Alchemy UART's ones. :-)

That is one very good example of why I want to see this sorted properly
the first time around with the ide/ata case !
