From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/12] libata-pmp: add PMP related constants, fields,
 ops and update helpers
Date: Wed, 19 Jul 2006 16:34:50 -0400
Message-ID: <44BE976A.1060709@pobox.com>
References: <1152338287794-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:4492 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030287AbWGSUe6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2006 16:34:58 -0400
In-Reply-To: <1152338287794-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add PMP related constants, fields and ops.  Also, update
> ata_class_enabled/disabled() such that PMP classes are considered.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

FWIW:

As I noted on IRC, for generic ATA and SATA constants (i.e. stuff 
mentioned in a specification somewhere), feel free to add these to an 
easy-to-merge "tj-easy" branch.

Newer SATA constants are just as welcome as new ATA constants.

	Jeff



