From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ATA ACPI (was Re: Linux 2.6.24-rc4)
Date: Tue, 04 Dec 2007 18:00:23 -0500
Message-ID: <4755DC07.5090009@garzik.org>
References: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org>	 <8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com>	 <4755C544.5060909@garzik.org> <4755C63B.7080608@garzik.org> <8db1092f0712041448t5a3da9ecna73730e421626450@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46750 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbXLDXAZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 18:00:25 -0500
In-Reply-To: <8db1092f0712041448t5a3da9ecna73730e421626450@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: linux-ide@vger.kernel.org

Maciej Rutecki wrote:
> http://www.unixy.pl/maciek/download/kernel/2.6.24-rc4/dmidecode.txt.gz

Thanks.


>>> And may I presume that booting with libata module option 'noacpi=1'
>>> fixes the problem?
> 
> noacpi=1 kernel command line or module parameters?
> 
> First, no change:
> http://www.unixy.pl/maciek/download/kernel/2.6.24-rc4/dmesg_noacpi.txt.gz
> Kernel command line: root=/dev/sda2 ro vga=0x318 resume=/dev/sda3
> selinux=1 enforcing=1  noacpi=1


Yes, that's a module option.

_If_ libata is built into the kernel, and not a kernel module, then you 
can supply "libata.noacpi=1" on the kernel command line.  I don't think 
that works with modules.

With libata built as a module (libata.ko), you will probably need to 
edit /etc/modprobe.conf.

	Jeff


