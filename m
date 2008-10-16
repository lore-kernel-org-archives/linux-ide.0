From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide-dma: fix ide_build_dmatable() for TRM290
Date: Fri, 17 Oct 2008 02:50:05 +0400
Message-ID: <48F7C51D.3010406@ru.mvista.com>
References: <200809282241.26289.sshtylyov@ru.mvista.com> <48F72CC7.2040202@ru.mvista.com> <48F73198.20209@ru.mvista.com> <200810162148.47262.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:8080 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758396AbYJPWuK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 18:50:10 -0400
In-Reply-To: <200810162148.47262.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Thanks for noticing and sorry for that.
>   

   Not that it was an important patch... :-)

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: re-add TRM290 fix lost during ide_build_dmatable() cleanup
>
> commit 14c123f37187aba0b4e0e893a969efc6820c4170 ("ide: cleanup
> ide_build_dmatable()") accidentally reverted TRM290 fix introduced
> by commit 22e05b4549bf2405d6aca128540b20cd2dd33f1f ("ide-dma: fix
> ide_build_dmatable() for TRM290").
>
> Reported-by: Sergei Shtylylov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

Acked-by: Sergei Shtylylov <sshtylyov@ru.mvista.com>

WBR, Sergei


