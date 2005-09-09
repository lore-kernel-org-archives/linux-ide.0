From: mreuther@umich.edu
Subject: Re: Promise 20378
Date: Fri, 09 Sep 2005 15:21:34 -0400
Message-ID: <20050909152134.24qevggbgg480ooo@engin.mail.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from penobscot.web.itd.umich.edu ([141.211.144.185]:47587 "EHLO
	penobscot.web.itd.umich.edu") by vger.kernel.org with ESMTP
	id S1030301AbVIITVn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Sep 2005 15:21:43 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Dibowitz <phil@ipom.com>
Cc: linux-ide@vger.kernel.org

Phil, there is a patch in Jeff Garzik's libata-dev patch queue to support PATA
on Promise SATA hosts. I haven't tried it out myself, but it may cover your
case.

Go to http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/ and grab the
latest patch for 2.4 or 2.6. If you grab 2.6.13-rc7-libata1.patch.bz2, it
applies cleanly to 2.6.13.

Please report back the results!

Best regards,
Matt
