From: Marc D Ronell <mronell@alumni.upenn.edu>
Subject: Kernel config question on Hitachi HTS541080G9SA00, Intel 945pm
 Express, SATA drive on Dell e1505 Inspiron
Date: Mon, 13 Nov 2006 21:22:09 -0500
Message-ID: <873b8mrcmm.fsf@corps.glidepath.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:56963 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1755408AbWKNDHn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Nov 2006 22:07:43 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Gjobf-0000kI-6L
	for linux-ide@vger.kernel.org; Tue, 14 Nov 2006 04:05:03 +0100
Received: from pool-71-162-110-87.bstnma.east.verizon.net ([71.162.110.87])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 04:05:03 +0100
Received: from mronell by pool-71-162-110-87.bstnma.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 04:05:03 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

Is  it currently  possible  to configure  a linux  kernel to  directly
(without an  initrd image) boot  from a Hitachi  HTS541080G9SA00 drive
which I believe is a SATA-I serial ATA drive.  I believe my machine is
using an Intel 945pm chipset to drive the hard drive.  

I think  the setup should  use the AHCI  driver in libata, but  I have
tried  a  variety  of  permutations  with no  success  so  far.  (like
2.6.19-rcx)

The  box currently boots  a Debian  Sarge distribution  (kernel 2.6.8)
using an hda ide disk configuration (as opposed to an sda), but I need
a more recent kernel version to get drivers for other devices working.

Thanks for any help and suggestions,

Marc


-- 



