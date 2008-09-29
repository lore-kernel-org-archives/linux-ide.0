From: Pascal Vandeputte <pascal@asmodeus.be>
Subject: Re: regarding frequent head unload problem
Date: Mon, 29 Sep 2008 23:12:17 +0200
Message-ID: <48E144B1.1070508@asmodeus.be>
References: <48E08B99.1070508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx-out.mail002.coreserver.be ([83.143.245.22]:38989 "EHLO
	mx-out.mail002.coreserver.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751377AbYI2VMT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 17:12:19 -0400
In-Reply-To: <48E08B99.1070508@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Ivan N. Zlatev" <contact@i-nz.net>, Robert Krawitz <rlk@alum.mit.edu>, Omar A <aliencoder@gmail.com>, Carlos Bessa <carlos.bessa@gmail.com>, Andy Vaselaar <andrew.vaselaar@trinity.edu>, webmaster@dragontower.de, Christian Wolf <wolfchri@gmail.com>, "A. Klitzing" <aklitzing@online.de>, Stefan Henriet <aladin7501-01@yahoo.de>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello,
>
> I'm writing to everyone who reported to me or linux-ide about frequent
> head unload problem and the report is not yet committed to
> storage-fixup.conf.
>
> I'm a bit worried about the explosion of reports because I really
> wanna avoid creating false entries as they will increase power
> consumption on Linux unnecessarily. [...]
Hi,

I understand your concern. It mainly comes down to how much earlier your
battery is drained I guess (without taking the "green" aspect into
account). Would anyone have any numbers on that? If not, we could do a
test ourselves (torturing our drives for a few hours extra,
percentage-wise the extra wear and tear is limited).

The amount of power saved will probably differ between drive
manufacturers & models as well. My gut feeling is that it won't make
that much of a difference, but it's indeed something to think about.

Greetings,

Pascal
