From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/5] Add documentation for hard disk shock protection
 interface
Date: Sat, 26 Jul 2008 13:18:58 +0400
Message-ID: <488AEC02.9040602@ru.mvista.com>
References: <87prp1kvyy.fsf@denkblock.local> <20080726062142.29070.60679.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:18499 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754468AbYGZJTM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jul 2008 05:19:12 -0400
In-Reply-To: <20080726062142.29070.60679.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Elias Oltmanns wrote:
> Put some information (and pointers to more) into the kernel's doc tree,
> describing briefly how to set up disk shock protection under GNU/Linux.
>
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
>   
[...]
> diff --git a/Documentation/laptops/disk-shock-protection.txt b/Documentation/laptops/disk-shock-protection.txt
> new file mode 100644
> index 0000000..ac26040
> --- /dev/null
> +++ b/Documentation/laptops/disk-shock-protection.txt
>   
[...]
> +
> +- http://www.thinkwiki.org/wiki/HDAPS
> +  See this page for information about Linux support of the hard disk
> +  active protection syystem as implemented in IBM/Lenovo Thinkpads.
>   

   A typo in "system". :-)

MBR, Sergei


