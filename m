From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 20:22:02 +0200
Message-ID: <358646f2-a475-6ed7-15f0-3b144702e533@redhat.com>
References: <20160813190340.GA29989@amd> <20160814092044.GA20392@amd>
 <20160814101438.GA27772@amd> <20160814160653.GA3802@amd>
 <20160814175551.GA3947@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49206 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbcHNSW1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Aug 2016 14:22:27 -0400
In-Reply-To: <20160814175551.GA3947@amd>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, jamespharvey20@gmail.com, regressions@leemhuis.info, chris@chris-wilson.co.uk, imre.deak@intel.com, tvrtko.ursulin@intel.com, drm-intel-fixes@lists.freedesktop.org
Cc: tj@kernel.org, linux-ide@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, stern@rowland.harvard.edu

Hi,

On 14-08-16 19:55, Pavel Machek wrote:
> On Sun 2016-08-14 18:06:53, Pavel Machek wrote:
>> On Sun 2016-08-14 12:14:38, Pavel Machek wrote:
>>> On Sun 2016-08-14 11:20:44, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>> It seems that in v4.8-rc0, /dev/sdX got reordered, and now USB devices
>>>>> are probed before SATA drivers. That is pretty anti-social. It
>>>>> broke my boot on my primary machine, and unfortunately due to BIOS
>>>>> problems (keyboard does not work when connected through a hub) it is
>>>>> less fun than it should be.
>>>>
>>>> If you know which commit caused	the reordering, that would be helpful.
>>>>
>>>> v4.1 seems to be ok: SATA disk is sda, as expected.
>>>>
>>>> v4.4 seems to be ok: SATA disk is sda, as expected.
>>>
>>> v4.6 seems to be ok.
>>
>> v4.7-rc1 seems to be ok?! 9956d572
>> v4.7-rc3 seems still to be ok.
>> v4.7-rc4: still ok.
>> v4.7-rc5: ok.
>> v4.7-rc6: problem
>>
>> Bisecting now, 8 steps to go. As it was introduced between -rc5 and
>> -rc6, bisect should not be too scary.
>
> Huh. Scary.
>
> I bisected it to
>
> [ba34a65324259082dc6d2924cb82d562db1c6a6b] drm/i915: Avoid early
> timeout during AUX transfers
>
> pavel@amd:/data/l/linux$ git bisect log
> # bad: [a99cde438de0c4c0cecc1d1af1a55a75b10bfdef] Linux 4.7-rc6
> # good: [a8ef0490c3583c3a83fa52ebe60abb8fd7d3c2a4] Merge commit
> '4c2e07c6a29e0129e975727b9f57eede813eea85' into bisect-v4.7
> git bisect start 'a99cde438de0c4c0cecc1d1af1a55a75b10bfdef'
> 'a8ef0490c3583c3a83fa52ebe60abb8fd7d3c2a4'
> # good: [4c2e07c6a29e0129e975727b9f57eede813eea85] Linux 4.7-rc5
> git bisect good 4c2e07c6a29e0129e975727b9f57eede813eea85
> # good: [751ad819b0bf443ad8963eb7bfbd533e6a463973] Merge tag
> 'mac80211-for-davem-2016-06-29-v2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211
> git bisect good 751ad819b0bf443ad8963eb7bfbd533e6a463973
> # good: [aa7a6c8e5252ba28f36a8f87b9acd6a726aa3ae5] Merge tag
> 'iommu-fixes-v4.7-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> git bisect good aa7a6c8e5252ba28f36a8f87b9acd6a726aa3ae5
> # good: [dbdc3bb74faeec5fd92e28c15c945045d5aab426] Merge tag
> 'acpi-4.7-rc6' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good dbdc3bb74faeec5fd92e28c15c945045d5aab426
> # good: [467ce7693f5111c11daeb75e02eba2ab9ee6f334] Merge tag
> 'spi-fix-v4.7-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
> git bisect good 467ce7693f5111c11daeb75e02eba2ab9ee6f334
> # bad: [88c087109b5fedaf9b61839d08543fdaf9d5ec39] Merge tag
> 'drm-intel-fixes-2016-06-30' of
> git://anongit.freedesktop.org/drm-intel into drm-fixes
> git bisect bad 88c087109b5fedaf9b61839d08543fdaf9d5ec39
> # bad: [cab103274352721b77fc5923a631fc63350bef8e] drm/i915: Fix
> missing unlock on error in i915_ppgtt_info()
> git bisect bad cab103274352721b77fc5923a631fc63350bef8e
> # good: [fa7c13e5b1e2076b0ec716ed584ab76f9e65b7a6] drm/i915/hsw: Avoid
> early timeout during LCPLL disable/restore
> git bisect good fa7c13e5b1e2076b0ec716ed584ab76f9e65b7a6
> # bad: [42482b4546336ecd93acdd95e435bafd7a4c581c] drm/i915: Add more
> Kabylake PCI IDs.
> git bisect bad 42482b4546336ecd93acdd95e435bafd7a4c581c
> pavel@amd:/data/l/linux$
>
> I reverted ba34a65324259082dc6d2924cb82d562db1c6a6b on top of
> 4.8-rc1+, and it started booting.
>
> Now the question is... what is going on there...?

Timing magic, as many people have pointed out, you've been depending
on the detection order being fixed, while in reality it has not
been fixed for a long long long time.

This seemingly unrelated commit apparently manages to change
some timing in some way that the detection order changes,
could be as simple as it yielding a core and the usb core
workqueue getting that core to do detection earlier then
before.

I used to work on anaconda, the Fedora / RH installer, as
well as mkinitrd and later dracut and drive-order has
basically never been stable once we no longer had hda /
hdb for ide disks. So you really just need to fix the way
you're booting your system rather then blaming the kernel.

Regards,

Hans
