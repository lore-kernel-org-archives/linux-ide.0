From: joystick <joystick@shiftmail.org>
Subject: TRIM / UNMAP read response
Date: Fri, 12 Aug 2011 15:28:14 +0200
Message-ID: <4E452A6E.4040809@shiftmail.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blade3.isti.cnr.it ([194.119.192.19]:50722 "EHLO
	BLADE3.ISTI.CNR.IT" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab1HLNyz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Aug 2011 09:54:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>

Hi all IDE and SCSI ml's,

is it guaranteed by the standards that reading from a device a region 
that has been TRIMmed (IDE) or UNMAPped (SCSI) will certainly return zeroes?

Thank you
