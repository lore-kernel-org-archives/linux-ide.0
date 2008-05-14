From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RESOLVED] Re: libata errors with smartctl on 2.6.24, WD3200AAKS
 and nVidia AHCI
Date: Wed, 14 May 2008 17:31:56 +0900
Message-ID: <482AA37C.1020604@gmail.com>
References: <alpine.BSF.1.00.0805140952250.34461@anduin.net> <200805140905.29426.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:25364 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899AbYENIcE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2008 04:32:04 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3740412rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 14 May 2008 01:32:02 -0700 (PDT)
In-Reply-To: <200805140905.29426.tvrtko@ursulin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Cc: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan-ide@anduin.net>, linux-ide@vger.kernel.org

Tvrtko A. Ursulin wrote:
> On Wednesday 14 May 2008 08:58:56 Erik Inge Bols=F8 wrote:
>> The drive does say
>>
>>         Enabled Supported:
>>                 SMART feature set
>>                 Security Mode feature set
>>            *    Power Management feature set
>>            *    Write cache
>>            *    Look-ahead
>>
>> ... so doesn't look like SMART is enabled on the drive.
>>
>> Does the problem go away if you do a
>>
>> smartctl -s on /dev/sda
>>
>> first? :)
>=20
> Indeed it does, shame on me for overseeing that small detail. :)=20

Oh... shame on me too.  :-)

--=20
tejun
