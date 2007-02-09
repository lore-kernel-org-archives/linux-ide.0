From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Fri, 09 Feb 2007 16:45:49 +0100
Message-ID: <1171035949.23440.4.camel@localhost>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
	 <45CC3FE5.2010408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:59125 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946541AbXBIPwo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Feb 2007 10:52:44 -0500
In-Reply-To: <45CC3FE5.2010408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Root Kit <rootkit85@yahoo.it>, linux-ide@vger.kernel.org

On Fri, 2007-02-09 at 04:33 -0500, Tejun Heo wrote:
> Root Kit wrote:
> > hi,
> > i have a MacBook pro and i noticed that linux
> > (2.6.20)
> > binds the ata_piix driver
> > to the SATA controller.
> > being my SATA controller an AHCI (ICH7M) i added the
> > PCI ID to ahci.c
> > then tested the system.
> > i inline the patch here:
> 
> Great.  Care to post a proper patch with leading description and SOB? 
> Please take a look at the following patch.  You can omit diffstat result.

Hmmhh I cannot really reproduce this benchmark. Matteo, with which
benchmarking program did you produce this ?

Below is what I get when compiling shogun with make -j 4 (src from
www.shogun-toolbox.org) and a bonnie++ run:

piix:

$ /usr/sbin/bonnie++ -d ./
Writing with putc()...done
Writing intelligently...done
Rewriting...done
Reading with getc()...done
Reading intelligently...done
start 'em...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...done.
Create files in random order...done.
Stat files in random order...done.
Delete files in random order...done.
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
no               4G 23865  57 24221   6 11588   2 26972  60 27942   2  88.5   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16 +++++ +++ +++++ +++ +++++ +++ +++++ +++ +++++ +++ +++++ +++
no,4G,23865,57,24221,6,11588,2,26972,60,27942,2,88.5,0,16,+++++,+++,+++++,+++,+++++,+++,+++++,+++,+++++,+++,+++++,+++

$ time make -j4
real    2m40.799s
user    4m9.374s
sys     0m8.719s

ahci:
$ /usr/sbin/bonnie++ -d ./
Writing with putc()...done
Writing intelligently...done
Rewriting...done
Reading with getc()...done
Reading intelligently...done
start 'em...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...done.
Create files in random order...done.
Stat files in random order...done.
Delete files in random order...done.
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
no               4G 20872  48 29348   7 11642   2 28080  60 27293   2 126.5   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16 +++++ +++ +++++ +++ +++++ +++ +++++ +++ +++++ +++ +++++ +++
no,4G,20872,48,29348,7,11642,2,28080,60,27293,2,126.5,0,16,+++++,+++,+++++,+++,+++++,+++,+++++,+++,+++++,+++,+++++,+++

$ time make -j4
real    2m33.293s
user    4m1.954s
sys     0m8.533s

-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
