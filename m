From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [systemd-devel] Making udev emit a signal when it is done loading modules
Date: Sat, 17 Jan 2015 17:03:09 +0100
Message-ID: <CANq1E4QBcH4ZyZ-+j0chW8NAVKQvz=qinjC1kUjHaE9Vq3j0Ug@mail.gmail.com>
References: <54BA20D0.7060402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57831 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbAQQDK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jan 2015 11:03:10 -0500
In-Reply-To: <54BA20D0.7060402@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

Hi

On Sat, Jan 17, 2015 at 9:44 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Dear udev developers,
>
> We (me and some kernel devs mostly) would like to add support to
> the kernel for userspace telling the kernel that it is done with
> the *initial* loading of modules, with the purpose of cleaning up
> (disabling) unused harware resources like e.g. regulators and
> clocks.
>
> Currently the kernel does this cleanup just before it starts init
> (which may very well be init from a ramdisk). In some cases this
> is too early really, because later on a module may get loaded
> which needs this resources, these resources will then get turned
> on again by the loaded driver, and most of the time this is not
> an issue, but sometimes it is.
>
> I realize very well that there is no magic moment where udev is
> really ever done loading modules, but the case which we want to
> support only involves devices which are *already enumerated*, but
> may not yet have a driver loaded, when udev starts. We would like
> udev to emit a signal (ABI to be discussed) when it is done
> trying to load modules for everything which was already enumerated
> when it starts, iow when there are no new device events pending
> anymore when udev does its initial hotplug replay.
>
> So the question to you is would you be willing to include such
> functionality in udev ?  Note this signal would need to be emitted
> when udev from the real rootfs is done with the initial module
> loading, as the real rootfs may very well have more modules
> available then the initrd.

We spent quite some time making module loading 'on demand'. This
means, udev is by no means the only one loading modules. Furthermore,
udev might broadcast events which is reacted on by external listeners.
We cannot rely on them *not* loading modules.

A notion of "settled" would be handy in a lot of situations, but I
doubt that we can enforce it in udev.

Thanks
David
