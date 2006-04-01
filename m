From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata: use AC_ERR_TIMEOUT err_mask for time out
Date: Fri, 31 Mar 2006 19:34:03 -0500
Message-ID: <442DCA7B.8070600@pobox.com>
References: <442CC185.3060200@tw.ibm.com> <442D4561.60705@pobox.com> <442D717A.7080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56522 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932379AbWDAAeG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 19:34:06 -0500
In-Reply-To: <442D717A.7080501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, IDE Linux <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> I think we must not successfully finish a qc after timeout. If a device 

OK fair enough, I'm convinced.

	Jeff


