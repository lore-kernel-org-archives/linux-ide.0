From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: export host controller number thru /sys
Date: Mon, 14 Jan 2013 13:32:13 -0500
Message-ID: <50F44F2D.4060204@pobox.com>
References: <1358179170-19326-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:62313 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756663Ab3ANScR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2013 13:32:17 -0500
Received: by mail-qa0-f54.google.com with SMTP id j15so1698740qaq.20
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2013 10:32:16 -0800 (PST)
In-Reply-To: <1358179170-19326-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, kay.sievers@vrfy.org, coughlan@redhat.com, Gwendal Grignou <gwendal@google.com>

On 01/14/2013 10:59 AM, David Milburn wrote:
> As low-level drivers register their host controller(s), keep track
> of the number of controllers and export thru /sys in a <host.port>
> format so that udev can better match up port numbers with a
> specific controller.
>
> # pwd
> /sys/devices/pci0000:00
> # find . -name 'ata*' -print
>
> (2nd controller with port multiplier attached)
>
> ./0000:00:1e.0/0000:05:01.0/ata2.7
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7/dev7.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.0/dev7.0.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.0/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.1/dev7.1.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.1/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.2/dev7.2.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.2/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.3/dev7.3.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.3/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.4/dev7.4.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.4/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.5/dev7.5.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.5/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.6/dev7.6.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.6/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.7/dev7.7.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.7/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.8/dev7.8.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.8/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.9/dev7.9.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.9/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/ata_port
> ./0000:00:1e.0/0000:05:01.0/ata2.7/ata_port/ata2.7
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.10/dev7.10.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.10/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.11/dev7.11.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.11/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.12/dev7.12.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.12/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.13/dev7.13.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.13/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.14/dev7.14.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7.14/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.8
> ./0000:00:1e.0/0000:05:01.0/ata2.8/link8/dev8.0/ata_device
> ./0000:00:1e.0/0000:05:01.0/ata2.8/link8/ata_link
> ./0000:00:1e.0/0000:05:01.0/ata2.8/ata_port
> ./0000:00:1e.0/0000:05:01.0/ata2.8/ata_port/ata2.8
>
> (1st controller)
>
> ./0000:00:1f.2/ata1.1
> ./0000:00:1f.2/ata1.1/link1/dev1.0/ata_device
> ./0000:00:1f.2/ata1.1/link1/ata_link
> ./0000:00:1f.2/ata1.1/ata_port
> ./0000:00:1f.2/ata1.1/ata_port/ata1.1
> ./0000:00:1f.2/ata1.2
> ./0000:00:1f.2/ata1.2/link2/dev2.0/ata_device
> ./0000:00:1f.2/ata1.2/link2/ata_link
> ./0000:00:1f.2/ata1.2/ata_port
> ./0000:00:1f.2/ata1.2/ata_port/ata1.2
> ./0000:00:1f.2/ata1.3
> ./0000:00:1f.2/ata1.3/link3/dev3.0/ata_device
> ./0000:00:1f.2/ata1.3/link3/ata_link
> ./0000:00:1f.2/ata1.3/ata_port
> ./0000:00:1f.2/ata1.3/ata_port/ata1.3
> ./0000:00:1f.2/ata1.4
> ./0000:00:1f.2/ata1.4/link4/dev4.0/ata_device
> ./0000:00:1f.2/ata1.4/link4/ata_link
> ./0000:00:1f.2/ata1.4/ata_port
> ./0000:00:1f.2/ata1.4/ata_port/ata1.4
> ./0000:00:1f.2/ata1.5
> ./0000:00:1f.2/ata1.5/link5/dev5.0/ata_device
> ./0000:00:1f.2/ata1.5/link5/ata_link
> ./0000:00:1f.2/ata1.5/ata_port
> ./0000:00:1f.2/ata1.5/ata_port/ata1.5
> ./0000:00:1f.2/ata1.6
> ./0000:00:1f.2/ata1.6/link6/dev6.0/ata_device
> ./0000:00:1f.2/ata1.6/link6/ata_link
> ./0000:00:1f.2/ata1.6/ata_port
> ./0000:00:1f.2/ata1.6/ata_port/ata1.6
>
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>   drivers/ata/libata-core.c      |    4 ++++
>   drivers/ata/libata-transport.c |    2 +-
>   include/linux/libata.h         |    1 +
>   3 files changed, 6 insertions(+), 1 deletions(-)

Applied to #upstream, though we'll see if anybody has sysfs file layout 
comments.



