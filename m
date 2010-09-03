From: Don Zickus <dzickus@redhat.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector bug)
Date: Fri, 3 Sep 2010 09:56:13 -0400
Message-ID: <20100903135613.GV4879@redhat.com>
References: <4C03C608.1040600@gmail.com>
 <20100601135004.GP15159@redhat.com>
 <4C051D44.7040203@gmail.com>
 <20100602184459.GA15159@redhat.com>
 <4C0B3E94.6020506@gmail.com>
 <4C80B338.6020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44163 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958Ab0ICN4u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Sep 2010 09:56:50 -0400
Content-Disposition: inline
In-Reply-To: <4C80B338.6020701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-ide@vger.kernel.org

On Fri, Sep 03, 2010 at 10:35:04AM +0200, Jiri Slaby wrote:
> On 06/06/2010 08:22 AM, Jiri Slaby wrote:
> > On 06/02/2010 08:44 PM, Don Zickus wrote:
> >> --- a/kernel/watchdog.c
> >> +++ b/kernel/watchdog.c
> >> @@ -550,8 +550,7 @@ cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
> >>  		break;
> >>  	case CPU_ONLINE:
> >>  	case CPU_ONLINE_FROZEN:
> >> -		if (watchdog_enable(hotcpu))
> >> -			return NOTIFY_BAD;
> >> +		watchdog_enable(hotcpu)
> > 
> > This fixes the problem indeed.
> 
> Hi, was this fixed somehow? I still use this hunk and don't know if it
> is needed:

I have to go re-review the problem again.  I might have forgot to bring it
in.  Thanks for reminding me!

Cheers,
Don

> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -524,7 +524,7 @@ cpu_callback(struct notifier_block *nfb, unsigned
> long action, void *hcpu)
>                 break;
>         case CPU_ONLINE:
>         case CPU_ONLINE_FROZEN:
> -               err = watchdog_enable(hotcpu);
> +               watchdog_enable(hotcpu);
>                 break;
>  #ifdef CONFIG_HOTPLUG_CPU
>         case CPU_UP_CANCELED:
> 
> thanks,
> -- 
> js
