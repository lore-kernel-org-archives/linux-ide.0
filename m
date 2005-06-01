From: Tobias Reinhard <tracer@robotech.de>
Subject: Problem with concurrent SATA-Writes
Date: Wed, 01 Jun 2005 19:13:06 +0200
Message-ID: <429DECA2.6020609@robotech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutvdom.kundenserver.de ([212.227.126.249]:2030 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261473AbVFARNL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Jun 2005 13:13:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello Jeff, hello to the linux-ide-list!

I already posted this to the lkml, but unfortunately I got no usefull 
answer. I think the problem is related to the SIL-Driver so maybe you 
are the right person to contact - or someone at the linux-ide-list...

If you need any other informations or logs please tell me. I really want 
to use these discs.

Tobias

Original Msg:
--------
I have a problem with two SATA-Discs. I have an onboard SIL3114 with
four SATA-Ports an onboard NVIDIA with two SATA-Ports - both controllers
are disable via BIOS (and are not detected by Linux)(only for this test
of course - normally I have other HDD on this ports). The only
controller that is found is the add-on controller in a PCI-Slot
(SIL3112). And that is the one I have trouble with.

If I read or write  (via dd) from the first one -> no problems. Same
when read or write from the second or when I read (only read!) from both
at the same time. Data-Transfer-Rate is around 45MB/s for each HDD.

The problem occures when I try to write on both discs at the same time.
For example I write /dev/zero to the first one and then start to write
/dev/zero to the second one. The System-Load goes up to 4 with nearly
100% io-wait and nearly no write-access to the drives.

Any hints?

- no errormessages in syslog
- happens with Kernel 2.6.11.7 and with 2.6.12-rc5
- HDDs are Samsung Spinpoint 200GB
- (I use the SCSI-SATA-Drivers)

