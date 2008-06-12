From: Tejun Heo <htejun@gmail.com>
Subject: Re: Prevent busy looping
Date: Thu, 12 Jun 2008 22:43:29 +0900
Message-ID: <48512801.7090502@gmail.com>
References: <20080416151305.8788.63912.stgit@denkblock.local>	<20080416163152.GK12774@kernel.dk> <87r6d5l9pb.fsf@denkblock.local>	<20080417071335.GR12774@kernel.dk> <87ve2gc1bn.fsf@denkblock.local>	<484F7A8D.1040809@gmail.com> <20080611080502.4aa43980@core>	<484F86D4.8050907@gmail.com> <485092C9.3050309@gmail.com> <87d4mmubvf.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <87d4mmubvf.fsf@denkblock.local>
Sender: linux-scsi-owner@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@HansenPartnership.com>, Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Elias Oltmanns wrote:
> Since I'm a little confused by your comment, please explain again. Do
> you mean to say that busy looping doesn't lock up the machine in general
> or merely in the case of a simplex configuration?

It busy loops but it won't lock up as command completion is the loop
breaker and command completion comes via IRQ and the busy looping
doesn't happen solely in the IRQ context.  Still needs to be fixed tho.
 Anyways, this is only limited to ->qc_defer for simplex and the reason
why there's busy loop is because we're trying to schedule two
independent hosts and SCSI midlayer (of course) doesn't have the notion
of cross host deferring.

Thanks.

-- 
tejun
