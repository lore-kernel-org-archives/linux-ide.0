From: Bart Hartgers <bart.hartgers@gmail.com>
Subject: [patch 0/1] [PATCH v2] sata_via: Delay on vt6420 when starting ATAPI DMA write
Date: Sun, 14 Feb 2010 13:04:49 +0100
Message-ID: <20100214120449.503204189@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60562 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429Ab0BNMIV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Feb 2010 07:08:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hi Jeff,

As promised, here is the updated patch to fix the vt6420 ATAPI
corruption. It applies on top of my previous patch for the vt6421 PATA
DMA fix.

Sorry for sending this as a quilt patchset of one, but it is the only
reliable way I know to send patches through gmail unharmed.

Groeten,
Bart
-- 
