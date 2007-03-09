From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_hpt3x2n: Further updating based upon old IDE work
Date: Fri, 09 Mar 2007 16:52:09 +0300
Message-ID: <45F16689.7010200@ru.mvista.com>
References: <20070308233058.23b5c29d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:42776 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767287AbXCINwW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 08:52:22 -0500
In-Reply-To: <20070308233058.23b5c29d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello.

Alan Cox wrote:
> And it now supports the hpt371n so at some point needs a rename. Sigh

   I think that the whole idea of splitting hpt3xxn into sparate driver was 
wrong.  These drivers need to be merged.

> This imports the basic fixups from the work Sergey has been doing into
> the HPT3x2N driver. In particular it adds support for the 371N. Plenty
> more work left on both this and HPT37x

    That's nice! :-)
    I was going to post some patches to pata_hpt37x/3x2n myself but haven't 
gotten around to it.  Too much work in drivers/ide/ and elsewhere. :-/

> Signed-off-by: Alan Cox <alan@redhat.com>

    Will review the patches some time later...

MBR, Sergei
