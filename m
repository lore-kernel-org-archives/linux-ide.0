From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/14] libata: always generate sense if qc->err_mask is
 non-zero
Date: Sat, 01 Apr 2006 15:02:45 -0500
Message-ID: <442EDC65.8000300@pobox.com>
References: <11438885163820-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50397 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751602AbWDAUCt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 15:02:49 -0500
In-Reply-To: <11438885163820-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Current sense generation code does not generate sense error if status
> register value doesn't indicate error condition.  However, LLDD's may
> indicate errors which 't show up in status register.  Completing such
> qc's without generating sense results in successful completion of
> failed commands.
> 
> Invoke ata_to_sense_error() regardless of status register if
> qc->err_mask is not zero such that ata_to_sense_error() generates
> default sense error.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 5-9


