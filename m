From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: smartd causing SATA timeouts on sleeping drives
Date: Wed, 10 Oct 2007 14:39:26 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0710101435340.4797@trinity.phys.uwm.edu>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>
 <4707ECF0.9030800@gmail.com>  <76366b180710072251i7af01faaqc18776d8f8f31ef9@mail.gmail.com>
  <4709C8D6.3020008@gmail.com> <76366b180710072332o159d2364i6fe5e0d5e28c0944@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.phys.uwm.edu ([129.89.57.159]:60939 "EHLO
	trinity.phys.uwm.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755267AbXJJTjj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 15:39:39 -0400
In-Reply-To: <76366b180710072332o159d2364i6fe5e0d5e28c0944@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, Andrew Paprocki <andrew@ishiboo.com>, linux-ide@vger.kernel.org

Tejun,

Hmm, it sounds as if smartmontools should send a SRST to spin up the 
drive, but I do not know enough to be sure.

Could I add you to the developers list and give you CVS write access? 
This might make it easier for you to fix the various little smartmontools 
problems like this that keep cropping up!  Just fixing the code might be a 
lot faster than explaining it and sending patches...

If this is OK with you, please send me your sourceforge username, and I'll 
add you to the developers list.

Cheers,
 	Bruce


On Mon, 8 Oct 2007, Andrew Paprocki wrote:

> Yes, the drives were in sleep mode. That is the only case where these
> timeouts/resets occur. It seems like the "-n never" mode of smartd
> should send the SRST if the drive is truly sleeping, otherwise libata
> will soft reset the drive when it sees the timeout. The "-n standby"
> option sounds like a more sane default, but there might be legacy
> reasons why it isn't configured that way.
>
> On 10/8/07, Tejun Heo <htejun@gmail.com> wrote:
>> Andrew Paprocki wrote:
>>> I found out after posting that this is governed by the -n parameter to
>>> smartd. The default behavior is "-n never" which means smartd will
>>> send the cmds regardless of the drive status. The man page indicates
>>> that may cause the drive to spin-up to answer the cmds. It appears for
>>> some drives (?) the cmds just timeout and libata performs a soft
>>> reset. I'm going to change my setup to "-n standby", but it seems
>>> strange to me that "-n never" is the default if it has this drastic of
>>> a result (at least under Linux). Is there any way to know if the drive
>>> will actually spin up as a result of the cmd instead of timing out?
>>
>> If in standby mode, the drive would automatically spin up to process
>> command.  If in sleep mode, it needs SRST to spin back up.  Was your
>> drive in sleep mode?
>
