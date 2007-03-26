From: Tejun Heo <htejun@gmail.com>
Subject: Re: Wrong IDE cable detection in libata [Re: 2.6.21-rc4-mm1]
Date: Mon, 26 Mar 2007 20:01:52 +0900
Message-ID: <4607A820.60103@gmail.com>
References: <20070319205623.299d0378.akpm@linux-foundation.org> <20070326022420.224cc4f2@werewolf-wl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:10995 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965148AbXCZLB7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Mar 2007 07:01:59 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1460341wra
        for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 04:01:58 -0700 (PDT)
In-Reply-To: <20070326022420.224cc4f2@werewolf-wl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

J.A. Magall=F3n wrote:
> Libata seems to misdetect my cable.
> I have double-checked and the cable is 80 pin...

Does the following patch fix your problem?

  http://article.gmane.org/gmane.linux.ide/17444

(You can get the raw message by appending /raw to the URL).

--=20
tejun
