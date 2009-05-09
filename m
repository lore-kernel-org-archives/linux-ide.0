From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] libata: fix suspend/resume for ATA SEMB devices
Date: Sat, 9 May 2009 17:13:48 +0200
Message-ID: <20090509151348.GA25760@liondog.tnic>
References: <20090426143836.GA3643@liondog.tnic> <49F4DFA9.6040805@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37141 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbZEIPNx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 11:13:53 -0400
Content-Disposition: inline
In-Reply-To: <49F4DFA9.6040805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 27, 2009 at 07:26:49AM +0900, Tejun Heo wrote:
> Borislav Petkov wrote:
> > due to a class mismatch in ata_dev_revalidate(). Fix it by adding the
> > ATA_DEV_SEMB device class to the check.
> > 
> > CC: Tejun Heo <htejun@gmail.com>
> > CC: Jeff Garzik <jeff@garzik.org>
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Hi Jeff,

any chance this can make it into 2.6.30?

-- 
Regards/Gruss,
    Boris.
