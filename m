From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCHSET #upstream] block/libata: update and use block layer
	padding and draining
Date: Wed, 06 Feb 2008 17:31:29 -0600
Message-ID: <1202340689.3112.140.camel@localhost.localdomain>
References: <12021979851743-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:58638 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191AbYBFXbg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 18:31:36 -0500
In-Reply-To: <12021979851743-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, Jens.Axboe@oracle.com


On Tue, 2008-02-05 at 16:53 +0900, Tejun Heo wrote:
> This patchset updates block layer padding and draining support and
> make libata use it.  It's based on James Bottomley's initial work and,
> of the five, the last two patches are from James with some
> modifications.
> 
> Please read the following thread for more info.
> 
>   http://thread.gmane.org/gmane.linux.scsi/37185
> 
> This patchset is on top of
> 
>   upstream (a6af42fc9a12165136d82206ad52f18c5955ce87)
> + kill-n_iter-and-fix-fsl patch [1]

This certainly fixes the SATAPI panic on aic94xx (finally got the
machine with it plugged into the expanders to boot).

James


