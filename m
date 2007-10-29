From: Declan Moriarty <declan.moriarty@iol.ie>
Subject: Re: IDE Problem with old Gateway laptop (1998 solo 2300)
Date: Mon, 29 Oct 2007 10:53:22 +0000
Message-ID: <1193655202.2506.27.camel@localhost.localdomain>
References: <949545.3641.qm@web54410.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.mail.iol.ie ([193.120.142.151]:39401 "EHLO
	mail1.mail.iol.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbXJ2KxY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 06:53:24 -0400
In-Reply-To: <949545.3641.qm@web54410.mail.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad Codrea <vladc6@yahoo.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

On Sun, 2007-10-28 at 20:13 -0700, Vlad Codrea wrote:
> Hi,
> 
> Have you tried compiling only libata in the kernel? Libata, being
> newer, might work on your laptop even if the old drivers/ide does not.

One of the kernels has that compiled in, along with drivers. It's a
one-size-fits-all kernel, tested on many machines.
I really doubt if libata alone would do much for me, as the disk and
bios doesn't really want to know about ata at all. We're 1998 here,
remember. ATA has to be disabled for this to read the disk at all.

I did chase for an old 2.4.18 kernel from my last laptop, and that halts
at the same place with a complaint about devices, (Can't open an initial
console) so I'm tarring the 2.4 /dev directory (7.5MB) bzipping it
(86k!!) and sending it over and I'll try that next. I'll probably go
down in flames later in the boot, but we'll see...

Nearly identical IDE messages - all the lines about PIIX4 as before,
then
hda: 6332256 sectors (3242MB) w/128Kib Cache, CHS=6282/16/63, DMA
Partition check:
 hda: [PIBL] [785/128/63] hda1 hda2 hda3 hda4 (That's right - there's
more of them now.)

Well, I got rid of the 'initial console' error. I still get to
EXT3-fs mounted root (ext3 filesystem) readonly
Freeing unused kernel memory: 220k freed
__WE HALT HERE__
No initial console error (it evidently was opened) and then ???
http://www.redhat.com/docs/manuals/linux/RHL-9-Manual/ref-guide/s1-boot-init-shutdown-process.html
end of section 1.2.3

Evidently some failure to launch init.
 
-- 
Declan Moriarty <declan.moriarty@iol.ie>

