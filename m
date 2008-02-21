From: Tejun Heo <htejun@gmail.com>
Subject: Re: Regression: kernel 2.6.24{,.1} ahci problem, does not boot (resend)
Date: Thu, 21 Feb 2008 11:51:11 +0900
Message-ID: <47BCE71F.2000309@gmail.com>
References: <20080214184700.0bd3837d@highlander.home.lan>	<47B4D02E.9030101@gmail.com> <20080215191215.430ee2e0@highlander.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:45770 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYBUCvV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 21:51:21 -0500
Received: by wf-out-1314.google.com with SMTP id 28so806086wff.4
        for <linux-ide@vger.kernel.org>; Wed, 20 Feb 2008 18:51:17 -0800 (PST)
In-Reply-To: <20080215191215.430ee2e0@highlander.home.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TWFsdGUgU2NocsO2ZGVy?= <maltesch@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Malte Schr=C3=B6der wrote:
>> Does irqpoll kernel parameter help?
> =20
> No, problem stays.

Can you capture full boot log w/ irqpoll specified?  If you have root
filesystem connected to ahci, you'll probably have to use serial or
netconsole.  Also, please post full boot log from 2.6.23.11.

Thanks.

--=20
tejun
