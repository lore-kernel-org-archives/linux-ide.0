From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710,
 pcmcia based sata_sil24, PMP, and NCQ drive
Date: Tue, 29 Aug 2006 17:24:12 -0400
Message-ID: <44F4B07C.5060506@garzik.org>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com> <20060829045816.GA21746@geeks.org> <44F440BE.80000@gmail.com> <20060829164424.GA1603@geeks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:26254 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965405AbWH2VYQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2006 17:24:16 -0400
In-Reply-To: <20060829164424.GA1603@geeks.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derek Taubert <taubert@geeks.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

I wonder if writeback caching is disabled?

	Jeff



