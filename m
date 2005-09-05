From: Marc Bevand <mb@opensc.org>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Mon, 5 Sep 2005 15:43:11 +0200
Message-ID: <20050905134311.GA15419@est.epita.fr>
References: <loom.20050904T095233-120@post.gmane.org> <20050904140239.GA11855@htj.dyndns.org> <loom.20050905T024247-999@post.gmane.org> <431BC732.2010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.255.125]:60171 "HELO
	deliver.epitech.net") by vger.kernel.org with SMTP id S932278AbVIENn3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Sep 2005 09:43:29 -0400
Content-Disposition: inline
In-Reply-To: <431BC732.2010907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
| 
| >o I am using the controller in a 64-bit 133 MHz PCI-X bus.
| 
|  Mine is hanging off regular PCI slot.

I just tried to use a PCI slot instead of a PCI-X one. It does not
change anything.

|  Okay, it seems that command is normally issued and completed.  My 
| primary suspicion now is regarding memory IO mapping.
| 
|  - How much memory do you have on the system?

My system is a dual-Opteron, with 1 GB (attached to the first CPU,
no RAM on the 2nd CPU). I tried to boot with numa=off, nothing changes.

|  - Can you try to boot with iommu=off kernel parameter?

I tried iommu=soft (what you told me in your 2nd reply).
Nothing changes.

|  - Can you try to boot with x86 kernel?

I will try it ASAP (right now I only have a pure 64-bit system).

Since the current sil24-original head, which is the only kernel detecting
my disks, is really close to a vanilla 2.6.12-rc5 kernel, I have back-
ported the first version of your rewritten sata_sil24 driver to 2.6.12-rc5,
and I am currently testing/examining each patch separating sil24-original
current from 2.6.12-rc5, hoping to find the one that breaks my system.

Another thing: just to be sure, did you notice that the driver from the
sil24 head prints:
  ata9: SATA max UDMA/100 cmd 0xFFFFC20000030000 ctl 0x0 bmdma 0x0 irq 185
while the driver from the sil24-original head prints:
  ata9: SATA max UDMA/100 cmd 0xFFFFC20000490000 ctl 0xFFFFC2000049000A bmdma 0xFFFFC20000490000 irq 201
'ctl' and 'bmdma' are 0x0 in the first case, is it normal ?

-- 
 Marc Bevand                              http://epita.fr/~bevand_m
 Computer Science School EPITA - System, Network and Security Dept.
