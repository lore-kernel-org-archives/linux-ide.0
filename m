From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/14] libata: don't read TF directly from sense generation
 functions
Date: Sat, 01 Apr 2006 15:05:55 -0500
Message-ID: <442EDD23.9070206@pobox.com>
References: <11438885171262-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56541 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751618AbWDAUF7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 15:05:59 -0500
In-Reply-To: <11438885171262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> TF register might not be directly accessible depending on errors.
> e.g. TF of failed NCQ command is in log page 10h.  Make reading TF
> responsibility of error handlers.  For the current EH, simply push TF
> reading into qc completion functions as they are practically part of
> EH.  New EH will fill qc->tf with status registers before complting
> qcs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 10-14


