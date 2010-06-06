From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector bug)
Date: Sun, 06 Jun 2010 08:22:12 +0200
Message-ID: <4C0B3E94.6020506@gmail.com>
References: <4C03C608.1040600@gmail.com> <20100601135004.GP15159@redhat.com> <4C051D44.7040203@gmail.com> <20100602184459.GA15159@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40072 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab0FFGWS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2010 02:22:18 -0400
In-Reply-To: <20100602184459.GA15159@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-ide@vger.kernel.org

On 06/02/2010 08:44 PM, Don Zickus wrote:
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -550,8 +550,7 @@ cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
>  		break;
>  	case CPU_ONLINE:
>  	case CPU_ONLINE_FROZEN:
> -		if (watchdog_enable(hotcpu))
> -			return NOTIFY_BAD;
> +		watchdog_enable(hotcpu)

This fixes the problem indeed.

thanks,
-- 
js
