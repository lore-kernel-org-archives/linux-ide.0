From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCHSET] libata dbg scheme conversion, take 1
Date: Thu, 29 Jun 2006 18:09:12 +0200
Message-ID: <20060629160912.GA23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp103.plus.mail.re2.yahoo.com ([206.190.53.28]:12458 "HELO
	smtp103.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750822AbWF2QLQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:11:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

This patchset converts the relevant pieces of libata to the new debugging
scheme. Additionally, it adjusts the message level scheme to one appropriate for
libata. 

There are still places which use the old debugging macros but they have to be
dealt with on a case by case basis due to the functionality of the debugging
macros. Although most of the levels should be appropriately mapped, there might
still be some message level "skew" which can be dealt with in a later course.



		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

