From: Gernot Fink <g.fink@gmx.net>
Subject: how replace direct use of ide_hwifs  2.6.27 from FC10
Date: Thu, 11 Dec 2008 19:09:18 +0100
Message-ID: <4941574E.6040702@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53304 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755762AbYLKSJV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Dec 2008 13:09:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hallo,

im working on a Kernelmodul which drives the IDE-Flasher.
This is a device to programm flashchips like bios. ctflasher.sf.net

Now i read not use ide_hwifs direvt anymore. ide_hwifs is not exported.
Google is full of the Patch itself, but no solution.

How do i now find the io-addresses of the unused IDE-ports to check them.

greetings
Gernot

old, now not working anymore code was this:

     for (i = 0; i < MAX_HWIFS; ++i)
     {
         ide_hwif_t *iface = 0;

         iface = &ide_hwifs[i];

         if (iface->io_ports[IDE_DATA_OFFSET] != 0)
         {
             base = iface->io_ports[IDE_DATA_OFFSET];
             if (request_region(base, 8, MODULE_NAME)!=NULL) 
                      	    {
                 if (check_hardware_ide(base))
                 {
                     printk(KERN_DEBUG "%s: ide-flasher found at 0x%lx 
(%s from i
de kernel module).\n",
                     MODULE_NAME, base, iface->name);
                     return base;
                 }
                 release_region(base, 8);
             }
         }
     }
