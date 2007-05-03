From: "Jeroen Janssen" <jeroen.janssen@gmail.com>
Subject: VIA VT6420 SATA suspend/resume problem in 2.6.20?
Date: Thu, 3 May 2007 14:42:59 +0200
Message-ID: <e34e42440705030542r1574dfdre143e2d43edd44d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:1610 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031057AbXECMnB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2007 08:43:01 -0400
Received: by wr-out-0506.google.com with SMTP id 76so503724wra
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2007 05:43:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have a board with a VIA 6420 chipset and a SATA harddisk running on
2.6.20 (Fedora Core 6).

When I suspend the system, it goes to sleep instantly, but when I
wakeup the system, it takes about 2 x 30 seconds for the SATA disk to
be accessable again.

I searched the mailinglist and could not really find if this is a
known problem (although I noticed that there's some work going on in
the acpi power management).

Does anyone if this is a known problem? (and if so, is there a
solution available?)
How can I pinpoint the exact problem?

If you need any specific logging, just let me know and I'll provide them.

Best regards,

Jeroen Janssen
