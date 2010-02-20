From: Asdo <asdo@shiftmail.org>
Subject: Re: How to reread disk size?
Date: Sun, 21 Feb 2010 00:49:04 +0100
Message-ID: <4B8074F0.5070507@shiftmail.org>
References: <4B7F234F.9000107@shiftmail.org> <4B802BDF.9020509@gmail.com>
 <4B805487.2010900@shiftmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blade3.isti.cnr.it ([194.119.192.19]:53503 "EHLO
	BLADE3.ISTI.CNR.IT" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756938Ab0BTXtS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Feb 2010 18:49:18 -0500
Received: from conversionlocal.isti.cnr.it by mx.isti.cnr.it
 (PMDF V6.5-b2 #31825) id <01NJWM19R8OWBF3TET@mx.isti.cnr.it> for
 linux-ide@vger.kernel.org; Sun, 21 Feb 2010 00:49:10 +0100
In-reply-to: <4B805487.2010900@shiftmail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Asdo wrote:
> [...]
> It rereads the wrong size, i.e. the one of the old disk :-(
> I am sure sdr is the correct disk, I even identified it by doing dd 
> if=/dev/sdr of=/dev/null and then looking at the activity led to 
> confirm it's the right drive. It should have read a size of 1TB.

I can also add that smartctl -a /dev/sdr reads the CORRECT size...
(but it does not update the size in the linux's block device obviously)

:-( ...
