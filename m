From: Mark Lord <mlord@pobox.com>
Subject: hdparm-8.2 now available
Date: Mon, 18 Feb 2008 19:25:20 -0500
Message-ID: <47BA21F0.90405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbYBSAZn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 19:25:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, ballen@gravity.phys.uwm.edu, Ric Wheeler <ric@emc.com>

hdparm for SATA/PATA has now been updated to version 8.2.
 
Upgrading is strongly recommended for all users.
This version fixes several bugs in earlier 7.x/8.x releases
that could cause issues when advanced features are attempted
on devices being driven by the old drivers/ide subsystem.

libata devices were unaffected, but drivers/ide devices could
misbehave or even be corrupted by some operations.

hdparm-8.2 is available at http://sourceforge.net/projects/hdparm/ 

Upgrading from any earlier 7.x or 8.x version
is strongly recommended for all users.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
