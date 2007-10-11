From: Tejun Heo <htejun@gmail.com>
Subject: Re: smartd causing SATA timeouts on sleeping drives
Date: Thu, 11 Oct 2007 11:02:35 +0900
Message-ID: <470D843B.3030405@gmail.com>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>  <4707ECF0.9030800@gmail.com>  <76366b180710072251i7af01faaqc18776d8f8f31ef9@mail.gmail.com>  <4709C8D6.3020008@gmail.com> <76366b180710072332o159d2364i6fe5e0d5e28c0944@mail.gmail.com> <Pine.LNX.4.63.0710101435340.4797@trinity.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:28933 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbXJKCCm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 22:02:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so354031rvb
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 19:02:41 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0710101435340.4797@trinity.phys.uwm.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, Andrew Paprocki <andrew@ishiboo.com>, linux-ide@vger.kernel.org

Hello, Bruce.

Bruce Allen wrote:
> Hmm, it sounds as if smartmontools should send a SRST to spin up the
> drive, but I do not know enough to be sure.

Eh... Now that I think about it.  I don't think there's a way to work
around this from userland.  smartmontools doesn't know the current power
mode (sleeping drive doesn't even respond to CHECK POWER MODE), so it
can't determine whether the device needs SRST or not and issuing SRST
unconditionally would cause a lot more problems.

Maybe what should be done is to track sleep mode in libata and issue
SRST automatically if a command is issued to a sleeping drive.  I'll
work on it.

> Could I add you to the developers list and give you CVS write access?
> This might make it easier for you to fix the various little
> smartmontools problems like this that keep cropping up!  Just fixing the
> code might be a lot faster than explaining it and sending patches...
> 
> If this is OK with you, please send me your sourceforge username, and
> I'll add you to the developers list.

I'll stay chicken for the time being and only send patches.  :-)

Thanks.

-- 
tejun
