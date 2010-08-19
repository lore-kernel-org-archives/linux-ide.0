From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 14:52:21 +0200
Message-ID: <AANLkTi=K-mt_NhUYnJT7DJMwX-CUu8Ri6NwT_AFMct5a@mail.gmail.com>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
 <4C6AB68D.8000102@kernel.org> <20100817174257.3691ed68@lxorguk.ukuu.org.uk>
 <4C6AB919.7060203@kernel.org> <20100817180158.179e7780@lxorguk.ukuu.org.uk>
 <4C6ABFFA.2000502@kernel.org> <20100817192353.3529733c@lxorguk.ukuu.org.uk>
 <4C6B7B72.4090405@kernel.org> <20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>
 <4C6BE9C8.4030803@kernel.org> <20100818161521.430ba361@lxorguk.ukuu.org.uk>
 <4C6CFB63.2070001@kernel.org> <20100819110959.40312e58@linux.intel.com>
 <4C6D13E2.1010703@kernel.org> <1282217732.1236.19.camel@yio.site>
 <4C6D189A.2080706@kernel.org> <AANLkTi=oTW6Qko_ZpUL-S3e_mMqKYXSyEkxUXjhsps_u@mail.gmail.com>
 <4C6D2486.4020702@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33881 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab0HSMwi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2010 08:52:38 -0400
Received: by gwj17 with SMTP id 17so678754gwj.19
        for <linux-ide@vger.kernel.org>; Thu, 19 Aug 2010 05:52:38 -0700 (PDT)
In-Reply-To: <4C6D2486.4020702@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jeff@garzik.org

On Thu, Aug 19, 2010 at 14:33, Tejun Heo <tj@kernel.org> wrote:
> I'm curious about the followings,
>
> a. udev invokes modprobe on device added events, no?

Yeah, in this case it from off of the pci devices. Most of the events
for pci devices run in parallel.

>  Does it matter
> =C2=A0 whether there's a matching driver in the kernel (built-in or a=
n
> =C2=A0 already loaded module) to udev behavior?

If the device we are currently handling has already a driver bound,
udev will not call modprobe.
It's:
  DRIVER!=3D"?*", ENV{MODALIAS}=3D=3D"?*", RUN+=3D"/sbin/modprobe -bv $=
env{MODALIAS}"
which means:
  !DRIVER && MODALIAS -> modprobe

> You seem to be implying
> =C2=A0 that if there's a matching driver, udev wouldn't invoke modpro=
be at
> =C2=A0 all.

It doesn't call modprobe for this device in that case, yes. But some
other similar device may still cause the driver to be loaded and every
driver load will scan all devices and try to bind them.

> b. modprobe, when invoked, will load all the matching drivers in link
> =C2=A0 order. =C2=A0If udev invokes modprobe regardless of existing d=
rivers,

Yeah, udev only cares about the device state, and if the device has a
driver bound, not if there are other drivers (bound or unbound to
devices) in the kernel already.

>   is
> =C2=A0 there a mechanism to hold off device - driver matching before
> =C2=A0 modprobe is finished? =C2=A0Probably not, right?

What does 'modprobe finished' mean? The modprobe called for this
specific device? The first driver loaded and initialized will win. If
multiple drivers are loaded with the same modprobe call, the later
ones will never see the device.

Kay
