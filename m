From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2 #for-3.10] libata: export ata_port port_no attribute
 via /sys
Date: Wed, 15 May 2013 07:37:37 +0200
Message-ID: <51931F21.6020708@suse.de>
References: <1368557320-15735-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43634 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab3EOFhl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 May 2013 01:37:41 -0400
In-Reply-To: <1368557320-15735-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, kay.sievers@vrfy.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

On 05/14/2013 08:48 PM, David Milburn wrote:
> While registering host controller track port number based upon number
> of ports available on the controller, export port_no attribute throug=
h
> /sys. This patch is needed by udev for composing persistent links in
> /dev/disk/by-path.
>=20
> # pwd
> /sys/devices/pci0000:00/0000:00:1f.2/ata8/ata_port/ata8
> # ll
> total 0
> lrwxrwxrwx. 1 root root    0 Mar  6 12:43 device -> ../../../ata8
> -r--r--r--. 1 root root 4096 Mar  6 12:43 idle_irq
> -r--r--r--. 1 root root 4096 Mar  6 12:43 nr_pmp_links
> -r--r--r--. 1 root root 4096 Mar  6 12:43 port_no
> drwxr-xr-x. 2 root root    0 Mar  6 12:42 power
> lrwxrwxrwx. 1 root root    0 Mar  6 12:41 subsystem -> ../../../../..=
/../class/ata_port
> -rw-r--r--. 1 root root 4096 Mar  6 12:40 uevent
> # cat port_no
> 1
>=20
> Signed-off-by: David Milburn <dmilburn@redhat.com>
Acked-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
