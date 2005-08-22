From: Jeff Garzik <jgarzik@pobox.com>
Subject: libata TODO: ioread/iowrite work (was Re: [PATCH libata:upstream]
 remove compiler warnings)
Date: Mon, 22 Aug 2005 15:50:41 -0400
Message-ID: <430A2C91.4060803@pobox.com>
References: <20050822091129.GA15373@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750749AbVHVTuq@vger.kernel.org>
In-Reply-To: <20050822091129.GA15373@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jeff.
> 
>  This patch removes compiler warnings which are caused by using
> ioports values (unsigned long) for the address argument of
> read/write[bwl]() functions without casting.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK...  These warnings exist as a reminder of the remaining 
ioread/iowrite() work that must occur.  Look at the 'iomap' and 
'iomap-step1' branches of libata-dev.git for incomplete examples of this 
work.

One must:

- create a data structure to store a bunch of I/O port values, as 
returned by pci_iomap() and ioport_map()
- update legacy PCI IDE (aka looks like ISA IDE) code path to use 
ioport_map() to obtain the I/O addresses we need
- update native mode PCI IDE (aka looks like PCI) code path to use 
pci_iomap()
- update all the other drivers that use ioremap() to use pci_iomap()
- change struct ata_ioports, s/unsigned long/void __iomem */
- fix up the last few bits in each driver, such as
	* eliminating the 'unsigned long base' variable in each
	  xxx_init_one() function
	* changing the xxx_setup_port() function to indicate
	  void __iomem * rather than unsigned long
- one last check for any last s/long/void iomem */ changes to be made
- install Linus's "sparse" source checker
- run 'make C=1' in the kernel tree, and make sure libata and drivers 
don't spew warnings


So... it's not as simple as just killing the warnings ;-)
