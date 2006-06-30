From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCHSET] libata dbg scheme conversion, take 2
Date: Fri, 30 Jun 2006 08:44:21 +0200
Message-ID: <20060630064421.GA17127@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp104.plus.mail.re2.yahoo.com ([206.190.53.29]:53685 "HELO
	smtp104.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751202AbWF3GqG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 02:46:06 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

This patchset converts the relevant pieces of libata to the new debugging
scheme. Additionally, it adjusts the message level scheme to one appropriate for
libata. In this second version, the EH is in the default msg level and
ATA_MSG_DEBUG category is introduced to reflect the need for separation of verbose 
but not too frequent messages from SG/CMD/TRACE ones.

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

