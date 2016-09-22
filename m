From: Christoph Hellwig <hch@lst.de>
Subject: small libata cleanup
Date: Thu, 22 Sep 2016 07:49:48 -0700
Message-ID: <1474555790-8716-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33069 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757101AbcIVOtw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2016 10:49:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hi Tejun,

this series cleans up the few architecture libata-portmap.h headers we
have, and removes the odd asm-generic/libata-portmap.h one.

