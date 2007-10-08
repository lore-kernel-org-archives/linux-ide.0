From: Tejun Heo <htejun@gmail.com>
Subject: Re: smartd causing SATA timeouts on sleeping drives
Date: Mon, 08 Oct 2007 15:06:14 +0900
Message-ID: <4709C8D6.3020008@gmail.com>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>	 <4707ECF0.9030800@gmail.com> <76366b180710072251i7af01faaqc18776d8f8f31ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:40607 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbXJHGGn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 02:06:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1548842wah
        for <linux-ide@vger.kernel.org>; Sun, 07 Oct 2007 23:06:42 -0700 (PDT)
In-Reply-To: <76366b180710072251i7af01faaqc18776d8f8f31ef9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Andrew Paprocki wrote:
> I found out after posting that this is governed by the -n parameter to
> smartd. The default behavior is "-n never" which means smartd will
> send the cmds regardless of the drive status. The man page indicates
> that may cause the drive to spin-up to answer the cmds. It appears for
> some drives (?) the cmds just timeout and libata performs a soft
> reset. I'm going to change my setup to "-n standby", but it seems
> strange to me that "-n never" is the default if it has this drastic of
> a result (at least under Linux). Is there any way to know if the drive
> will actually spin up as a result of the cmd instead of timing out?

If in standby mode, the drive would automatically spin up to process
command.  If in sleep mode, it needs SRST to spin back up.  Was your
drive in sleep mode?

-- 
tejun
