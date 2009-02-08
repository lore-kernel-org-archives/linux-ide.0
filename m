From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata-sff: fix 32-bit PIO regression
Date: Mon, 09 Feb 2009 01:10:59 +0300
Message-ID: <498F5873.1080906@ru.mvista.com>
References: <200902082253.07438.sshtylyov@ru.mvista.com> <20090208201125.49326bd2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57761 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753262AbZBHWLI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Feb 2009 17:11:08 -0500
In-Reply-To: <20090208201125.49326bd2@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl

Hello.

Alan Cox wrote:

>> swapping bytes to and fro as well by using io*_rep() which shouldn't byte-swap.
>>     
>
> Nice - thats a very sneaky and clean way to do it but probably should be
> commented or someone will "optimise" it one day ..
>   

   OK, I'll recast and repost it -- along with the patch cleaning up the 
corresponding fragment of the 16-bit I/O method.

MBR, Sergei


