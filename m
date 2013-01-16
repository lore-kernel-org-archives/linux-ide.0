From: Kay Sievers <kay@vrfy.org>
Subject: Re: [PATCH v2] libata: export host controller number thru /sys
Date: Wed, 16 Jan 2013 02:01:39 +0100
Message-ID: <CAPXgP12JEjksJz7eyvOmzAXh+nFPrEXEU_bsoff-u9bwiyipZg@mail.gmail.com>
References: <1358287662-24016-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47501 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757044Ab3APBCC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2013 20:02:02 -0500
Received: by mail-wi0-f174.google.com with SMTP id hq4so2946918wib.7
        for <linux-ide@vger.kernel.org>; Tue, 15 Jan 2013 17:02:00 -0800 (PST)
In-Reply-To: <1358287662-24016-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

On Tue, Jan 15, 2013 at 11:07 PM, David Milburn <dmilburn@redhat.com> wrote:
> As low-level drivers register their host controller(s), keep track
> of the number of controllers and export thru /sys in a <host.port>
> format so that udev can better match up port numbers with a
> specific controller.

Hmm, I tried this and I don't think it will solve out problem. But I
might have missed something ...

This is host 2 with port "7", but it is really port 1:

> ./0000:00:1e.0/0000:05:01.0/ata2.7
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7/dev7.0/ata_device

This is host 1 with port "6":

> ./0000:00:1f.2/ata1.6/ata_port
> ./0000:00:1f.2/ata1.6/ata_port/ata1.6

The host number is meaningless regarding stable identifiers, as it
depends on probing/driver binding order.

Now, the port number is still *global* across all all controllers, and
therefore also not useful. We need *host-local* numbers, which share
nothing with other hosts, so the drivers and bus enumeration order can
change at any time without affecting any of the device numbers used
inside the host.

I have not much clue about port-multipliers, never seen them, but if
we want to support arbitrary stacking of them we will need to compose
a "chain of numbers" in the "stable identifier" out of the individual
port numbers they are connected to, very much like USB hub chaining
works. This means we will need every instance in the chain to start
with their own numbers again.

Any global counters used for device naming/enumeration are not useful
to identify devices from userspace.

Thanks,
Kay
