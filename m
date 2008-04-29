From: "Scott A. Conway" <misassistant@yahoo.com>
Subject: Status of NCQ for the Promise SATA 300 TX2Plus?
Date: Mon, 28 Apr 2008 21:21:17 -0700 (PDT)
Message-ID: <235005.30535.qm@web50608.mail.re2.yahoo.com>
Reply-To: misassistant@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web50608.mail.re2.yahoo.com ([206.190.38.95]:43191 "HELO
	web50608.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751319AbYD2E17 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Apr 2008 00:27:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mikpe@it.uu.se
Cc: linux-ide@vger.kernel.org

First, I want to thank you for producing working drivers for my card that not even Promise themselves could figure out how to make.
I tried several times to build their drivers from source, and they always fail with stupid errors.
I just wondered if an when you will build in Native Command Queue support, as the TX2Plus and my Maxtor SATA 300 500GB drive both support it in hardware.
I realize that NCQ is not the be-all end-all in enhancements, but it puzzles me that a three old driver still (apparently, unless I am leaving out a compile time parameter or kernel command line parameter) does not support it.
Oh, and if there is supposed to be a site or mailing list that I should be using instead of e-mailing here, I apologize, but it is nearly impossible to find a definitive site for the LIBATA/SATA development team.

Thanks,

-Scott


      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
