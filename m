From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Subject: Regressions in sata_nv regarding STANDYBY IMMEDIATE.
Date: Wed, 25 Apr 2012 09:12:33 +0200
Message-ID: <1335337953.2409.17.camel@donpedro>
Reply-To: donpedro@tdcadsl.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cicero-fbr1.cybercity.dk ([212.242.40.5]:50825 "EHLO
	cicero-fbr1.cybercity.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab2DYHy5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2012 03:54:57 -0400
Received: from smtp2.cybercity.dk (smtp2.cybercity.dk [212.242.43.252])
	by cicero-fbr1.cybercity.dk (Postfix) with ESMTP id 19D753D8976
	for <linux-ide@vger.kernel.org>; Wed, 25 Apr 2012 09:13:40 +0200 (CEST)
Received: from uf7.cybercity.dk (uf7.cybercity.dk [212.242.42.164])
	by smtp2.cybercity.dk (Postfix) with ESMTP id 83458313C7E
	for <linux-ide@vger.kernel.org>; Wed, 25 Apr 2012 09:12:33 +0200 (CEST)
Received: from [10.0.0.5] (0x5552d9d4.adsl.cybercity.dk [85.82.217.212])
	(Authenticated sender: dsl549800)
	by uf7.cybercity.dk (Postfix) with ESMTPA id 71B54B85E91
	for <linux-ide@vger.kernel.org>; Wed, 25 Apr 2012 09:12:33 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

Recent kernels broke suspend/hibernate completely on one of my setups
after updating to more recent kernels (3.3). It used to work perfectly
and the machine was hardly ever powered completely off (standby).
(older M2N-E ASUS motherboard with nvidia MC55 controller).

The symptoms where that the system would hang entering hibernate. The
only complaint from the system was that command STANDBY_IMMEDIATE had
failed.

At first i assumed that the disk (an older WD Green disk) was dying, and
replaced the disk with a cheap Seagate disk. However, this turned out
not to be the case.

Looking through the ATA code i found that STANDBY had been replaced with
STANDBY_IMMEDIATE as it was supposed to be more compliant. Replacing it
with the old STANDBY made the standby procedure work again.

Now the question is: The STANDBY and STANDBY_IMMEDIATE commands are for
the disk. Why does it specifically break for disks on MCP55 and not on
other chipsets? Does it make sense?

FWIW both disks seem to suspend fine on the same controller using an
other O/S.

Later i also discovered that the new disk actually made things worse.
Using the hack suspend worked again for the old disk. The new disk could
now suspend but would mostly get stuck getting out of suspend as it
would seem that the system caused it to stop responding all together
requiring a hard reboot.

Any ideas?

Thanks,

/pedro



