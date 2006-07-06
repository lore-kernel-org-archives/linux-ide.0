From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: cosmetic, replace ap_lock w/ ap->lock in ata_scsi_error()
Date: Wed, 05 Jul 2006 22:06:21 -0400
Message-ID: <44AC701D.4010107@pobox.com>
References: <20060702180215.GB6027@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32162 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965130AbWGFCGZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jul 2006 22:06:25 -0400
In-Reply-To: <20060702180215.GB6027@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ap_lock was used because &ap->host_set->lock was too long and used a
> lot.  Now that &ap->host_set->lock is replaced with ap->lock, there's
> no reason to keep ap_lock.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied, though I removed "cosmetic" from the subject line, and added 
this note to the changelog:

[ed. note: that's not entirely true.  ap_lock is a local variable,
caching the results of a de-ref.  In theory, if the compiler is smart
enough, this patch is cosmetic.  However, since this is not a fast
path (it is the error path), this patch is nonetheless acceptable,
even though it _may_ introduce a performance regression.]

