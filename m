From: Matt Kowalczyk <matt.kowalczyk@gmail.com>
Subject: array failure
Date: Thu, 24 Dec 2009 22:34:47 -0800
Message-ID: <4B345D07.7020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:40964 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbZLYGeM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Dec 2009 01:34:12 -0500
Received: by ywh6 with SMTP id 6so8809402ywh.4
        for <linux-ide@vger.kernel.org>; Thu, 24 Dec 2009 22:34:11 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Can anyone help me better understand these messages? I'm trying to 
determine the cause of the failure, cable, hd, disk controller, etc? The 
below is what appears when I reset the disk array,

Dec 24 22:31:40 atlas kernel: [ 1485.045504] ata2: hard resetting link
Dec 24 22:31:42 atlas kernel: [ 1487.447432] ata2: SATA link up 3.0 Gbps 
(SStatus 123 SControl 0)
Dec 24 22:31:42 atlas kernel: [ 1487.699172] ata2.15: qc timeout (cmd 0xe8)
Dec 24 22:31:42 atlas kernel: [ 1487.722552] ata2: failed to recover 
some devices, retrying in 5 secs
Dec 24 22:31:47 atlas kernel: [ 1492.718316] ata2: hard resetting link
Dec 24 22:31:49 atlas kernel: [ 1494.916202] ata2: SATA link up 3.0 Gbps 
(SStatus 123 SControl 0)
Dec 24 22:31:50 atlas kernel: [ 1495.167944] ata2.15: qc timeout (cmd 0xe4)
Dec 24 22:31:50 atlas kernel: [ 1495.179404] ata2: failed to recover 
some devices, retrying in 5 secs
Dec 24 22:31:55 atlas kernel: [ 1500.175099] ata2: hard resetting link
Dec 24 22:31:57 atlas kernel: [ 1502.372985] ata2: SATA link up 3.0 Gbps 
(SStatus 123 SControl 0)
Dec 24 22:31:57 atlas kernel: [ 1502.624727] ata2.15: qc timeout (cmd 0xe4)
Dec 24 22:31:57 atlas kernel: [ 1502.639478] ata2: failed to recover 
some devices, retrying in 5 secs
Dec 24 22:32:02 atlas kernel: [ 1507.635876] ata2: hard resetting link
Dec 24 22:32:04 atlas kernel: [ 1509.833763] ata2: SATA link up 3.0 Gbps 
(SStatus 123 SControl 0)
Dec 24 22:32:04 atlas kernel: [ 1509.833798] ata2: EH complete

Thanks,
Matt

