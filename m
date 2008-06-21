From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/4] ide: filter out invalid transfer mode values in set_xfer_rate()
Date: Sat, 21 Jun 2008 23:38:03 +0400
Message-ID: <485D589B.5030105@ru.mvista.com>
References: <200806212120.41514.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:65188 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751703AbYFUTiJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Jun 2008 15:38:09 -0400
In-Reply-To: <200806212120.41514.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> Filter out invalid transfer mode values (0x02-0x07) in write handler
> for obsoleted /proc/ide/hd?/settings:current_speed setting.
>
> While at it:
>
> * Use XFER_UDMA_6 define.
>
> Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> Sergei, IIRC that it is what you were suggesting some time ago.
>   

   Maybe I did. :-) But I don't see what that gives to us now...

WBR, Sergei


