From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc7] libata: fix assigned IRQ reporting
Date: Wed, 04 Jul 2007 14:46:58 +0900
Message-ID: <468B3452.6040509@gmail.com>
References: <20070702163847.GV29122@htj.dyndns.org> <20070702214747.GA23182@electric-eye.fr.zoreil.com> <4689A432.6080104@gmail.com> <20070703222205.GA18532@electric-eye.fr.zoreil.com> <468B3126.3080706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:45186 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbXGDFwG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 01:52:06 -0400
Received: by py-out-1112.google.com with SMTP id u77so3663334pyb
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 22:52:05 -0700 (PDT)
In-Reply-To: <468B3126.3080706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Francois Romieu wrote:
>> I have rebuilt on top of 872aad45d6174570dd2e1defc3efee50f2cfcc72 and it
>> still seems bizarre:

Okay, 872aad45 doesn't have the patch yet.  Either apply the patch
manually or you need to wait a bit more.

-- 
tejun
