From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata equivalent for hdX=remap63
Date: Sun, 2 Sep 2007 10:46:45 +0100
Message-ID: <20070902104645.0c6b291c@the-village.bc.nu>
References: <46DA73B5.5010107@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46254 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932458AbXIBJjK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 05:39:10 -0400
In-Reply-To: <46DA73B5.5010107@ums.usu.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-ide@vger.kernel.org, Mauelshagen@RedHat.com

On Sun, 02 Sep 2007 14:26:29 +0600
"Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:

> Hello,
> 
> sorry if this is a FAQ, but googling for "libata remap63" gives nothing 
> useful.
> 
> Some old computers need software like "Ontrack Disk Manager" in order to 
> see large disks in the other OS. The way to deal with such setup in 
> Linux was to add "hdX=remap63" to the kernel arguments. However, I 
> cannot find the equivalent of this option in the new libata-based 
> drivers. Could you please show how to migrate such systems to libata 
> without removing the disk manager?

The remap63 hack is ancient. Since the kernel acquired device mapper its
also unneccessary as you can use device mapper to set up a 63 sector
offset volume.

I'm amazed anyone is still using it but the right way to handle it on a
vaguely modern system isn't more kernel hacks but to teach dmraid to
handle it. If you've got an example of what the layout looks like
(especially if there is a way to autodetect it) then talk to Heinz (cc'd)
about getting it added to dmraid.

Alan
