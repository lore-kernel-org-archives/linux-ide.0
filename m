From: David Daney <ddaney@caviumnetworks.com>
Subject: ata_pio_need_iordy vs. CF spec. V4.1
Date: Mon, 24 Nov 2008 09:40:10 -0800
Message-ID: <492AE6FA.5000809@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:63798 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbYKXRkz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 12:40:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Table 22 on page 51 of CF Specification Rev. 4.1 indicates that iordy is 
not supported in PIO5 and PIO6.  This seems to be in conflict with the 
code in ata_pio_need_iordy, which asserts that it is mandatory in any 
mode greater than PIO2.

Which is correct?  Or am I misreading something?


Thanks,
David Daney
