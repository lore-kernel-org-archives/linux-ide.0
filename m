From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: libata default FUA support
Date: Tue, 1 Mar 2011 21:33:13 +0100
Message-ID: <20110301203313.GA1656@gentoo.trippels.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ud10.udmedia.de ([194.117.254.50]:39337 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459Ab1CAUdP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2011 15:33:15 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

FUA support is currently switched off by default in
drivers/ata/libata-core.c. 
Given that many modern drives do support FUA now, wouldn't it make sense
to switch it on without setting a (undocumented) kernel/module
parameter?
-- 
Markus
