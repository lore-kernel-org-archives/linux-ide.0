From: Kamala Narasimhan <kamala.narasimhan@gmail.com>
Subject: AHCI related question
Date: Mon, 22 Nov 2010 16:43:17 -0500
Message-ID: <AANLkTi=++zEOaXoJ31m-ausDAf_HGGrz4p8i1qCw4em4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54052 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab0KVVnT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Nov 2010 16:43:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, jgarzik@pobox.com
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org

Thought I would request help from AHCI experts to solve an issue I
encounter.  Apologies in advance if this is not the right forum for
requesting such help.

Background - I am writing a minimal AHCI driver that would be invoked
within Xen environment upon a system crash.  It is minimal in the
sense it doesn't do much in the way of initializing the device,
setting up interrupts etc. as dom0 would take care of initialization
and we will be using it in polled mode with no interrupts, so no need
to setup interrupts.  Upon a system crash, I am able to get to abar
and HBA registers etc.  I am also able to map the relevant memory
regions appropriately within Xen and access it.  But, when I issue a
command by setting the relevant free slot specific bit in the port
command issue register (pxci), the bit I set for the slot in pxci is
not getting reset as it should upon successful execution of the
command.

As an experiment, I simply tried to stop/start the HBA engine by
setting the ST bit in the command register (PxCMD) to 0 but the CR, FR
bits etc. in PxCMD is not getting reset by the HBA upon ST reset as
expected.  It appears the HBA engine is not responding as it should.
If you can share any thought as to why the HBA is not responding
though the PCI space, abar, port registers etc. looks fine that would
be much appreciated.  Thanks!

Kamala
