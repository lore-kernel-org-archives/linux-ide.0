From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] libata: add ATA_HORKAGE_NOTRIM
Date: Wed, 15 Jul 2015 07:26:10 -0700
Message-ID: <20150715142610.GA2127@kroah.com>
References: <1436961277-4069-1-git-send-email-arne_f@ipfire.org>
 <1436961277-4069-2-git-send-email-arne_f@ipfire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40142 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbGOO0M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2015 10:26:12 -0400
Content-Disposition: inline
In-Reply-To: <1436961277-4069-2-git-send-email-arne_f@ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arne Fitzenreiter <arne_f@ipfire.org>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org

On Wed, Jul 15, 2015 at 01:54:36PM +0200, Arne Fitzenreiter wrote:
> Some devices lose data on TRIM whether queued or not.  This patch adds
> a horkage to disable TRIM.
> 
> Signed-off-by: Arne Fitzenreiter <arne_f@ipfire.org>
> ---
>  drivers/ata/libata-scsi.c      | 14 ++++++++------
>  drivers/ata/libata-transport.c |  2 ++
>  include/linux/libata.h         |  2 ++
>  3 files changed, 12 insertions(+), 6 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
