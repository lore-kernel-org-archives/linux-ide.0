From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Date: Tue, 15 Nov 2005 22:48:27 -0500
Message-ID: <437AAC0B.80106@rtr.ca>
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379E5F7.6000107@gmail.com> <4379EC82.1030509@pobox.com> <437AA1A0.6080409@gmail.com> <437AA51A.6000709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:48273 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965221AbVKPDs3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2005 22:48:29 -0500
In-Reply-To: <437AA51A.6000709@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Jeff Garzik wrote:
>
> My setup works without it, successfully burning CDs and DVDs, but has 
> problems with really long commands, and such those which occur when 
> cdrecord(1) finishes a CD burn, and performs its "fixating" step.

Is this just a case of too-short of a SCSI timeout on CLOSE_TRACK?
Drivers I have worked on for this generally apply a 2 minute timeout
for that particular operation, and never have to retry.

Cheers
