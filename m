From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Tue, 6 Sep 2005 08:02:34 +0900
Message-ID: <20050905230234.GA543@htj.dyndns.org>
References: <loom.20050904T095233-120@post.gmane.org> <20050904140239.GA11855@htj.dyndns.org> <loom.20050905T024247-999@post.gmane.org> <431BC732.2010907@gmail.com> <20050905134311.GA15419@est.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:42172 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964915AbVIEXCo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Sep 2005 19:02:44 -0400
Received: by zproxy.gmail.com with SMTP id i11so775430nzh
        for <linux-ide@vger.kernel.org>; Mon, 05 Sep 2005 16:02:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050905134311.GA15419@est.epita.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <mb@opensc.org>
Cc: linux-ide@vger.kernel.org

 Hi, Marc.

On Mon, Sep 05, 2005 at 03:43:11PM +0200, Marc Bevand wrote:
> Tejun Heo wrote:
> | 
> | >o I am using the controller in a 64-bit 133 MHz PCI-X bus.
> | 
> |  Mine is hanging off regular PCI slot.
> 
> I just tried to use a PCI slot instead of a PCI-X one. It does not
> change anything.
> 
> |  Okay, it seems that command is normally issued and completed.  My 
> | primary suspicion now is regarding memory IO mapping.
> | 
> |  - How much memory do you have on the system?
> 
> My system is a dual-Opteron, with 1 GB (attached to the first CPU,
> no RAM on the 2nd CPU). I tried to boot with numa=off, nothing changes.
> 
> |  - Can you try to boot with iommu=off kernel parameter?
> 
> I tried iommu=soft (what you told me in your 2nd reply).
> Nothing changes.

 My incorrect guess was that your system has > 4GB memory and iommu
was screwed up somehow because new sil24 driver currently sets DMA
memory mask to 32bit while original one sets it to 64bit making new
sil24 use iommu for memories > 4GB unlike the original one.

> |  - Can you try to boot with x86 kernel?
>
> I will try it ASAP (right now I only have a pure 64-bit system).

 I was suggesting this for about the same reason, so this won't make
much difference either, I think.  Trying this would be nice anyway to
eliminate a possibility.  You don't have to install 32bit userland.
Just cross-compile 32bit kernel and boot it.  System will fail to
enter userland but all we need to see is libata probing outputs.

 I use the following scripts for cross compiling for x86 from x86-64.
x86-64 compiler and binutils support x86 binaries out of the box and
only some flags are needed.

$ cat i386-make
#!/bin/bash

exec make ARCH=i386 CROSS_COMPILE=i386-linux- "$@"
$ cat i386-linux-ar
#!/bin/bash

exec ar "$@"
[tj@htj:~/bin]$ cat i386-linux-as
#!/bin/bash

exec as --32 "$@"
[tj@htj:~/bin]$ cat i386-linux-gcc
#!/bin/bash

exec gcc -m32 "$@"
[tj@htj:~/bin]$ cat i386-linux-ld
#!/bin/bash

exec ld -melf_i386 "$@"
[tj@htj:~/bin]$ cat i386-linux-nm
#!/bin/bash

exec nm "$@"
[tj@htj:~/bin]$ cat i386-linux-objcopy
#!/bin/bash

exec objcopy "$@"
[tj@htj:~/bin]$ cat i386-linux-ar
#!/bin/bash

exec ar "$@"
[tj@htj:~/bin]$ cat i386-linux-objdump
#!/bin/bash

exec objdump "$@"
[tj@htj:~/bin]$ cat i386-linux-strip
#!/bin/bash

exec strip "$@"

> Since the current sil24-original head, which is the only kernel detecting
> my disks, is really close to a vanilla 2.6.12-rc5 kernel, I have back-
> ported the first version of your rewritten sata_sil24 driver to 2.6.12-rc5,
> and I am currently testing/examining each patch separating sil24-original
> current from 2.6.12-rc5, hoping to find the one that breaks my system.
> 
> Another thing: just to be sure, did you notice that the driver from the
> sil24 head prints:
>   ata9: SATA max UDMA/100 cmd 0xFFFFC20000030000 ctl 0x0 bmdma 0x0 irq 185
> while the driver from the sil24-original head prints:
>   ata9: SATA max UDMA/100 cmd 0xFFFFC20000490000 ctl 0xFFFFC2000049000A bmdma 0xFFFFC20000490000 irq 201
> 'ctl' and 'bmdma' are 0x0 in the first case, is it normal ?

 Yes, those are normal.  Those registers are never used / properly
supported by sil24 and the original driver just initialized them with
meaningless values.

 Thanks.

-- 
tejun
