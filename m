From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Subject: Re: Sil3114 and Hitachi disks
Date: Fri, 24 Dec 2004 18:20:18 +0100 (CET)
Message-ID: <Pine.LNX.4.44.0412241621210.16199-100000@kenzo.iwr.uni-heidelberg.de>
References: <Pine.LNX.4.44.0412231608150.10539-100000@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.uni-heidelberg.de ([129.206.100.212]:7923 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261413AbULXRUV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Dec 2004 12:20:21 -0500
Received: from mail.iwr.uni-heidelberg.de (mail.iwr.uni-heidelberg.de [129.206.104.30])
	by relay.uni-heidelberg.de (8.12.10/8.12.10) with ESMTP id iBOHKhfK004251
	for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2004 18:20:44 +0100 (MET)
Received: from kenzo.iwr.uni-heidelberg.de (IDENT:CCna4PoBrwXr3bLJoViCxFIZSrwzL3IA@kenzo.iwr.uni-heidelberg.de [129.206.120.29])
	by mail.iwr.uni-heidelberg.de (8.12.11/8.12.11) with ESMTP id iBOHKJhU025957
	for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2004 18:20:19 +0100 (MET)
Received: from kenzo.iwr.uni-heidelberg.de (localhost.localdomain [127.0.0.1])
	by kenzo.iwr.uni-heidelberg.de (8.12.11/8.12.11) with ESMTP id iBOHKJUH017035
	for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2004 18:20:19 +0100
Received: from localhost (bogdan@localhost)
	by kenzo.iwr.uni-heidelberg.de (8.12.11/8.12.11/Submit) with ESMTP id iBOHKJp3017031
	for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2004 18:20:19 +0100
In-Reply-To: <Pine.LNX.4.44.0412231608150.10539-100000@kenzo.iwr.uni-heidelberg.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Thu, 23 Dec 2004, Bogdan Costescu wrote:

> I see some data corruption with a Sil3114 controller and some Hitachi
> disks and I wanted to ask if I'm the only one ( =if I have some broken
> disks...)

More data:
- using a UP or a SMP x86_64 kernel doesn't make any difference.
- adding this model of Hitachi disks to the blacklist of sata_sil in 
the same way as the Seagate disks (mod15 bug) reduces the speed, but 
does not fix the misbehaviour, when using the x86_64 kernel.
- the Hitachi disks behave well if connected to a standalone Sil3114 
controller in a 32-bit computer running a SMP athlon kernel.
- the Hitachi disks behave well if I use the original hardware setup 
(dual Opteron), but run the SMP athlon kernel and 32-bit userland.
- when moving a disk with a corrupted FS (checked with e2fsck -n) from 
a x86_64 kernel to an athlon kernel, the corruption is still found by 
e2fsck. When moving a disk with a non-corrupted FS from an athlon 
kernel to x86_64, e2fsck does not find any problem.

So, I come to the following conclusions:
- my Hitachi disks are not broken, therefore my suggestion of 
blacklisting is unfounded.
- the combination of x86_64 kernel, sata_sil and the Hitachi disks is
not good; the corruption seems to appear while writting to disk.  
Unfortunately, I don't have any other SATA disks with lba48, so I
can't test if this is a more general lba48 problem or restricted to
this specific Hitachi model.

Please let me know if I can provide more data for fixing this.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

