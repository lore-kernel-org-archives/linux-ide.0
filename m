From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Subject: Re: HSM violation on bootup, ICH7 + ata_piix 2.6.22
Date: Mon, 10 Sep 2007 09:59:43 +0100
Message-ID: <1189414783.13360.16.camel@ukabzc383.uk.saic.com>
References: <46E254D7.5020902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpmx2.mail.saic.com ([139.121.17.172]:46132 "EHLO
	cpmx2.mail.saic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbXIJJAY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Sep 2007 05:00:24 -0400
In-Reply-To: <46E254D7.5020902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

> 
> Please disable or upgrade smartd.
> 

Thanks for that, I checked the disks and sure enough they were in an
extended self test, I aborted that and it's all back to normal.

the only problem, however, is that the system is already running version
5.37 of the smartmontools package, which is the most recent as I
understand it? I don't really want to leave the system with it's disks
unmonitored, is there anything I can be doing to prevent this behaviour?

Cheers,
Eamonn


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

