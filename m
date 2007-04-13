From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: promise ncq
Date: Fri, 13 Apr 2007 23:27:25 +0200 (MEST)
Message-ID: <200704132127.l3DLRPe3020473@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:64514 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030459AbXDMV1c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Apr 2007 17:27:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, raziebe@gmail.com
Cc: jgarzik@pobox.com

On Fri, 13 Apr 2007 23:43:03 +0300, "Raz Ben-Jehuda(caro)" <raziebe@gmail.com> wrote:
> Jeff hello
> I have a promise cotroller that exports its disks as logical volumes
> to the OS, and the OS sees them as physical drives . kernel is 2.6.17.
> I have set  a disk manualy to support ncq using a command line tool
> provided by promise.
> I have "echo 1 > /sys/block/..../dev/rescan" and the ncq bit did not
> show in dmesg.
> queue_depth is set to 32 no matter if ncq is enabled or not. I cannot echo
> to queue_depth , I get "permision denied" error ( libata faq says i
> can do that ).

Assuming you're using libata's sata_promise driver and not Promise's
driver, then the answer is that sata_promise doesn't yet support NCQ.
It will display the disk's NCQ capability, but NCQ won't be activated.

Implementing NCQ is on the TODO list, but I'm ignoring it as long as
the problems with SATAII/3Gbps disks remain unresolved.

/Mikael
