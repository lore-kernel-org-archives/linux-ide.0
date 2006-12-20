From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata: clean up variable name usage in xlat related
 functions
Date: Wed, 20 Dec 2006 14:26:42 -0500
Message-ID: <45898E72.5040002@pobox.com>
References: <20061217014508.GG5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35076 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030370AbWLTT0s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Dec 2006 14:26:48 -0500
In-Reply-To: <20061217014508.GG5400@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Variable names in xlat functions are quite confusing now.  'scsicmd'
> is used for CDB while qc->scsicmd points to struct scsi_cmnd while
> 'cmd' is used for struct scsi_cmnd.
> 
> This patch cleans up variable names in xlat functions such that 'scmd'
> is used for struct scsi_cmnd and 'cdb' for CDB.  Also, 'scmd' local
> variable is added if qc->scsicmd is used multiple times.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Okay, separated as suggested and regenerated against
> libata-dev#upstream-fixes.

applied 1-3 to #upstream-fixes


