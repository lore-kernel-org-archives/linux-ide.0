From: Ian Leonard <ian@smallworld.cx>
Subject: Highpoint & ide probing problem
Date: Wed, 15 Sep 2004 08:23:09 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4147EDDD.8030001@smallworld.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta09-svc.ntlworld.com ([62.253.162.49]:21118 "EHLO
	mta09-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262071AbUIOHXL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Sep 2004 03:23:11 -0400
Received: from [172.16.0.1] ([81.106.214.74]) by mta09-svc.ntlworld.com
          (InterMail vM.4.01.03.37 201-229-121-137-20020806) with ESMTP
          id <20040915072414.FHSS1100.mta09-svc.ntlworld.com@[172.16.0.1]>
          for <linux-ide@vger.kernel.org>; Wed, 15 Sep 2004 08:24:14 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Greetings,

WI have an itox motherboard with an hpt 370/372 chip and a sata raid 
chip. I am trying to use the Highpoint but not the sata. We need to 
access 4 drives individually not as a raid.

On booting, the HPT bios sees all 4 drives. Linux only sees 2 (hdi & 
hdj). If I play around with the sata bios configuration (change from 
auto to enhanced mode) Linux sees hde and hdf.

I have tried kernel versions 2.4.27 and 2.4.28-pre1. I have also 
downloaded the relevant Highpoints driver and this works. However it 
uses the scsi interface which is not what I want.

Any ideas? Thanks.




-- 
Ian Leonard

Please ignore spelling and punctuation - I did.
