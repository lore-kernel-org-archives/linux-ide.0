From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Mon, 27 Oct 2008 13:47:50 +0300
Message-ID: <49059C56.2010405@ru.mvista.com>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810260938.55709.valerio.passini@unicam.it> <20081026145819.GA1320@gollum.tnic> <200810262101.42874.valerio.passini@unicam.it> <20081027061556.GA17928@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:36852 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751328AbYJ0Kr6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 06:47:58 -0400
In-Reply-To: <20081027061556.GA17928@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Valerio Passini <valerio.passini@unicam.it>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, valerio.p@libero.it, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org

Hello.

Borislav Petkov wrote:

   More nipicking... :-)

> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Mon, 27 Oct 2008 06:59:14 +0100
> Subject: [PATCH] ide-cd: fix dma alignment regression
>
> e5318b531b008c79d2a0c0df06a7b8628da38e2f introduced a regression which
>   

   I remember Linus asking to put the commit's one-liner in parens after 
its SHA1...

> caused some ATAPI drives to turn off dma for REQ_TYPE_ATA_PC commands
>   

   Hm, why "ATAPI" but "dma"? Is "dma" a neologism now in English? :-)

> while burning and thus degrating performance and ultimately causing an
>   

    s/degrating/degrading/

MBR, Sergei


