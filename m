From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: allow LLDs w/o any reset
 method
Date: Mon, 10 Mar 2008 20:53:05 -0400
Message-ID: <47D5D7F1.70605@garzik.org>
References: <47CF6E7E.6090201@gmail.com> <47D5D79B.8000508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50922 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbYCKAxH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Mar 2008 20:53:07 -0400
In-Reply-To: <47D5D79B.8000508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

BTW, nice work on patch #2 (make ctl optional).  That removed a 
stumbling block preventing support for a few esoteric platform IDE drivers.

	Jeff



