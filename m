From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/5] libata: check if port is disabled after internal
 command
Date: Fri, 24 Mar 2006 09:40:21 -0500
Message-ID: <442404D5.7050504@pobox.com>
References: <11431815303557-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40681 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751495AbWCXOkZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 09:40:25 -0500
In-Reply-To: <11431815303557-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> libata core is being changed to disallow port/device disable on lower
> layers.  However, some LLDDs (sata_mv) directly disable port on
> command failure.  This patch makes ata_exec_internal() check whether a
> port got disabled after an internal command.  If it is, AC_ERR_SYSTEM
> is added to err_mask and the port gets re-enabled.
> 
> As internal command failure results in device disable for drivers
> which don't implement newer reset/EH callbacks, this change results in
> no behavior change for single device per port controllers.  For
> slave-possible LLDDs which disable port on command failure, (1) such
> drivers don't exist currently, (2) issuing command to the other device
> of once-disabled port shouldn't result in catastrophe even if such
> driver exists.  So, this should be enough as a temporary measure.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-4


