From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 19:55:51 +0200
Message-ID: <20160814175551.GA3947@amd>
References: <20160813190340.GA29989@amd>
 <20160814092044.GA20392@amd>
 <20160814101438.GA27772@amd>
 <20160814160653.GA3802@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160814160653.GA3802@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, jamespharvey20@gmail.com, regressions@leemhuis.info, chris@chris-wilson.co.uk, imre.deak@intel.com, tvrtko.ursulin@intel.com, drm-intel-fixes@lists.freedesktop.org
Cc: hdegoede@redhat.com, tj@kernel.org, linux-ide@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, stern@rowland.harvard.edu
List-Id: linux-ide@vger.kernel.org

On Sun 2016-08-14 18:06:53, Pavel Machek wrote:
> On Sun 2016-08-14 12:14:38, Pavel Machek wrote:
> > On Sun 2016-08-14 11:20:44, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > It seems that in v4.8-rc0, /dev/sdX got reordered, and now USB devices
> > > > are probed before SATA drivers. That is pretty anti-social. It
> > > > broke my boot on my primary machine, and unfortunately due to BIOS
> > > > problems (keyboard does not work when connected through a hub) it is
> > > > less fun than it should be.
> > > 
> > > If you know which commit caused	the reordering, that would be helpful.
> > > 
> > > v4.1 seems to be ok: SATA disk is sda, as expected.
> > > 
> > > v4.4 seems to be ok: SATA disk is sda, as expected.
> > 
> > v4.6 seems to be ok.
> 
> v4.7-rc1 seems to be ok?! 9956d572
> v4.7-rc3 seems still to be ok.
> v4.7-rc4: still ok.
> v4.7-rc5: ok.
> v4.7-rc6: problem
> 
> Bisecting now, 8 steps to go. As it was introduced between -rc5 and
> -rc6, bisect should not be too scary.

Huh. Scary.

I bisected it to

[ba34a65324259082dc6d2924cb82d562db1c6a6b] drm/i915: Avoid early
timeout during AUX transfers

pavel@amd:/data/l/linux$ git bisect log
# bad: [a99cde438de0c4c0cecc1d1af1a55a75b10bfdef] Linux 4.7-rc6
# good: [a8ef0490c3583c3a83fa52ebe60abb8fd7d3c2a4] Merge commit
'4c2e07c6a29e0129e975727b9f57eede813eea85' into bisect-v4.7
git bisect start 'a99cde438de0c4c0cecc1d1af1a55a75b10bfdef'
'a8ef0490c3583c3a83fa52ebe60abb8fd7d3c2a4'
# good: [4c2e07c6a29e0129e975727b9f57eede813eea85] Linux 4.7-rc5
git bisect good 4c2e07c6a29e0129e975727b9f57eede813eea85
# good: [751ad819b0bf443ad8963eb7bfbd533e6a463973] Merge tag
'mac80211-for-davem-2016-06-29-v2' of
git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211
git bisect good 751ad819b0bf443ad8963eb7bfbd533e6a463973
# good: [aa7a6c8e5252ba28f36a8f87b9acd6a726aa3ae5] Merge tag
'iommu-fixes-v4.7-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
git bisect good aa7a6c8e5252ba28f36a8f87b9acd6a726aa3ae5
# good: [dbdc3bb74faeec5fd92e28c15c945045d5aab426] Merge tag
'acpi-4.7-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good dbdc3bb74faeec5fd92e28c15c945045d5aab426
# good: [467ce7693f5111c11daeb75e02eba2ab9ee6f334] Merge tag
'spi-fix-v4.7-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
git bisect good 467ce7693f5111c11daeb75e02eba2ab9ee6f334
# bad: [88c087109b5fedaf9b61839d08543fdaf9d5ec39] Merge tag
'drm-intel-fixes-2016-06-30' of
git://anongit.freedesktop.org/drm-intel into drm-fixes
git bisect bad 88c087109b5fedaf9b61839d08543fdaf9d5ec39
# bad: [cab103274352721b77fc5923a631fc63350bef8e] drm/i915: Fix
missing unlock on error in i915_ppgtt_info()
git bisect bad cab103274352721b77fc5923a631fc63350bef8e
# good: [fa7c13e5b1e2076b0ec716ed584ab76f9e65b7a6] drm/i915/hsw: Avoid
early timeout during LCPLL disable/restore
git bisect good fa7c13e5b1e2076b0ec716ed584ab76f9e65b7a6
# bad: [42482b4546336ecd93acdd95e435bafd7a4c581c] drm/i915: Add more
Kabylake PCI IDs.
git bisect bad 42482b4546336ecd93acdd95e435bafd7a4c581c
pavel@amd:/data/l/linux$

I reverted ba34a65324259082dc6d2924cb82d562db1c6a6b on top of
4.8-rc1+, and it started booting.

Now the question is... what is going on there...?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
