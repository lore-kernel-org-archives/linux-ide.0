From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 0/7] sata_mv: assorted fixes
Date: Fri, 19 May 2006 16:13:59 -0400
Message-ID: <200605191614.00023.liml@rtr.ca>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:31463 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964809AbWESUOB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 16:14:01 -0400
In-Reply-To: <446DEE92.50102@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

The following seven patches contain various fixes and cleanups for
the libata Marvell SATA driver sata_mv.c taken from my internal tree.

These fixes have reportedly solved many problems for a number of
different users.  The driver is still HIGHLY EXPERIMENTAL, at least until
more people exercise this latest driver and report on success/issues.

Cheers

Mark
