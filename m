From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: [RESOLVED] Re: libata errors with smartctl on 2.6.24, WD3200AAKS
 and nVidia AHCI
Date: Thu, 15 May 2008 00:28:34 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0805150027090.15384@trinity.phys.uwm.edu>
References: <alpine.BSF.1.00.0805140952250.34461@anduin.net>
 <200805140905.29426.tvrtko@ursulin.net> <482AA37C.1020604@gmail.com>
 <20080514193648.GA10651@jim.sh> <482BB1B1.9060804@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1501667129-1258738859-1210829314=:15384"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.phys.uwm.edu ([129.89.57.159]:55629 "EHLO
	trinity.phys.uwm.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbYEOGZP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 May 2008 02:25:15 -0400
In-Reply-To: <482BB1B1.9060804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>, "Tvrtko A. Ursulin" <tvrtko@ursulin.net>, =?iso-8859-1?Q?Erik_Inge_Bols=F8?= <knan-ide@anduin.net>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1501667129-1258738859-1210829314=:15384
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

Gentlemen,

Please reproduce the problem, adding the command-line switch '-r ioctl,3' 
which shows return status of various commands, then send session 
transcript.

Cheers,
 	Bruce

On Thu, 15 May 2008, Tejun Heo wrote:

> Jim Paris wrote:
>> Tejun Heo wrote:
>>> Tvrtko A. Ursulin wrote:
>>>> On Wednesday 14 May 2008 08:58:56 Erik Inge Bolsø wrote:
>>>>> The drive does say
>>>>>
>>>>>         Enabled Supported:
>>>>>                 SMART feature set
>>>>>                 Security Mode feature set
>>>>>            *    Power Management feature set
>>>>>            *    Write cache
>>>>>            *    Look-ahead
>>>>> 
>>>>> ... so doesn't look like SMART is enabled on the drive.
>>>>> 
>>>>> Does the problem go away if you do a
>>>>> 
>>>>> smartctl -s on /dev/sda
>>>>> 
>>>>> first? :)
>>>> Indeed it does, shame on me for overseeing that small detail. :) 
>>> Oh... shame on me too.  :-)
>> 
>> Why didn't smartctl notice that?  In my experience it usually does
>> report when SMART is disabled.  Is the error not being properly
>> reported back to userspace maybe?  Tvrtko's original problem report
>> has lots of uninitialized (or leaked?) data, and a lot of it looks
>> like ASCII (for example his bogus RAW_VALUEs contain pieces of the
>> model number).
>
> Let's ask Bruce.  Bruce, SMART was disabled on WD3200AAKS but smartctl -a 
> didn't detect it and issued SMART commands anyway triggering timeouts.  Is 
> this expected behavior?  Or is libata feeding wrong status to smartctl?
>
> Thanks.
>
>
--1501667129-1258738859-1210829314=:15384--
