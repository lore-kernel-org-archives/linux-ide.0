From: Tejun Heo <htejun@gmail.com>
Subject: Re: how it's broken....
Date: Tue, 12 Jul 2005 15:26:56 +0900
Message-ID: <42D362B0.4090505@gmail.com>
References: <20050707130840.5046338C@htj.dyndns.org> <20050707130840.63AB5EBF@htj.dyndns.org> <20050707133058.GA16044@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:51689 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261168AbVGLG1G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2005 02:27:06 -0400
Received: by zproxy.gmail.com with SMTP id z31so472012nzd
        for <linux-ide@vger.kernel.org>; Mon, 11 Jul 2005 23:27:04 -0700 (PDT)
In-Reply-To: <20050707133058.GA16044@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Thu, Jul 07, 2005 at 10:10:04PM +0900, Tejun Heo wrote:
> 
>>10_libata_ahci-atapi.patch
>>
>>	This patch adds ATAPI support to ahci driver.  This currently
>>	doesn't work.  I'll write a reply to this thread to tell more
>>	about this.  However, it at least shows that NCQ ATAPI error
>>	handling works.
>>
> 
> 
>  Hello again, guys.
> 
>  Well, I just added memcpy'ing cdb to ACMD area with this patch and
> thought it should work, but it didn't.  Well, it kind of worked but
> not really.
> 
>  With this patch applied, inquiry succeeds and the device is
> identified and attached with no problem.  Things start to go weird
> with the first TURs (test unit ready) during initialization.
> 
>  When attached to sil, with the same drive and cd inside it, the first
> TUR succeeds and initialization just goes on.  But when attached to
> ahci, it fails all five attempts of TURs with NOT READY, IN PROCESS OF
> BECOMING READY (asc 0x04, ascq 0x01).  This is maybe due to how BIOS
> initializes ATAPI devices during POST.  After five attempts, sr seems
> to give up and just attaches the drive.
> 
>  After boot process is completed, when a read command is issued to
> the drive, the drive works fine on sil, but on ahci, the following
> things happen.
> 
>  * First TUR is failed with MEDIUM CHANGE (asc 0x28 ascq 0x00), which
>    seems reasonable.
>  * Second TUR succeeds.
>  * sr for some reason sends another TUR.  This TUR gets stuck and
>    times out.
>  * Recovery kicks in and resets the device.
>  * sr gives up, unlocks the drive, which the drive fails with RESET
>    occurred.
>  * read fails.
> 
>  The thing is that after a TUR succeeds, the drive completely locks
> up.  If I skip the second TUR, whtatever commands come next gets
> stuck.  If I don't reset after timeout, all following commands are
> timed out.
> 
>  When the same controller is put in legacy mode such that it's
> attached to ata_piix.  The drive works fine just as with sil
> controller.  Any ideas?
> 
>  Log follows.  Log is generated with #11 debug patch applied.  The
> first part is with sil and the second with ahci.

  Okay, I tinkered with it more for past few days.  Here are things I've
found out.

  * Windows XP fails to recognize the drive on boot.  Boot process is
delayed for considerable time (30 secs maybe?) if the drive is attached
on AHCI controller.  After boot, if the drive is unplugged and plugged
again, hotplugging works and the drive gets recognized, and works perfectly.

  * So, I thought maybe AHCI BIOS is doing something weird and somehow
messed up the drive, and, consequently, BIOS wouldn't be able to boot
from the drive.  But it happily loads Gnoppix. ;-(

  * Again out of suspicion that it's caused by BIOS, after Linux boots,
I  unplugged and replugged (including power cable) the drive causing
cold power-cycle.  NCQ recovery kicks in and resets, but the same
result.  After successful TUR, the drive locks up.

  * I thought maybe just interrupt was lost somehow, as the drive is 
reporting status value 0x50 after timing out.  So, I made EH to complete 
commands successfully if ata_ok(stat) on timeout.  But the commands 
weren't properly processed.  The buffers contained garbage values...

  * Then, I just tried everything I could think of, including...
	- limiting interface speed to SATA-I
	- doing SRST
	- doing ATA DEVICE RESET
	- STU
    No matter what I do, the drive locks up eventually.  It's very
weird.  INQUIRY works so command is reaching the device okay and data
transfer from the drive works too.  STU works - if I give LoEJ, it
correctly operates the tray.  And TUR works, it correctly succeeds or
fails (with appropriate sense data) except that the drive locks up after
a successful TUR.

  If you have AHCI and SATA ATAPI device, please try this patch and let
me know how it works.  Now I almost wanna stomp on my DVD writer. ;-(

  PS. Jeff, can you please let me know what you think about this 
patchset?  If it's far from what you have in mind / can accept, I'll be 
happy to redo it.

-- 
tejun

