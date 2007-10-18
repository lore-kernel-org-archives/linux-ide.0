From: Vlad Codrea <vladc6@yahoo.com>
Subject: Re: Please help. ICH6 chipset: dvd drive dies after a short time
Date: Thu, 18 Oct 2007 11:48:03 -0700 (PDT)
Message-ID: <619868.86645.qm@web54407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web54407.mail.yahoo.com ([206.190.49.137]:38302 "HELO
	web54407.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757857AbXJRSyp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 14:54:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: h292@ied.com
Cc: linux-ide@vger.kernel.org

Hi,

I would suggest doing the following things:

1) Download the latest kernel (2.6.23 or later).
2) Enable libata and disable ide in the kernel's .config file before
compiling.
3) Attach the dmesg to a new bug report in the kernel bugzilla
(http://bugzilla.kernel.org).
4) Send a link to the bug report as a followup to this message.

Hope this helps,
Vlad


      ____________________________________________________________________________________
Check out the hottest 2008 models today at Yahoo! Autos.
http://autos.yahoo.com/new_cars.html
