From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: ata8.00: log page 10h reported inactive tag 0
Date: Thu, 18 Feb 2010 08:55:58 +0100
Message-ID: <87r5ojm0z5.fsf@nemi.mork.no>
References: <87y6isp4da.fsf@nemi.mork.no> <4B7C88EB.1040502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:34611 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240Ab0BRH4D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Feb 2010 02:56:03 -0500
Received: from nemi.mork.no (nemi.mork.no [IPv6:2001:16d8:ffb4:2:216:eaff:feb3:788])
	(authenticated bits=0)
	by canardo.mork.no (8.14.3/8.14.3) with ESMTP id o1I7tw26006844
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Thu, 18 Feb 2010 08:55:59 +0100
Received: from bjorn by nemi.mork.no with local (Exim 4.69)
	(envelope-from <bjorn@mork.no>)
	id 1Ni1Es-0007Az-LG
	for linux-ide@vger.kernel.org; Thu, 18 Feb 2010 08:55:58 +0100
In-Reply-To: <4B7C88EB.1040502@gmail.com> (Robert Hancock's message of "Wed,
	17 Feb 2010 18:25:15 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Robert Hancock <hancockrwd@gmail.com> writes:

> Well, that error indicates a read error on some sectors reported by
> the drive. This could be caused by a hard power-down in the middle of
> a write to those sectors - in that case, one can in principle use
> something like hdparm --write-sector to rewrite the sector
> correctly. However, it could also be due to a drive fault.

Thanks.


Bj=C3=B8rn
