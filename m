From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 21:13:05 -0400
Message-ID: <446A78A1.3040307@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29085 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932394AbWEQBNJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 21:13:09 -0400
In-Reply-To: <446A734A.6020504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: ric@emc.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Tejun Heo wrote:
> * Those spurious FISes are actively setting the I bit requesting 
> interrupt explicitly.  Those are not innocent status update FISes.  And 

FWIW, most firmwares probably derive the value of 'I' directly from the 
nIEN bit.  In our situation, it would be unusual for 'I' to be cleared. 
  'I' is really irrelevant for advanced, FIS-based controllers in any case.

	Jeff


