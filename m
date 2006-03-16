From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
Subject: re: [PATCH] AHCI SATA vendor update from VIA
Date: Thu, 16 Mar 2006 07:07:40 +0100
Message-ID: <200603160707.40986.philipp.marek@bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.bmlv.gv.at ([193.171.152.37]:40870 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S932674AbWCPGIB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Mar 2006 01:08:01 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Jeff,


I'd like to confirm that the patch in your email from 2005-12-11 does indeed 
work for my vt8251 on an K8M800 motherboard.

It didn't apply cleanly to 2.6.15; I had to fix two rejects, and then comment 
out the two lines with
	.host_stop =
and
	.check_err =
to make it compile.


I'd like to ask you if that could have negative effects, and when the driver 
(part) will be included in the standard kernel.


Thank you for this patch. I'm looking forward to your answer.


Regards,

Phil
