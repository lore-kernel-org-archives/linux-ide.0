From: ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org (Eric W. Biederman)
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk upon
	panic
Date: Wed, 26 Jan 2011 23:51:50 -0800
Message-ID: <m1sjweyeax.fsf@fess.ebiederm.org>
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
	<20110126124954.GC24527@laptop> <20110127021338.GA20334@redhat.com>
	<4D40F81E.1030009@zytor.com> <20110127052639.GA16289@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20110127052639.GA16289@laptop> (Ahmed S. Darwish's message of
	"Thu, 27 Jan 2011 07:26:39 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "Ahmed S. Darwish" <darwish.07-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Willy Tarreau <wtarreau-Dj75qbTlC0E76Z2rM5mHXA@public.gmane.org>, Dirk Hohndel <hohndel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, =?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, FBDEV-ML <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, IDE-ML <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, James Bottomley <James.Bottomley-l3A5Bk7waGM@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, X86-ML <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Dirk.Hohndel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Mark Lord <kernel-R6A+fiHC8nRWk0Htik3J/w@public.gmane.org>, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, KEXEC-ML <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj@kern>
List-Id: linux-ide@vger.kernel.org

"Ahmed S. Darwish" <darwish.07-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> On Wed, Jan 26, 2011 at 08:44:14PM -0800, H. Peter Anvin wrote:
>> On 01/26/2011 06:13 PM, Vivek Goyal wrote:
>>>>
>>>> - Use kexec/kdump. I wonder though, can kexec work on early panics? The
>>>>    kind where the disk itself might not yet be initialized?
>>>
>>> As of today kexec/kdump does not work with early panics as kdump kernel
>>> needs to be loaded in reserved memory and that action happens once the
>>> first kernel has booted.
>>>
>>> There is so much to it that I really don't think that modifying bootloaders to
>>> do all that might not trivial and more importantly I think it probably is not
>>> worth the effort.
>>>
>>
>> It's really not all that hard, actually.
>>
>
> Nice, I'll try prototyping this using syslinux and kexec: this seems the
> safest path so far. Further details are in my first reply to Vivek.

Given the inertia of boot loaders it might make sense to compile in the
crash recovery code.

Regardless the way I would organize this is simply to have a chunk of
memory that you place the crash reporting kernel and initrd in, and
simply tell the linux about it, at boot time.  Then kexec on panic can
be pointed at it and that is the end of the matter.  That is very simple.

It might be a bit tricky to get all of the context information the crash
kernel needs, but it should not be too bad.  I am with Vivek in being a
bit dubious if this will do better in practice than having a crash
kernel that we load from the initramfs, simply because the maintenance
difficulty of a specialized component.  But I see no reason to not add
the basic mechanism, to the kernel and bootloaders.  The basic mechanism
is simple and easy to maintain, and ultimately should work across platforms.

Eric
