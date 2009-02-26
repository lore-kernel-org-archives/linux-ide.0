From: Mark Lord <mlord@pobox.com>
Subject: hdparm-9.12 released
Date: Thu, 26 Feb 2009 13:22:00 -0500
Message-ID: <49A6DDC8.4080304@pobox.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbZBZSWH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Feb 2009 13:22:07 -0500
In-Reply-To: <1235600698-6446-1-git-send-email-matthew@wil.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>

hdparm-9.12 is now available for download from sourceforge.net.

Changes from 9.11 include:
   - added logical/physical sector size reporting
   - updated -I output with SATA-2.6 additions
   - support APM level retrieval with -B flag
   - updated -C output to match ATA8
   - added "form factor" and "rotation" display to -I,
          courtesy of Martin K.Petersen.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
