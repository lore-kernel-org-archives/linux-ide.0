From: "Ian Atkin" <ian.atkin@ict.ox.ac.uk>
Subject: Compiling ahci.c as a module for the 2.6.18.8 kernel
Date: Tue, 27 Jan 2009 12:19:36 -0000
Message-ID: <02c701c98079$852d0c90$d1664381@oucsiana2>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback0.mail.ox.ac.uk ([129.67.1.175]:38260 "EHLO
	fallback0.mail.ox.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbZA0NQW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 08:16:22 -0500
Received: from relay9.mail.ox.ac.uk ([163.1.2.169])
	by fallback0.mail.ox.ac.uk with esmtp (Exim 4.69)
	(envelope-from <ian.atkin@ict.ox.ac.uk>)
	id 1LRn3u-0001u2-1l
	for linux-ide@vger.kernel.org; Tue, 27 Jan 2009 12:29:02 +0000
Received: from smtp0.mail.ox.ac.uk ([129.67.1.205])
	by relay9.mail.ox.ac.uk with esmtp (Exim 4.69)
	(envelope-from <ian.atkin@ict.ox.ac.uk>)
	id 1LRmui-0006LZ-T8
	for linux-ide@vger.kernel.org; Tue, 27 Jan 2009 12:19:32 +0000
Received: from oucs-iana2.oucs.ox.ac.uk ([129.67.102.209] helo=oucsiana2)
	by smtp0.mail.ox.ac.uk with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <ian.atkin@ict.ox.ac.uk>)
	id 1LRmuh-0002I7-2H
	for linux-ide@vger.kernel.org; Tue, 27 Jan 2009 12:19:31 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I am trying to compile ahci.c as a loadable module for the 2.6.18.8 kernel
which I used a PXE environment. This is so that I can see disks on the new
generation of hardware coming out with the ICH10 SATA controllers.

I've downloaded my Linux 2.6.28 source, and have tried compiling the ahci
module against the 2.6.18.8 source tree, by the following steps:

1) Built the 2.6.18.8 kernel with modules
   `make bzImage modules`

2) grabbed the ata folder from /usr/src/linux-2.6.28/drivers and tried
compiling against the /usr/src/linux-2.6.18.28 source,
  `make -C /usr/src/linux-2/6/18/8 SUBDIRS=$PWD modules`

  make: Entering directory `/usr/src/linux-2.6.18.8'
  Building modules, stage 2
  MODPOST
  make: Leaving directory `/usr/src/linux-2.6.18.8'

I just can't appear to build the module -the ata folder doesn't appear to
have been touched. I used to use Linux a long time ago, and have never been
expert.  Apologies in advance if this is a dummy post.

Kind Regards,
Ian./

