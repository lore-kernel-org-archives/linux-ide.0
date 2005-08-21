From: Jeff Garzik <jgarzik@pobox.com>
Subject: A note on libata passthru patch
Date: Sun, 21 Aug 2005 17:37:18 -0400
Message-ID: <4308F40E.3010109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:488 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751146AbVHUVhW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:37:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Mark Lord <mlord@pobox.com>


Something that Alan unintentionally reminded me, about the libata 
passthru patch:  Some controllers require certain ATA commands to be 
synchronized at the host-wide level.

An example is SET FEATURES - XFER MODE on Promise controllers.  The 
controller snoops the taskfile for the xfer mode, and uses that info to 
program certain timing-related registers.  If you issue a SET FEATURES - 
XFER MODE command on one port while doing data xfer on another port, 
then data corruption can occur.

I'm pretty sure at least one other controller does similar taskfile 
snooping.

Currently probing is 100% synchronous, so our internal use of SET 
FEATURES - XFER MODE is safe.  But when you turn on ATA passthru, it is 
not safe.

This is another issue that needs fixing before we can merge the ATA 
passthru feature, since the consequences can be serious.

	Jeff



