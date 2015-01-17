From: Kay Sievers <kay@vrfy.org>
Subject: Re: [systemd-devel] Making udev emit a signal when it is done loading modules
Date: Sat, 17 Jan 2015 17:45:32 +0100
Message-ID: <CAPXgP11bnhjopFUC6nu0C5gzLW5ZvJ0FV27FwjxSUQFxg4HxJA@mail.gmail.com>
References: <54BA20D0.7060402@redhat.com> <20150117160319.GO18247@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:59420 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbAQQpy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jan 2015 11:45:54 -0500
Received: by mail-we0-f181.google.com with SMTP id q58so24966424wes.12
        for <linux-ide@vger.kernel.org>; Sat, 17 Jan 2015 08:45:53 -0800 (PST)
In-Reply-To: <20150117160319.GO18247@in.waw.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Cc: Hans de Goede <hdegoede@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Brown <broonie@kernel.org>, systemd-devel@lists.freedesktop.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

On Sat, Jan 17, 2015 at 5:03 PM, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
> On Sat, Jan 17, 2015 at 09:44:00AM +0100, Hans de Goede wrote:
>> We would like
>> udev to emit a signal (ABI to be discussed) when it is done
>> trying to load modules for everything which was already enumerated
>> when it starts, iow when there are no new device events pending
>> anymore when udev does its initial hotplug replay.
> I think you can just create a unit like:
>
> # disable-new-hardware.service
> [Unit]
> After=3Dsystemd-udev-settle.service systemd-modules-load.service
> Wants=3Dsystemd-udev-settle.service
>
> [Service]
> Type=3Doneshot
> RemainAfterExit=3Dyes
> ExecStart=3D/usr/local/bin/ping-the-kernel
>
>> So the question to you is would you be willing to include such
>> functionality in udev?
> I don't think udevd has enough knowledge. But a systemd unit like
> the one above should work.

No, nothing new, maintained or properly working tool should use or
rely on udevadm settle. Settle is just a dirty hack to make broken
legacy tools work until they disappear.

Kay
