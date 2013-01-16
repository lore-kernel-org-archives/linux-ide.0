From: Kay Sievers <kay@vrfy.org>
Subject: Re: [PATCH v2] libata: export host controller number thru /sys
Date: Wed, 16 Jan 2013 23:56:13 +0100
Message-ID: <CAPXgP11pk7xT+SzH9p1+Yj5C16ar0qFdZikg=67w37aS_V9W8Q@mail.gmail.com>
References: <1358287662-24016-1-git-send-email-dmilburn@redhat.com>
 <CAPXgP12JEjksJz7eyvOmzAXh+nFPrEXEU_bsoff-u9bwiyipZg@mail.gmail.com> <50F71AE5.6050906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:57088 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691Ab3APW4f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2013 17:56:35 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so3706350ieb.31
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2013 14:56:34 -0800 (PST)
In-Reply-To: <50F71AE5.6050906@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

On Wed, Jan 16, 2013 at 10:25 PM, David Milburn <dmilburn@redhat.com> wrote:

> So, if we eliminated the global ata_print_id counter, then we would
> need to check all the places ap->print_id is used and consider the host
> controller and a local_print_id. So, if the above changed to 2.1, we
> would expect ata2.1 to show up in dmesg during error recovery
> instead of ata7, right?
>
> There are other places (non-printk stuff) in libata that check the global
> counter that would need to change, and libsas increments the global
> counter when a SATA drive is present on a SAS controller.

Well, we just need a way to get some "stable" numbers out of /sys when
we start at the block device and walk up the chain of parent devices
and see the ata directory. It does not necessarily need to be the name
of the top ata%d directory, it could be a sysfs attribute somewhere
too, if that's easier.

If we we are going to support port by-path/ strings for block devices
connected through a port multiplier chain, I guess we will need an
arbitrary length string representing the concatenated chain of local
port numbers, containing stable port identifier numbers of every
device involved. None of the numbers it contains can therefore depend
on enumeration or loading order.

The "stable chain of port numbers" do not necessarily need to share
anything with the current global numbers to make the device name
unique. It would be easier to understand, but it's not a requirement.

Kay

Kay
