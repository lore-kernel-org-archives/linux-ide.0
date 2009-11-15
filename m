From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement ATAPI_HORKAGE_NOPIO
   and apply it to GGW-H10N
Date: Sun, 15 Nov 2009 17:16:45 +0900
Message-ID: <4AFFB8ED.9050404@kernel.org>
References: <4857313A.1000405@kernel.org> <48573174.9050103@kernel.org> <20080617094354.338e186b@lxorguk.ukuu.org.uk> <48578080.5030605@kernel.org> <20080617095439.GA9359@lukeross.name> <20080617110450.668f37e2@lxorguk.ukuu.org.uk> <4857ADC3.3040106@kernel.org> <20080618114828.GB19903@lukeross.name> <4858F894.6030409@garzik.org> <4AFDF5A8.1050005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41167 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbZKOIQI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Nov 2009 03:16:08 -0500
In-Reply-To: <4AFDF5A8.1050005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Luke Ross <luke@lukeross.name>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

11/14/2009 09:11 AM, Robert Hancock wrote:
> Luke/Tejun, do you have some error output from those wodim or growisofs
> errors? It would be useful to know what commands those were that failed
> and whether they were also an unusual data size.

I don't have anything.  For some reason, ahci works fine on the setups
here.  :-(

I'm waiting for Dan's further report.  I still am not sure whether
we're actually seeing a lot of ahci ATAPI failures or it's just that a
lot of reports are on ahci because it's the most often used driver
now.  I don't think anything fundamental is broken.  The reports are
too infrequent for that to be true.  It might have something to do
with the buffer padding / draining we do or how the controller and
driver react.

Thanks.

-- 
tejun
