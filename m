From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: sata_sil: int slow_down uninitialized
Date: Sat, 05 Jul 2008 15:33:15 +0400
Message-ID: <486F5BFB.9090406@ru.mvista.com>
References: <1215248332.3396.16.camel@nigel-x60>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30421 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751790AbYGELdU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jul 2008 07:33:20 -0400
In-Reply-To: <1215248332.3396.16.camel@nigel-x60>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nigel Kukard <nkukard@lbsd.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

Nigel Kukard wrote:
> Maybe I'm wrong, but line 247 of sata_sil...
> static int slow_down;
>
> is not initialized and used on line 540.
>
> Is this right?
>   

   Yes because unitialized static variables are automatically 
initialzied to 0 in C.

MBR, Sergei


