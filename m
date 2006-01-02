From: Mark Lord <lkml@rtr.ca>
Subject: Re: Kernel panic with 2.6.15-rc7 + libata1 patch
Date: Mon, 02 Jan 2006 09:06:45 -0500
Message-ID: <43B93375.1020701@rtr.ca>
References: <43B724BA.90405@bj-ig.de> <43B7EA0A.7040805@bj-ig.de>	<20060101145702.GV3811@stusta.de> <43B806C7.5000607@bj-ig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:37811 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750736AbWABOGt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jan 2006 09:06:49 -0500
In-Reply-To: <43B806C7.5000607@bj-ig.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Ralf M=FCller wrote:
>
> A further problem is that calling "hdparm -C" _always_ give "drive st=
ate=20
> is:  standby" - even when the disks are clearly active. Maybe this=20
> indicates something to you.

MMmm.. yes, it does that here, too.
This is probably a bug somewhere in the libata passthru code,
or in the HDIO_* translation code.

Cheers
