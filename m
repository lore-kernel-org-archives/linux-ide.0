From: Andy Warner <andyw@pobox.com>
Subject: WARN_ON(buflen > PAGE_SIZE) libata-core.c
Date: Wed, 1 Sep 2004 15:08:01 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040901150801.A12145@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:13022 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S267625AbUIAUJt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Sep 2004 16:09:49 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

I'm working on a tree pulled directly from
bk://gkernel.bkbits.net/libata-2.6

In libata-core.c:ata_sg_init_one() there is:

	WARN_ON(buflen > PAGE_SIZE);

Which (unsurpsingly) triggers for all non-tiny
transfers (I'm using sg_utils to generate disk
traffic.)

It's obviously there for a reason, what would
I need to do to get past it. Give me some background
and maybe I can come up with a patch :)
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
