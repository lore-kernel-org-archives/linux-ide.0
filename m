From: jordanklist@yourcity.ca
Subject: (unknown)
Date: Sun,  2 Oct 2005 22:20:45 -0400
Message-ID: <20051002222045.axij3fw692skwkw0@www.yourcity.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pass19.dizinc.com ([72.29.74.75]:40320 "EHLO pass19.dizinc.com")
	by vger.kernel.org with ESMTP id S932127AbVJCCUd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Oct 2005 22:20:33 -0400
Received: from cpanel by pass19.dizinc.com with local (Exim 4.44)
	id 1EMFwb-0006Sc-QJ
	for linux-ide@vger.kernel.org; Sun, 02 Oct 2005 22:20:45 -0400
Subject: 
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am posting this with the hope that someone will revisit a bug that I have
found many people are experiencing with the PDC202xx_old driver.  The problem
is that whenever a drive is connected to each ide port, and the drives are put
under load, generally just sending an hdparm -d1 -c3 -X69 /dev/... once or
twice will do the trick.  I have read many posts and I believe archives of this
list saying it has been fixed.  I have applied patches that I've found, and I
have discovered that the problem still exists in 2.6.14-rc3.  If there is
anything I can do to help solve this issue, I will be more than happy to help.

Have a great day!

Jordan
