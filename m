From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: inline ata_qc_complete()
Date: Sat, 11 Feb 2006 17:53:39 -0500
Message-ID: <43EE6AF3.2060008@pobox.com>
References: <11395518482722-git-send-email-htejun@gmail.com> <43EC8077.4080003@pobox.com> <20060211061349.GA2905@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:54992 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750827AbWBKWx5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 17:53:57 -0500
In-Reply-To: <20060211061349.GA2905@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch inlines ata_qc_complete() and uninlines __ata_qc_complete()
> as suggested by Jeff Garzik.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> 
> Jeff, later EH patches might add one or two more condition tests to
> ata_qc_complete().  I don't know whether ata_qc_complete will still
> fit as an inline function after EH changes but if it doesn't, it
> should be converted then, I guess.  This patch is against the current
> upstream (489ff4c7d167be954f715128790bd80d3c888322).

applied


