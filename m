From: Jim Paris <jim@jtan.com>
Subject: Re: [RESOLVED] Re: libata errors with smartctl on 2.6.24,
	WD3200AAKS and nVidia AHCI
Date: Wed, 14 May 2008 15:36:48 -0400
Message-ID: <20080514193648.GA10651@jim.sh>
References: <alpine.BSF.1.00.0805140952250.34461@anduin.net> <200805140905.29426.tvrtko@ursulin.net> <482AA37C.1020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:58066 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762737AbYENTrq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 15:47:46 -0400
Content-Disposition: inline
In-Reply-To: <482AA37C.1020604@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>, Erik Inge =?iso-8859-1?Q?Bols=F8?= <knan-ide@anduin.net>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Tvrtko A. Ursulin wrote:
>> On Wednesday 14 May 2008 08:58:56 Erik Inge Bols=F8 wrote:
>>> The drive does say
>>>
>>>         Enabled Supported:
>>>                 SMART feature set
>>>                 Security Mode feature set
>>>            *    Power Management feature set
>>>            *    Write cache
>>>            *    Look-ahead
>>>
>>> ... so doesn't look like SMART is enabled on the drive.
>>>
>>> Does the problem go away if you do a
>>>
>>> smartctl -s on /dev/sda
>>>
>>> first? :)
>> Indeed it does, shame on me for overseeing that small detail. :)=20
>
> Oh... shame on me too.  :-)

Why didn't smartctl notice that?  In my experience it usually does
report when SMART is disabled.  Is the error not being properly
reported back to userspace maybe?  Tvrtko's original problem report
has lots of uninitialized (or leaked?) data, and a lot of it looks
like ASCII (for example his bogus RAW_VALUEs contain pieces of the
model number).

-jim
