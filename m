From: Yan Seiner <yan@seiner.com>
Subject: Making disk activity LEDs flash on demand
Date: Sat, 06 Dec 2008 06:41:40 -0800
Message-ID: <493A8F24.3010504@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:57132 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964AbYLFOll (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Dec 2008 09:41:41 -0500
Received: from www.seiner.com ([192.168.128.6] ident=yan)
	by www.seiner.com with esmtp (Exim 4.69)
	(envelope-from <yan@seiner.com>)
	id 1L8yLk-0006Ay-Eq
	for linux-ide@vger.kernel.org; Sat, 06 Dec 2008 06:41:40 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Does anyone know of a way to make a disk activity LED flash on demand?  
My server has 11 drives connected ATM with more to come.  These are 
connected in a variety of ways - 2 SCSI drives, 6 SATA drives plugged 
directly into the mobo, and 3 via port multipliers.

All of these drives are in various softRAID arrays.  I'd like to be able 
to identify a specific drive via software, so that when a drive is 
overheating or failing I can pull just that drive, instead of going 
through the 'Let's pull this one and see if that's right' routine.

Long ago I had a hardware RAID controller that could do just that.  You 
could tell it to id a specific drive and it would flash that LED.  Is 
there any way to do that?

--Yan
