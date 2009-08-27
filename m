From: Jens Axboe <jens.axboe@oracle.com>
Subject: [PATCH 0/3] Convert libata pio task to slow-work
Date: Thu, 27 Aug 2009 11:08:39 +0200
Message-ID: <1251364122-9592-1-git-send-email-jens.axboe@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:45798 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbZH0JJA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Aug 2009 05:09:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: tj@kernel.org, alan@lxorguk.ukuu.org.uk, jeff@garzik.org, dhowells@redhat.com

Hi,

This patchset adds support for slow-work for delayed slow work and
for cancelling slow work. Note that these patches are totally
untested!

-- 
Jens Axboe

