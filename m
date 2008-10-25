From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Sat, 25 Oct 2008 17:42:08 +0400
Message-ID: <49032230.3080603@ru.mvista.com>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810222215.02762.bzolnier@gmail.com> <20081024065043.GA4762@gollum.tnic> <200810251458.46140.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:2572 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751483AbYJYNmT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Oct 2008 09:42:19 -0400
In-Reply-To: <200810251458.46140.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, valerio.p@libero.it, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> For 'addr' we may try to use 4 bytes instead of the current 32 ones but lets
> fix the regression first.
>   

   Alas, TX4939 requeires 8-byte DMA address (and byte count) alignment. 
Another semi-compatible SFF-8038 implementation...

> Thanks,
> Bart

MBR, Sergei


