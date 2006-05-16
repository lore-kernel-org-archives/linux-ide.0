From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 17:11:36 -0600
Message-ID: <311601c90605161611s28538eebu61f887609f6b32f4@mail.gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com>
	 <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com>
	 <446A1A21.80501@emc.com> <446A4721.3030506@emc.com>
	 <446A4BF5.7080006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:14947 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932274AbWEPXLh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 19:11:37 -0400
Received: by wr-out-0506.google.com with SMTP id i7so85742wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 16:11:37 -0700 (PDT)
In-Reply-To: <446A4BF5.7080006@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: ric@emc.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

On 5/16/06, Jeff Garzik <jeff@garzik.org> wrote:
> Ric Wheeler wrote:
> > But when I test with my synchronous write load, I am going at 6 times
> > the normal rate (i.e., the rate I see with barriers disabled) ;-)
>
> Well, NCQ read/write commands have a 'FUA' bit...  though maybe the NCQ
> code forgot to check the global libata_fua.
>
>         Jeff

Is the workload a sequential write?  SATA drives should be able to
keep up with the media if they use FUA for their consistency when
using NCQ.

Flush cache as a barrier mechanism will blow revs in sequential
workloads, especially using a write/flush write/flush technique.
