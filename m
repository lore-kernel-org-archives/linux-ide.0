From: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>
Subject: Re: [Bug #13378] kernel/async.c broke pata_legacy.c
Date: Sat, 06 Jun 2009 14:23:15 +0000
Message-ID: <1244298195.14676.6.camel@mulgrave.site>
References: <4to6E2myxvG.A.muC.aIbIKB@chimera>
	 <LEcEO2518_I.A.8UD.tIbIKB@chimera>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <LEcEO2518_I.A.8UD.tIbIKB@chimera>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, IDE <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Sat, 2009-05-30 at 21:37 +0200, Rafael J. Wysocki wrote:
> This message has been generated automatically as a part of a report
> of recent regressions.
> 
> The following bug entry is on the current list of known regressions
> from 2.6.29.  Please verify if it still should be listed and let me know
> (either way).
> 
> 
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=13378
> Subject		: kernel/async.c broke pata_legacy.c
> Submitter	: Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>
> Date		: 2009-05-24 16:13 (7 days old)
> References	: http://marc.info/?l=linux-kernel&m=124318186507210&w=4
> Handled-By	: James Bottomley <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>
> Patch		: http://patchwork.kernel.org/patch/25699/

Should now be fixed by upstream commit
45bc955bb1324a46c9539550cc615994e6d0a43d

James
