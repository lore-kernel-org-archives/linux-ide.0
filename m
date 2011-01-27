From: "Ahmed S. Darwish" <darwish.07-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk
	upon panic
Date: Thu, 27 Jan 2011 05:33:47 +0200
Message-ID: <20110127033347.GA12477@laptop>
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
	<20110126124954.GC24527@laptop> <20110127021338.GA20334@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110127021338.GA20334-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Willy Tarreau <wtarreau-Dj75qbTlC0E76Z2rM5mHXA@public.gmane.org>, Dirk Hohndel <hohndel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, FBDEV-ML <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, IDE-ML <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, James Bottomley <James.Bottomley-l3A5Bk7waGM@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, X86-ML <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Dirk.Hohndel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Mark Lord <kernel-R6A+fiHC8nRWk0Htik3J/w@public.gmane.org>, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, KEXEC-ML <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Eric Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Tejun
List-Id: linux-ide@vger.kernel.org


(Very timely! was just exploring kexec-tools and friends)

On Wed, Jan 26, 2011 at 09:13:38PM -0500, Vivek Goyal wrote:
> On Wed, Jan 26, 2011 at 02:49:54PM +0200, Ahmed S. Darwish wrote:
> > 
> >   If not, can kexec be modified to do so? That possibly needs the help
> >   of a a bootloader extension.
> 
> - Generally kdump uses same kernel as first one. So if first kernel panics
>   then kdump kernel will also panic. Though one can keep a known good kdump
>   kernel.
> 

I was thinking of a 'special' kdump kernel: the older kernel will just pass
the physical RAM address of its ring buffer to the newer kernel. The newer
kernel will be __so specialized__ that it will just:

 - display the log in a friendly manner
 - write it to the swap partition
 - .. and halt

This way, I completely toss the BIOS while accomplishing similar goals.

>
> - Currently kexec-tools take care of loading the kdump kernel, and then
>   preparing memory map for second kernel and pass to it and also pass
>   along some information about vmcore in ELF headers to second kernel. 
>
> There is so much to it that I really don't think that modifying bootloaders to
> do all that might not trivial and more importantly I think it probably is not
> worth the effort.
> 

IMHO if done in a user-friendly and stable manner, it can really be worth
the effort. But quite honestly, since I did not read all the setup work
done by kexec-tools yet, I might be too optimistic.

> Thanks
> Vivek

thanks,

-- 
Darwish
http://darwish.07.googlepages.com
