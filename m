From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RESOLVED] Re: libata errors with smartctl on 2.6.24,	WD3200AAKS
 and nVidia AHCI
Date: Thu, 15 May 2008 12:44:49 +0900
Message-ID: <482BB1B1.9060804@gmail.com>
References: <alpine.BSF.1.00.0805140952250.34461@anduin.net> <200805140905.29426.tvrtko@ursulin.net> <482AA37C.1020604@gmail.com> <20080514193648.GA10651@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:34077 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYEODo5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2008 23:44:57 -0400
Received: by wa-out-1112.google.com with SMTP id j37so269097waf.23
        for <linux-ide@vger.kernel.org>; Wed, 14 May 2008 20:44:56 -0700 (PDT)
In-Reply-To: <20080514193648.GA10651@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>, =?ISO-8859-1?Q?Erik_Inge_?= =?ISO-8859-1?Q?Bols=F8?= <knan-ide@anduin.net>, linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Jim Paris wrote:
> Tejun Heo wrote:
>> Tvrtko A. Ursulin wrote:
>>> On Wednesday 14 May 2008 08:58:56 Erik Inge Bols=F8 wrote:
>>>> The drive does say
>>>>
>>>>         Enabled Supported:
>>>>                 SMART feature set
>>>>                 Security Mode feature set
>>>>            *    Power Management feature set
>>>>            *    Write cache
>>>>            *    Look-ahead
>>>>
>>>> ... so doesn't look like SMART is enabled on the drive.
>>>>
>>>> Does the problem go away if you do a
>>>>
>>>> smartctl -s on /dev/sda
>>>>
>>>> first? :)
>>> Indeed it does, shame on me for overseeing that small detail. :)=20
>> Oh... shame on me too.  :-)
>=20
> Why didn't smartctl notice that?  In my experience it usually does
> report when SMART is disabled.  Is the error not being properly
> reported back to userspace maybe?  Tvrtko's original problem report
> has lots of uninitialized (or leaked?) data, and a lot of it looks
> like ASCII (for example his bogus RAW_VALUEs contain pieces of the
> model number).

Let's ask Bruce.  Bruce, SMART was disabled on WD3200AAKS but smartctl=20
-a didn't detect it and issued SMART commands anyway triggering=20
timeouts.  Is this expected behavior?  Or is libata feeding wrong statu=
s=20
to smartctl?

Thanks.

--=20
tejun
