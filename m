From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: smartd causing SATA timeouts on sleeping drives
Date: Mon, 8 Oct 2007 02:32:02 -0400
Message-ID: <76366b180710072332o159d2364i6fe5e0d5e28c0944@mail.gmail.com>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>
	 <4707ECF0.9030800@gmail.com>
	 <76366b180710072251i7af01faaqc18776d8f8f31ef9@mail.gmail.com>
	 <4709C8D6.3020008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:10058 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbXJHGcE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 02:32:04 -0400
Received: by rv-out-0910.google.com with SMTP id k20so679882rvb
        for <linux-ide@vger.kernel.org>; Sun, 07 Oct 2007 23:32:03 -0700 (PDT)
In-Reply-To: <4709C8D6.3020008@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Yes, the drives were in sleep mode. That is the only case where these
timeouts/resets occur. It seems like the "-n never" mode of smartd
should send the SRST if the drive is truly sleeping, otherwise libata
will soft reset the drive when it sees the timeout. The "-n standby"
option sounds like a more sane default, but there might be legacy
reasons why it isn't configured that way.

On 10/8/07, Tejun Heo <htejun@gmail.com> wrote:
> Andrew Paprocki wrote:
> > I found out after posting that this is governed by the -n parameter to
> > smartd. The default behavior is "-n never" which means smartd will
> > send the cmds regardless of the drive status. The man page indicates
> > that may cause the drive to spin-up to answer the cmds. It appears for
> > some drives (?) the cmds just timeout and libata performs a soft
> > reset. I'm going to change my setup to "-n standby", but it seems
> > strange to me that "-n never" is the default if it has this drastic of
> > a result (at least under Linux). Is there any way to know if the drive
> > will actually spin up as a result of the cmd instead of timing out?
>
> If in standby mode, the drive would automatically spin up to process
> command.  If in sleep mode, it needs SRST to spin back up.  Was your
> drive in sleep mode?
