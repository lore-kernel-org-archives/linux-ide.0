From: Mark Lord <liml@rtr.ca>
Subject: Re: Problems w/ Sil3124 + Port Multiplier
Date: Wed, 02 May 2007 09:34:00 -0400
Message-ID: <46389348.1070809@rtr.ca>
References: <463828F6.7020209@jogback.se> <46388862.1020709@gmail.com> <4638928E.60700@jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3135 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993172AbXEBNeJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 May 2007 09:34:09 -0400
In-Reply-To: <4638928E.60700@jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@jogback.se>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Lars Michael Jogb=E4ck wrote:
> =20
> Is there a way that I can generate a FLUSH_CACHE event manually someh=
ow?

hdparm -W0 /dev/sda

** requires hdparm-7.3; earlier versions won't do **
http://sourceforge.net/project/showfiles.php?group_id=3D136732
