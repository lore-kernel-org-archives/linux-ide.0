From: Leon Woestenberg <leonw@mailcan.com>
Subject: IDE layer adoptations that *fake* a failing drive?
Date: Fri, 14 May 2004 22:50:31 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A53117.1020305@mailcan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:16865 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S262766AbUENUue (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 16:50:34 -0400
Received: from mailcan.com (t-indiv3-100.athome.tue.nl [131.155.240.100])
	by www.fastmail.fm (Postfix) with ESMTP id 0F839B7A30C
	for <linux-ide@vger.kernel.org>; Fri, 14 May 2004 16:50:31 -0400 (EDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I wondered if anyone here is aware of code that sits between the IDE
software layer and the storage device, that emulates a failing disk in 
one way or another.

I.e. for example, write multiple re-tries with time-outs, checksum
errors, failing to complete read/writes to medium etc.

 From my networking stuff, I know there are network simulators that you
can provoke to simulate all kind of network traffic abnormalities, such
as congestion, dupes, lost packets, bursting.

I have access to only a limited number of really bad disks, and want to
do stress tests against fully automatically managed software RAID arrays
under Linux (except for the part where you have to physically swap 
defect disks :-)

Ciao,

Leon.
