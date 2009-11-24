From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement ATAPI_HORKAGE_NOPIO
	and apply it to GGW-H10N
Date: Tue, 24 Nov 2009 09:50:03 -0700
Message-ID: <e9c3a7c20911240850t6001bce0ua951526061dadb28@mail.gmail.com>
References: <4857313A.1000405@kernel.org>
	 <20080617094354.338e186b@lxorguk.ukuu.org.uk>
	 <48578080.5030605@kernel.org> <20080617095439.GA9359@lukeross.name>
	 <20080617110450.668f37e2@lxorguk.ukuu.org.uk>
	 <4857ADC3.3040106@kernel.org> <20080618114828.GB19903@lukeross.name>
	 <4858F894.6030409@garzik.org> <4AFDF5A8.1050005@gmail.com>
	 <4AFFB8ED.9050404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f192.google.com ([209.85.212.192]:42522 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933443AbZKXQt6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Nov 2009 11:49:58 -0500
Received: by vws30 with SMTP id 30so1862243vws.33
        for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2009 08:50:04 -0800 (PST)
In-Reply-To: <4AFFB8ED.9050404@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jeff@garzik.org>, Luke Ross <luke@lukeross.name>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sun, Nov 15, 2009 at 1:16 AM, Tejun Heo <tj@kernel.org> wrote:
> I'm waiting for Dan's further report.

After pressing a bit more for details, the customer reports that they
have resolved the issue.  I was hoping to get details on the malformed
request that was being sent so that maybe the kernel could report an
error rather than silently dropping the initial command and timing out
a subsequent command... no such luck.

Thanks for the attention.

Regards,
Dan
