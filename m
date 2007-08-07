From: Kristoffer Nyborg Gregertsen <gregerts@stud.ntnu.no>
Subject: Re: [PATCH 1/1] AVR32 PATA driver
Date: Tue, 7 Aug 2007 20:26:35 +0200
Message-ID: <200708072026.35366.gregerts@stud.ntnu.no>
References: <200708071126.08735.kngregertsen@norway.atmel.com> <200708071939.34266.gregerts@stud.ntnu.no> <46B8B683.6060000@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from merke.itea.ntnu.no ([129.241.7.61]:40503 "EHLO
	merke.itea.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbXHGS0g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 14:26:36 -0400
In-Reply-To: <46B8B683.6060000@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>, linux-ide@vger.kernel.org, gregerts@stud.ntnu.no

On Tuesday 07 August 2007 20:14:27 Jeff Garzik wrote:
> Well, a higher level issue, you should not have a max_pio module
> parameter at all.  Other drivers do not have such a thing.

OK, I'll remove it then. It was very convenient during automated testing of 
all PIO modes, but I guess that's not needed by the end users.
-- 
With kind regards

Kristoffer Nyborg Gregertsen

Student, Department of Engineering Cybernetics
Norwegian University of Science and Technology
Trondheim, Norway
