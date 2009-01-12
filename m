From: Justin Madru <jdm64-u1xxEuL7cY4AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bug #12263] Sata soft reset filling log
Date: Mon, 12 Jan 2009 15:53:17 -0800
Message-ID: <496BD7ED.1010909@gawab.com>
References: <nn3SOLVZ28H.A.bY.CafaJB@chimera> <nHCfeC0YLrE.A.tiC.4afaJB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <nHCfeC0YLrE.A.tiC.4afaJB@chimera>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IDE <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Rafael J. Wysocki wrote:
> This message has been generated automatically as a part of a report
> of regressions introduced between 2.6.27 and 2.6.28.
>
> The following bug entry is on the current list of known regressions
> introduced between 2.6.27 and 2.6.28.  Please verify if it still should
> be listed and let me know (either way).
>
>
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=12263
> Subject		: Sata soft reset filling log
> Submitter	: Justin Madru <bevicm-QP1aEjBt37AFQeE35raUng@public.gmane.org>
> Date		: 2008-12-13 2:07 (30 days old)
> References	: http://marc.info/?l=linux-kernel&m=122913412608533&w=4
>
>
>
>   
Yes, I'm still seeing this on .28 and even on .29-rc1.
I checked again and couldn't trigger the regression on a .27 kernel (at 
least with my hardware and config).
So, I'm fairly confident that it's a regression, not just a bug that's 
always been there.
