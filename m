From: Lalatendu Das <ldas4tux@gmail.com>
Subject: Synchronizing the resume/suspend/remove routine with Driver's IO path
Date: Tue, 7 Sep 2010 11:43:09 -0600
Message-ID: <AANLkTikKKeESxOfzg-6zAXEG1BY-JyqFmXYoQodR8bfG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:49509 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab0IGRnK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Sep 2010 13:43:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-newbie@vger.kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org

Hi All,
I am newbie to Linux's power management subsystem. I saw a comment
stating that the execution suspend()/ resume callback function can
sleep.

Say for example an AHCI driver is executing its suspend call back and
just after shutting down the DMA engines / releasing all Block layer
links, the suspend() call goes to sleep and the driver's IO path
execution thread  woke up to execute. I assume this possible because
both suspend() call path and driver';s IO execution path are
independent and not synchronized.

Doesn't the driver In such scenario may do some wrong memory reference
which released by sleeping suspend() thread right?? or H/W access will
return error even though the card is not removed or gone bad which is
not desired ??

Shouldn't we synchronize the driver and remove.suspend, resume() callbacks ?

Please Let me know If i am gone wrong some where. Any pointers to read
will be great.

Thanks in advance.
LD
