From: Chris Hann <chann94501@yahoo.com>
Subject: Question about csfo, cache and vendor specific information apparent
 overlap
Date: Wed, 23 Mar 2005 11:32:26 -0800
Message-ID: <4241C44A.7010803@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from [65.115.69.195] ([65.115.69.195]:31395 "EHLO mx.sj.symbol.com")
	by vger.kernel.org with ESMTP id S261826AbVCWTcf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2005 14:32:35 -0500
Received: from gwianameserver.sj.symbol.com (gwianameserver.sj.symbol.com [157.235.95.252])
	by mx.sj.symbol.com (8.12.10/8.12.10) with ESMTP id j2NJNvDq010814
	for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2005 11:23:57 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide list <linux-ide@vger.kernel.org>

Sorry I'm rather late to the Linux game. I have searched the archive for 
references to csfo and cache but I have not found anything to explain 
the issue I am looking at, though there are discussions in the immediate 
area.

If I am referring to outdated information please let me know and I can 
then get back to my vendor to straighten things out.

 From my reading the csfo word has been placed in the first word of the 
vendor specific area of the IDENTIFY DEVICE information.

The t13.org document "Mandatory IDENTIFY DEVICE and IDENTIFY PACKET 
DEVICE fields" defines words 129-159 as vendor specific. The latest 
release would appear to be  http://www.t13.org/technical/e00159r3.pdf 
and I have not found any discussion which would render this document 
obsolete. There are documents relating to modifications in unrelated 
areas, but I could not find any referring to word 129. Perhaps I'm just 
not looking in the right place?

In include/linux/hdreg.h word 129 is defined as csfo

    unsigned short  csfo;        /*  (word 129)
                     * current set features options
                     * 15:4    reserved
                     *  3:    auto reassign
                     *  2:    reverting
                     *  1:    read-look-ahead
                     *  0:    write cache
                     */

which is then used to switch cache operations in drivers/ide/ide-disk.c 
as follows

        /* Cache enabled ? */
        if (drive->id->csfo & 1)
            drive->wcache = 1;


So that means that the first word of the vendor specific code is being 
used to select whether cache operations are enabled.

In the particular case of the flash IDE drive I am using that first word 
is the day number of the date, so for devices built on odd days the 
cache is enabled and for even days disabled. The device has no cache.

So has my vendor missed the repurposing of word 129? Can anyone point me 
to documentation which defines it as csfo?

I apologize if this is an ignorant question, but t13.org seem to hold 
the standards for these drives so that's where I went for information.

Thank you
Chris
