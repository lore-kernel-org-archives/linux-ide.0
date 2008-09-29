From: Tejun Heo <tj@kernel.org>
Subject: Re: libata flooding syslog
Date: Mon, 29 Sep 2008 09:02:18 +0900
Message-ID: <48E01B0A.2060204@kernel.org>
References: <20080915100909.79c1d67b@werewolf.home> <20080919001834.31a3f8f9@werewolf.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45395 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792AbYI2ADp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Sep 2008 20:03:45 -0400
In-Reply-To: <20080919001834.31a3f8f9@werewolf.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?IkouQS4gTWFnYWxsw7NuIg==?= <jamagallon@ono.com>
Cc: Linux-IDE <linux-ide@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>

J.A. Magall=C3=B3n wrote:
> Hi,
>=20
> Any idea about this ?
> I have seen it also on ubuntu and arch lists...

Sorry about the delay.  I've been traveling for quite some time.  The
bug is being tracked via the following bugzilla bug and patch has been
posted.

  http://bugzilla.kernel.org/show_bug.cgi?id=3D11615

Thanks.

--=20
tejun
